class ClassroomsController < ApplicationController
  before_action :set_classroom, only: %i[show edit update destroy]

  # GET /classrooms
  def index
    @classrooms = Classroom.order("name")
  end

  # GET /classrooms/:id
  def show
  end

  # GET /classrooms/new
  def new
    @classroom = Classroom.new
  end

  # POST /classrooms
  def create
    @classroom = Classroom.new(classroom_params)
    if @classroom.save
      redirect_to @classroom, notice: 'Classroom was successfully created.'
    else
      render :new
    end
  end

  # GET /classrooms/:id/edit
  def edit
  end

  # PATCH/PUT /classrooms/:id
  def update
    if @classroom.update(classroom_params)
      redirect_to @classroom, notice: 'Classroom was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /classrooms/:id
  def destroy
    @classroom.destroy
    redirect_to classrooms_url, notice: 'Classroom was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_classroom
    @classroom = Classroom.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def classroom_params
    params.require(:classroom).permit(:level_id, :gender_id, :name)
  end
end
