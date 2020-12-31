class IdeaCategoriesController < ApplicationController
  before_action :set_idea_category, only: [:show, :edit, :update, :destroy]

  # GET /idea_categories
  # GET /idea_categories.json
  def index
    @idea_categories = IdeaCategory.all
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
        format.html { redirect_to @idea_category, notice: 'Idea category was successfully created.' }
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
        format.html { redirect_to @idea_category, notice: 'Idea category was successfully updated.' }
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
    @idea_category.destroy
    respond_to do |format|
      format.html { redirect_to idea_categories_url, notice: 'Idea category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_idea_category
      @idea_category = IdeaCategory.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def idea_category_params
      params.require(:idea_category).permit(:name, :status)
    end
end
