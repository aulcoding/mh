class ClassroomDetailsController < ApplicationController
  before_action :set_teacher, only: %i[show edit update destroy]

  # GET /teachers
  def index
    @teachers = Teacher.all
  end

  # GET /teachers/:id
  def show
  end

  # GET /teachers/new
  def new
    @teacher = Teacher.new
  end

  # POST /teachers
  def create
    @teacher = Teacher.new(teacher_params)
    if @teacher.save
      redirect_to @teacher, notice: 'Teacher was successfully created.'
    else
      render :new
    end
  end

  # GET /teachers/:id/edit
  def edit
  end

  # PATCH/PUT /teachers/:id
  def update
    if @teacher.update(teacher_params)
      redirect_to @teacher, notice: 'Teacher was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /teachers/:id
  def destroy

    if @teacher.destroy
      redirect_to teachers_path, notice: 'Teacher was succesfully removed.'
    else
      render :show
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_teacher
    @teacher = Teacher.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def teacher_params
    params.require(:teacher).permit(:name, :gender_id)
  end
end
