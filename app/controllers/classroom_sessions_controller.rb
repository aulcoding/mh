class ClassroomSessionsController < ApplicationController
  before_action :set_classroom_session, only: [:update, :edit, :destroy]

  def new
    if session[:step_one_data].blank?
      @classrooms = Classroom.order(:name)
      @teachers = Teacher.order(:name)

      render :step_one
    else
      step_one_data = session[:step_one_data]
      @session_date = step_one_data['session_date']
      year = step_one_data['year'].to_i
      semester = step_one_data['semester'].to_i
      teacher_id = step_one_data['teacher_id'].to_i
      classroom_id = step_one_data['classroom_id'].to_i
      session_date = step_one_data['session_date']

      # Fetch students in the selected classroom for the year and semester
      @classroom_students = ClassroomStudent.where(
        classroom_id: classroom_id, year: year, semester: semester
      )
      @surahs = Manuscript.first.children.where.not("name LIKE ?", "Juz%")
      @attendance_statuses = AttendanceStatus.all
      puts "Surahs: #{@surahs.inspect}"
      @classroom_sessions = @classroom_students.map do |classroom_student|
        ClassroomSession.new(
          classroom_student_id: classroom_student.id,
          teacher_id: teacher_id,
          session_date: session_date,
          year: year,
          semester: semester
        )
      end

      render :step_two
    end
  end

  def create
    if session[:step_one_data].blank?
      session[:step_one_data] = {
        year: params[:year],
        semester: params[:semester],
        teacher_id: params[:teacher_id],
        classroom_id: params[:classroom_id],
        session_date: params[:session_date]
      }

      redirect_to new_classroom_session_path
    else
      @classroom_sessions = []
      error_message = nil

      classroom_session_params.each.with_index do |session_params, index|
        classroom_session = ClassroomSession.create(session_params)

        # check classroom_session success atau failed
        # handle error or success
        unless classroom_session.persisted?
          error_message = 'Error creating classroom sessions.'

          break
        end

        @classroom_sessions << classroom_session
      end

      if error_message.nil?
        redirect_to classroom_sessions_path, notice: 'Classroom sessions were successfully created.'
      else
        render :new, alert: error_message
        puts "error"
      end
    end
  end

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
    # pindahkan ke ClassroomStudentsController#index

    # Query for ClassroomSessions with eager loading
    @classroom_sessions = ClassroomSession.joins(classroom_student: :classroom)
                                          .where(
                                            classroom_students: {
                                            classroom_id: params[:classroom_id]
                                            },
                                            session_date: params[:date]
                                            )
                                          .includes(classroom_student: :student, ziyadah: :parent)


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
    @ziyadah_start = Manuscript.find_by(id: @classroom_session.ziyadah_start)
    @murajaah_start = Manuscript.find_by(id: @classroom_session.murajaah_start)
    @ziyadahSurahStart = Manuscript.find_by(id: @ziyadah_start&.parent_manuscript_id)
    @murajaahSurahStart = Manuscript.find_by(id: @murajaah_start&.parent_manuscript_id)
    @ziyadah_end = Manuscript.find_by(id: @classroom_session.ziyadah_end)
    @murajaah_end = Manuscript.find_by(id: @classroom_session.murajaah_end)
    @ziyadahSurahEnd = Manuscript.find_by(id: @ziyadah_end&.parent_manuscript_id)
    @murajaahSurahEnd = Manuscript.find_by(id: @murajaah_end&.parent_manuscript_id)
    @attendance_statuses = AttendanceStatus.all
    @surahs = Manuscript.first.children.where.not("name LIKE ?", "Juz%")
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
    # pindahin ke ClassroomStudentsController#index dan gunakan method filter_by
    # dari model
    classroom = params[:classroom_id]
    year = params[:year]
    semester = params[:semester]
    students = ClassroomStudent
              .includes(:student)
              .where(classroom_id: classroom, year: year, semester: semester)
              .map(&:student)

    render json: { students: students.map { |student| { id: student.id, name: student.name } } }
  end

  def step_one
    @classrooms = Classroom.order(:name)
    @teachers = Teacher.order(:name)
  end

  def step_one_submit

    session[:step_one_data] = {
      year: params[:year],
      semester: params[:semester],
      teacher_id: params[:teacher_id],
      classroom_id: params[:classroom_id],
      session_date: params[:session_date]
    }
    redirect_to step_two_classroom_sessions_path
  end



  def step_two # method "new"
    step_one_data = session[:step_one_data]
    @session_date = step_one_data['session_date']
    year = step_one_data['year'].to_i
    semester = step_one_data['semester'].to_i
    teacher_id = step_one_data['teacher_id'].to_i
    classroom_id = step_one_data['classroom_id'].to_i
    session_date = step_one_data['session_date']

    # Fetch students in the selected classroom for the year and semester
    @classroom_students = ClassroomStudent.where(
      classroom_id: classroom_id, year: year, semester: semester
    )
    @surahs = Manuscript.first.children.where.not("name LIKE ?", "Juz%")
    @attendance_statuses = AttendanceStatus.all
    puts "Surahs: #{@surahs.inspect}"
    @classroom_sessions = @classroom_students.map do |classroom_student|
      ClassroomSession.new(
        classroom_student_id: classroom_student.id,
        teacher_id: teacher_id,
        session_date: session_date,
        year: year,
        semester: semester
      )
    end
  end

  def ziyadahVerses_by_surah
    verses = Manuscript.find(params[:surah_id]).children
    render json: { verses: verses.select(:id, :name) }
  end

  def murajaahVerses_by_surah
    verses = Manuscript.find(params[:surah_id]).children
    # puts verses
    render json: { verses: verses.select(:id, :name) }
  end

  def step_two_submit # method "create"
    @classroom_sessions = []
    error_message = nil

    classroom_session_params.each.with_index do |session_params, index|
      classroom_session = ClassroomSession.create(session_params)

      # check classroom_session success atau failed
      # handle error or success
      unless classroom_session.persisted?
        error_message = 'Error creating classroom sessions.'

        break
      end

      @classroom_sessions << classroom_session
    end

    if error_message.nil?
      redirect_to classroom_sessions_path, notice: 'Classroom sessions were successfully created.'
    else
      render :new, alert: error_message
      puts "error"
    end
  end



  private

  def classroom_session_params
    params.require(:classroom_sessions).to_unsafe_h.map do |_, session_params, index|
      ActionController::Parameters.new(session_params).permit(
        :classroom_student_id,
        :teacher_id,
        :session_date,
        :year,
        :semester,
        :ziyadah_start,
        :murajaah_start,
        :ziyadah_end,
        :murajaah_end,
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
      :ziyadah_start,
      :murajaah_start,
      :ziyadah_end,
      :murajaah_end,
      :attendance_status_id,
      :attendance_remarks
    )
  end
end