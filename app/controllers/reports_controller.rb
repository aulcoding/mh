class ReportsController < ApplicationController

  def index
    @classrooms = Classroom.all
  end


  def step_one
    @classrooms = Classroom.all

  end


  def step_one_submit
    session[:step_one_data] = {
      year: params[:year],
      month: params[:month],
      classroom: params[:classroom]
    }


    puts session[:step_one_data].inspect
    redirect_to step_two_reports_path
  end

  def step_two
    # Retrieve session data from step one
    puts "Session data: #{session[:step_one_data].inspect}"
    puts "This is inspect of step_one_data"
    puts session[:step_one_data].inspect
    puts "Year: #{session[:step_one_data]['year']}"

    # I'm not using step_one_data, but I want
    step_one_data = session[:step_one_data]
    # @year = session[:step_one_data]['year']
    # @month = session[:step_one_data]['month']
    # @classroom = Classroom.find(step_one_data[:classroom])
    # @classroom = session[:step_one_data]['classroom']
    @year = step_one_data['year']
    @month = step_one_data['month']
    @classroom = step_one_data['classroom']
    puts "berhasil"

    # Fetch students in the selected classroom for the given year and semester
    classroom_students = ClassroomStudent.where(classroom_id: @classroom, year: @year)

    # Prepare attendance data
    @attendance_data = classroom_students.map do |classroom_student|
      student = classroom_student.student
      # Fetch the most recent Ziyadah session for the student
      last_ziyadah_session = ClassroomSession
                               .where(classroom_student_id: classroom_student.id)
                               .where("session_date <= ?", Date.new(@year.to_i, @month.to_i, -1))
                               .order(session_date: :desc)
                               .first

      # Separate Ziyadah and Ziyadah Parent
      ziyadah_name = last_ziyadah_session&.ziyadah&.name || "No record"
      ziyadah_parent_name = last_ziyadah_session&.ziyadah&.parent&.name || "No Parent"

      # Count the attendance statuses for the student
      attendance_counts = ClassroomSession
                            .where(classroom_student_id: classroom_student.id)
                            .group(:attendance_status_id)
                            .count

      {
        name: student.name,
        ziyadah: ziyadah_name,
        ziyadah_parent: ziyadah_parent_name,
        total_sakit: attendance_counts[AttendanceStatus.find_by(name: "Sakit")&.id] || 0,
        total_izin: attendance_counts[AttendanceStatus.find_by(name: "Izin")&.id] || 0,
        total_alpa: attendance_counts[AttendanceStatus.find_by(name: "Alpa")&.id] || 0,
        total_hadir: attendance_counts[AttendanceStatus.find_by(name: "Hadir")&.id] || 0
      }
    end
  end
      # session_date: Date.new(step_one_data['year'].to_i, step_one_data['month'].to_i)..Date.new(step_one_data['year'].to_i, step_one_data['month'].to_i).end_of_month



end
