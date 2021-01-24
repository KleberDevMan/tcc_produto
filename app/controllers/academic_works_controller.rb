class AcademicWorksController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  before_action :set_academic_work, only: [:show, :edit, :update, :destroy]

  # GET /academic_works
  # GET /academic_works.json
  def index
    all = AcademicWork.all
    @qtd_all = all.count

    @qtd_tcc = all.select { |aw| aw.work_type == 'tcc' }.count
    @persent_tcc = @qtd_all > 0 ? @qtd_tcc * 100 / @qtd_all : @qtd_all

    @qtd_search = all.select { |aw| aw.work_type == 'search' }.count
    @persent_search = @qtd_all > 0 ? @qtd_search * 100 / @qtd_all : @qtd_all

    @qtd_extension = all.select { |aw| aw.work_type == 'extension' }.count
    @persent_extention = @qtd_all > 0 ? @qtd_extension * 100 / @qtd_all : @qtd_all

    @q = AcademicWork.ransack(params[:q], default_order: { updated_at: :desc })

    @academic_works = @q.result.page(params[:page]).per(6)
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
    params.require(:academic_work).permit(:title,
                                          :author,
                                          :summary,
                                          :defense_date,
                                          :document,
                                          :document_link,
                                          :work_type,
                                          :keyword,
                                          :how_to_quote,
                                          :appraisers,
                                          :teacher_id,
                                          :course_id)
  end
end
