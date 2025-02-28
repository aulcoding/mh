class BulkClassroomSessionsController < ApplicationController
  def new
    if session[:step_one_data].blank?
      @classrooms = Classroom.order(:name)
      @teachers = Teacher.order(:name)
      render :step_one
    else
      load_step_two_data
      render :step_two
    end
  end

  def create
    if session[:step_one_data].blank?
      session[:step_one_data] = step_one_params
      redirect_to new_bulk_classroom_session_path
      return
    end

    @classroom_sessions = []
    error_message = nil

    ActiveRecord::Base.transaction do
      classroom_session_params.each do |session_params|
        classroom_session = ClassroomSession.new(session_params)
        unless classroom_session.save
          error_message = 'Terjadi kesalahan saat membuat classroom session.'
          raise ActiveRecord::Rollback
        end
        @classroom_sessions << classroom_session
      end
    end

    if error_message.nil?
      session.delete(:step_one_data)
      redirect_to classroom_sessions_path, notice: 'Classroom sessions berhasil dibuat.'
    else
      flash.now[:alert] = error_message
      load_step_two_data
      render :step_two
    end
  end

  def filter_surah
    juz_number = params[:juz]
    @surahs = Manuscript.filter_surahs_by_juz(juz_number)

    if @surahs.present?
      render json: @surahs.select(:id, :name)
    else
      render json: []
    end
  end

  private

  def step_one_params

    params.permit(:year, :semester, :teacher_id, :classroom_id, :session_date)
  end

  def classroom_session_params
    params.require(:classroom_sessions).map do |_, session_params|
      session_params.permit(
        :classroom_student_id, :teacher_id, :session_date,
        :year, :semester, :attendance_status_id, :attendance_remarks,
        :ziyadahSurahStart, :ziyadah_start, :ziyadahSurahEnd, :ziyadah_end,
        :murajaahSurahStart, :murajaah_start, :murajaahSurahEnd, :murajaah_end
      )
    end
  end


  def load_step_two_data
    step_one_data = session[:step_one_data]
    @session_date = step_one_data['session_date']
    @classroom_students = ClassroomStudent.where(
      classroom_id: step_one_data['classroom_id'],
      year: step_one_data['year'],
      semester: step_one_data['semester']
    )

    # here's the controller method
    # @surahs will change depends on selected radio
    @surahs = Manuscript.first.children.where.not("name LIKE ?", "Juz%").order(id: :desc)
    @attendance_statuses = AttendanceStatus.all
    @classroom_sessions = @classroom_students.map do |student|
      ClassroomSession.new(
        classroom_student_id: student.id,
        teacher_id: step_one_data['teacher_id'],
        session_date: step_one_data['session_date'],
        year: step_one_data['year'],
        semester: step_one_data['semester']
      )
    end
  end
end
