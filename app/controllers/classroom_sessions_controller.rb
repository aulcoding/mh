class ClassroomSessionsController < ApplicationController
  before_action :set_classroom_session, only: [:update, :edit, :destroy]

  def index
    @classroom_sessions = ClassroomSession.all
    @classrooms = Classroom.all
    @classroom_count = Classroom.count
    @student_count = Student.count
    @classroom_students = ClassroomStudent.all
    @grouped_classroom_students = ClassroomStudent
                                      .includes(:classroom, :student)
                                      .group_by { |cs| [cs.year, cs.semester] }
  end

  def edit_sessions
    @classroom_session = ClassroomSession.new
    @classroom_students = ClassroomStudent.all
    @classrooms = Classroom.order(:name)
    @students = [] # Initially empty; students are fetched dynamically
  end


  def students_edit
    # Query for ClassroomSessions with eager loading
    @classroom_sessions = ClassroomSession.joins(classroom_student: :classroom)
                                          .where(classroom_students: { classroom_id: params[:classroom_id] }, session_date: params[:date])
                                          .includes(classroom_student: :student, ziyadah: :parent)

    # Debugging log
    puts @classroom_sessions.inspect

    # Render as JSON with nested associations
    render json: @classroom_sessions.as_json(
      include: {
        classroom_student: {
          include: :student
        },
        ziyadah: {
          only: [:id, :name],
          include: {
            parent: {
              only: [:id, :name]
            }
          }
        }
      }
    )
  end


  def create
    @classroom_session = ClassroomStudent.new(classroom_student_params)
    if @classroom_student.save
      redirect_to classroom_students_path, notice: 'Student successfully added to the classroom.'
      puts "BERHASIL"
    else
      @classrooms = Classroom.all
      @students = Student.where(gender_id: @classroom_student.classroom.gender_id) if @classroom_student.classroom.present?
      render :new
    end
  end

  def edit
    puts params
    @classroom_session = ClassroomSession.find(params[:id])
    @ziyadah = Manuscript.find_by(id: @classroom_session.ziyadah_id)
    @murajaah = Manuscript.find_by(id: @classroom_session.murajaah_id)
    @ziyadahSurah = Manuscript.find_by(id: @ziyadah&.parent_manuscript_id)
    @murajaahSurah = Manuscript.find_by(id: @murajaah&.parent_manuscript_id)
    puts "lopopo"
    # puts @murajaah.inspect
    # puts @murajaah.parent.inspect
    @attendance_statuses = AttendanceStatus.all
    @surahs = Manuscript.find(6986).children.where.not("name LIKE ?", "Juz%")
    # @murajaahSurahs = Manuscript.find(6986).children.where.not("name LIKE ?", "Juz%")
    # @classroom_session = ClassroomSession.find(params[:id])
    # puts @classroom_session.inspect
    # puts params[:id]
  end

  def update
    puts "Ini update"
    puts @classroom_session.inspect
    if @classroom_session.update(edit_classroom_params)
      redirect_to classroom_sessions_path, notice: 'Classroom was successfully updated.'
    else
      render :edit
    end
  end

  def destroy

  end

  def students_by_year_and_semester
    puts 'kokok'
    classroom = params[:classroom_id]
    year = params[:year]
    semester = params[:semester]
    students = ClassroomStudent
              .includes(:student)
              .where(classroom_id: classroom, year: year, semester: semester)
              .map(&:student)

    students.each do |student|
      puts "yeye"
      puts student.name.class
    end

    if students
      puts students.class
    else
      print 'kosong'
    end

    render json: { students: students.map { |student| { id: student.id, name: student.name } } }
  end

  def step_one
    @classrooms = Classroom.order(:name)
    @teachers = Teacher.order(:name)
  end

  def step_one_submit
    Rails.logger.info "Params: #{params.inspect}" # Debugging

    # Extract session_date components from the nested hash
    # session_date_params = params[:session_date]

    # if session_date_params
    #   begin
    #     session_date = Date.new(
    #       session_date_params["session_date(1i)"].to_i,
    #       session_date_params["session_date(2i)"].to_i,
    #       session_date_params["session_date(3i)"].to_i
    #     )
    #   rescue ArgumentError
    #     session_date = nil
    #     Rails.logger.error "Invalid session date: invalid date"
    #   end
    # else
    #   session_date = nil
    #   Rails.logger.error "Session date params missing!"
    # end

    # Save the selected attributes in session
    puts "Ini session"
    puts session.class
    session[:step_one_data] = {
      year: params[:year],
      semester: params[:semester],
      teacher_id: params[:teacher_id],
      classroom_id: params[:classroom_id],
      session_date: params[:session_date]
    }


    puts params[:session_date]
    Rails.logger.info "Step One Data: #{session[:step_one_data].inspect}" # Debugging

    redirect_to step_two_classroom_sessions_path
  end



  def step_two
    # Retrieve data from session
    step_one_data = session[:step_one_data]
    # puts step_one_data.inspect
    @session_date = step_one_data['session_date']

    puts "Step One Data: #{step_one_data.inspect}"
    year = step_one_data['year'].to_i
    semester = step_one_data['semester'].to_i
    teacher_id = step_one_data['teacher_id'].to_i
    classroom_id = step_one_data['classroom_id'].to_i
    session_date = step_one_data['session_date']

    # Fetch students in the selected classroom for the year and semester
    @classroom_students = ClassroomStudent.where(classroom_id: classroom_id, year: year, semester: semester)

    puts "Year: #{year}, Semester: #{semester}, Classroom ID: #{classroom_id}" # Check query values
    puts "Classroom Students Query: #{ClassroomStudent.where(classroom_id: classroom_id, year: year, semester: semester).to_sql}" # Show generated SQL query
    @surahs = Manuscript.find(6986).children.where.not("name LIKE ?", "Juz%")
    @attendance_statuses = AttendanceStatus.all
    puts "Surahs: #{@surahs.inspect}"
    # Prebuild ClassroomSession records for each student
    @classroom_sessions = @classroom_students.map do |classroom_student|
      ClassroomSession.new(
        classroom_student_id: classroom_student.id,
        teacher_id: teacher_id,
        session_date: session_date,
        year: year,
        semester: semester
      )
    end



  puts "Classroom Sessions: #{@classroom_sessions.inspect}"
  end

  def ziyadahVerses_by_surah
    verses = Manuscript.find(params[:surah_id]).children
    puts ",asil"
    # puts verses
    render json: { verses: verses.select(:id, :name) }
  end

  def murajaahVerses_by_surah
    verses = Manuscript.find(params[:surah_id]).children
    # puts verses
    render json: { verses: verses.select(:id, :name) }
  end

  def step_two_submit
   # Debugging output
    puts "Classroom Sessions Params:"
    puts params[:classroom_sessions].inspect
    @classroom_sessions = []

    classroom_session_params.each.with_index do |session_params, index|
      puts "ini session_params"
      puts session_params
      puts session_params.class
      puts "Ini index di sumbit two = #{index}"
      classroom_session = ClassroomSession.create!(session_params)
      @classroom_sessions << classroom_session
      puts "hallo"
      puts @classroom_sessions
    end

    if @classroom_sessions.all?(&:persisted?)
      redirect_to classroom_sessions_path, notice: 'Classroom sessions were successfully created.'
    else
      render :new, alert: 'Error creating classroom sessions.'
      puts "error"
    end
  end



  private

  def classroom_session_params
    puts "Jeroan params"
    puts params.class
    params.require(:classroom_sessions).to_unsafe_h.map do |_, session_params, index|
      puts "Ini index di PRIVATE METHOD = #{index}"
      puts "session params didalam private method"
      puts session_params
      ActionController::Parameters.new(session_params).permit(
        :classroom_student_id,
        :teacher_id,
        :session_date,
        :year,
        :semester,
        :ziyadah_id,
        :murajaah_id,
        :attendance_status_id,
        :attendance_remarks
      )
    end
  end

  def set_classroom_session
    @classroom_session = ClassroomSession.find_by(id: params[:id])
    unless @classroom_session
      redirect_to classroom_sessions_path, alert: 'Classroom session not found.'
    end
  end

  def edit_classroom_params
    params.require(:classroom_session).permit(
      :classroom_student_id,
      :teacher_id,
      :session_date,
      :year,
      :semester,
      :ziyadah_id,
      :murajaah_id,
      :attendance_status_id,
      :attendance_remarks
    )
  end
end


# Ku coba gapai apa yang kau ingin /
# Saat ku terjatuh sakit / kau adalah aspirin
# Coba menuntunmu agar / ada di dalam track
# Kau / catatan terindah di dalam teks
# Dan aku mengerti / apa yang kau mau,
# hargai dirimu, menjadi imammu
# Karna kau diciptakan dari tulang rusukku /
# selain itu karna kau bagian dariku.