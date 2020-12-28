class AcademicWorksController < ApplicationController
  before_action :set_academic_work, only: [:show, :edit, :update, :destroy]

  # GET /academic_works
  # GET /academic_works.json
  def index
    @academic_works = AcademicWork.all
  end

  # GET /academic_works/1
  # GET /academic_works/1.json
  def show
  end

  # GET /academic_works/new
  def new
    @academic_work = AcademicWork.new
  end

  # GET /academic_works/1/edit
  def edit
  end

  # POST /academic_works
  # POST /academic_works.json
  def create
    @academic_work = AcademicWork.new(academic_work_params)

    respond_to do |format|
      if @academic_work.save
        format.html { redirect_to @academic_work, notice: 'Academic work was successfully created.' }
        format.json { render :show, status: :created, location: @academic_work }
      else
        format.html { render :new }
        format.json { render json: @academic_work.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /academic_works/1
  # PATCH/PUT /academic_works/1.json
  def update
    respond_to do |format|
      if @academic_work.update(academic_work_params)
        format.html { redirect_to @academic_work, notice: 'Academic work was successfully updated.' }
        format.json { render :show, status: :ok, location: @academic_work }
      else
        format.html { render :edit }
        format.json { render json: @academic_work.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /academic_works/1
  # DELETE /academic_works/1.json
  def destroy
    @academic_work.destroy
    respond_to do |format|
      format.html { redirect_to academic_works_url, notice: 'Academic work was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_academic_work
      @academic_work = AcademicWork.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def academic_work_params
      params.require(:academic_work).permit(:title, :author, :summary, :course, :defense_date, :document, :document_link, :type, :keyword, :how_to_quote, :appraisers)
    end
end
