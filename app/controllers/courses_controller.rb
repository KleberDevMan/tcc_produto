class CoursesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  before_action :set_course, only: [:show, :edit, :update, :destroy, :toggle_status]

  # GET /courses
  # GET /courses.json
  def index
    @courses = Course.order('updated_at desc').page params[:page]
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(course_params)

    respond_to do |format|
      if @course.save
        format.html { redirect_to courses_path, notice: t('notice.created') }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to courses_path, notice: t('notice.updated') }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: t('notice.excluded') }
      format.json { head :no_content }
    end
  end

  def toggle_status
    if @course.status.inactive?
      if @course.update(status: :active)
        redirect_to courses_url, notice: t('notice.activated')
      end
    elsif @course.status.active?
      if @course.update(status: :inactive)
        redirect_to courses_url, notice: t('notice.disabled')
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def course_params
      params.require(:course).permit(:name, :status)
    end
end
