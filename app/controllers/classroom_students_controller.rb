class ClassroomStudentsController < ApplicationController
  before_action :set_classroom_student, only: [:edit, :update]

  def index
    @classroom_count = Classroom.count
    @student_count = Student.count
    @classroom_students = ClassroomStudent.all
    @grouped_classroom_students = ClassroomStudent
                                      .includes(:classroom, :student)
                                      .group_by { |cs| [cs.year, cs.semester] }

  end

  def new
    @classroom_student = ClassroomStudent.new
    @classrooms = Classroom.order(:name)
    @students = [] # Initially empty; students are fetched dynamically
  end

  def create
    @classroom_student = ClassroomStudent.new(classroom_student_params)
    if @classroom_student.save
      redirect_to classroom_students_path, notice: 'Student successfully added to the classroom.'
      puts "BERHASIL"
    else
      @classrooms = Classroom.all
      @students = Student.where(gender_id: @classroom_student.classroom.gender_id) if @classroom_student.classroom.present?
      render :new
    end
  end

  def edit_classroom
    @classrooms = Classroom.all
    # puts params[:year]
  end

  def students_by_class_year_semester
    year = params[:year]
    semester = params[:semester]
    classroom_id = params[:classroom]
    puts "errors"
    classroom_students = ClassroomStudent
                          .includes(:student, :classroom)
                          .where(classroom_id: classroom_id, year: year, semester: semester)


    puts classroom_students.inspect
    render json: classroom_students.as_json(
      only: [:id, :year, :semester],
      include: {
        student: { only: [:name] },
        classroom: { only: [:name] }
      }
    )
  end

  def edit
    @classroom_student = ClassroomStudent.find(params[:id])
    @classrooms = Classroom.all

    # Fetch students associated with the selected classroom via classroom_students
    @students = Student.joins(:classroom_students)
                       .where(classroom_students: { classroom_id: @classroom_student.classroom_id })
  end


  # PATCH/PUT /classroom_students/:id
  def update
    puts "update trigerred"
    puts params
    if @classroom_student.update(classroom_student_params)
      redirect_to classroom_students_path, notice: "Classroom student updated successfully."
    else
      flash.now[:alert] = "Failed to update classroom student."
      render :edit
    end
  end


  def destroy
    @classroom_student = ClassroomStudent.find(params[:id])
    @classroom_student.destroy
    head :no_content # Respond with 204 No Content
  end


  def students_by_classroom
    puts 'kokok'
    classroom = Classroom.find(params[:classroom_id])
    students = Student.where(gender_id: classroom.gender_id)
    puts students
    render json: { students: students.select(:id, :name) }
  end

  private

  # Find the classroom student
  def set_classroom_student
    @classroom_student = ClassroomStudent.find(params[:id])
  end

  # Strong parameters
  def classroom_student_params
    params.require(:classroom_student).permit(:year, :semester, :classroom_id, :student_id)
  end

end
