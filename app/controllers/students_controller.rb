class StudentsController < ApplicationController
  before_action :set_student, only: %i[show edit update destroy]

  # GET /students
  def index
    @students = Student.order(:name)
  end


  # GET /students/new
  def new
    @student = Student.new
  end

  # POST /students
  def create
    @student = Student.new(student_params)

    if @student.save
      redirect_to students_path, notice: 'Berhasil membuat murid'
    else
      render :new
    end
  end


  # GET /classrooms/:id/edit
  def edit
  end

  # PATCH/PUT /classrooms/:id
  def update
    if @student.update(student_params)
      redirect_to students_path, notice: 'Berhasil update murid!'
    else
      render :edit
    end
  end

  def destroy
    @student.destroy
    redirect_to students_path, notice: 'Berhasil ngapus Murid'
  end



  private


  # Use callback to share common setup or contstraints between actions.
  def set_student
    @student = Student.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def student_params
    params.require(:student).permit(:name, :nickname, :gender_id, :birthdate)
  end

end
