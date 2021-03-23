class IdeaCategoriesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  before_action :set_idea_category, only: [:show, :edit, :update, :destroy, :toggle_status]

  # GET /idea_categories
  # GET /idea_categories.json
  def index
    @idea_categories = IdeaCategory.order('updated_at desc').page params[:page]
  end

  # GET /idea_categories/1
  # GET /idea_categories/1.json
  def show
  end

  # GET /idea_categories/new
  def new
    @idea_category = IdeaCategory.new
  end

  # GET /idea_categories/1/edit
  def edit
  end

  # POST /idea_categories
  # POST /idea_categories.json
  def create
    @idea_category = IdeaCategory.new(idea_category_params)

    respond_to do |format|
      if @idea_category.save
        format.html { redirect_to idea_categories_url, notice: t('notice.created') }
        format.json { render :show, status: :created, location: @idea_category }
      else
        format.html { render :new }
        format.json { render json: @idea_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /idea_categories/1
  # PATCH/PUT /idea_categories/1.json
  def update
    respond_to do |format|
      if @idea_category.update(idea_category_params)
        format.html { redirect_to idea_categories_url, notice: t('notice.updated') }
        format.json { render :show, status: :ok, location: @idea_category }
      else
        format.html { render :edit }
        format.json { render json: @idea_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /idea_categories/1
  # DELETE /idea_categories/1.json
  def destroy
    if @idea_category.destroy
      render json: nil, status: :ok
    else
      render json: nil, status: :internal_server_error
    end
  end

  def toggle_status
    if @idea_category.status.inactive?
      if @idea_category.update(status: :active)
        redirect_to idea_categories_url, notice: t('notice.activated')
      end
    elsif @idea_category.status.active?
      if @idea_category.update(status: :inactive)
        redirect_to idea_categories_url, notice: t('notice.disabled')
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_idea_category
    @idea_category = IdeaCategory.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def idea_category_params
    params.require(:idea_category).permit(:name,
                                          :status,
                                          :img_link,
                                          :img,
                                          :link_or_image)
  end
end
