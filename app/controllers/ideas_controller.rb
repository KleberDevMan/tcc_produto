class IdeasController < ApplicationController
  layout :resolve_layout
  before_action :authenticate_user!
  load_and_authorize_resource

  before_action :set_idea, only: [:show, :edit, :update, :destroy]

  # GET /ideas
  # GET /ideas.json
  def index
    @q = Idea.includes(:collaborations, :idea_category).ransack(params[:q], default_order: { updated_at: :desc })
    @ideas = @q.result.page(params[:page]).per(12)
  end

  # GET /ideas/1
  # GET /ideas/1.json
  def show
  end

  # GET /ideas/new
  def new
    @idea = Idea.new
  end

  # GET /ideas/1/edit
  def edit
  end

  # POST /ideas
  # POST /ideas.json
  def create
    @idea = Idea.new(idea_params)

    respond_to do |format|
      if @idea.save
        format.html { redirect_to my_ideas_ideas_path, notice: t('notice.created') }
        format.json { render :show, status: :created, location: @idea }
      else
        format.html { render :new }
        format.json { render json: @idea.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ideas/1
  # PATCH/PUT /ideas/1.json
  def update
    respond_to do |format|
      if @idea.update(idea_params)
        format.html { redirect_to my_ideas_ideas_path, notice: t('notice.updated') }
        format.json { render :show, status: :ok, location: @idea }
      else
        format.html { render :edit }
        format.json { render json: @idea.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_colaborators
    @idea = Idea.find_by id: idea_params[:id]
    respond_to do |format|
      if @idea.update(idea_params)
        format.html { redirect_to @idea, notice: t('notice.updated') }
        format.json { render :show, status: :ok, location: @idea }
      else
        format.html { render :edit }
        format.json { render json: @idea.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ideas/1
  # DELETE /ideas/1.json
  def destroy
    @idea.destroy
    respond_to do |format|
      format.html { redirect_to my_ideas_ideas_path, notice: t('notice.excluded') }
      format.json { head :no_content }
    end
  end

  def my_ideas
    all = Idea.all
    @qtd_all = all.count

    @qtd_publics = all.select { |aw| aw.status == 'public' }.count
    @persent_publics = @qtd_all > 0 ? @qtd_publics * 100 / @qtd_all : @qtd_all

    @qtd_privates = all.select { |aw| aw.status == 'private' }.count
    @persent_privates = @qtd_all > 0 ? @qtd_privates * 100 / @qtd_all : @qtd_all

    @qtd_views = 1168 #
    @last_week = [3, 2, 7, 5, 4, 6, 8]

    @tax_collaboration = 66

    @q = Idea.includes(:collaborations).ransack(params[:q], default_order: { updated_at: :desc })

    @ideas = @q.result.page(params[:page]).per(9)
  end

  # def manage_collaborators
  # end

  def create_callaboration
    a = 2
  end


  private

  # Use callbacks to share common setup or constraints between actions.
  def set_idea
    @idea = Idea.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def idea_params
    params.require(:idea).permit(:title,
                                 :id,
                                 :description,
                                 # { category_ids: [] },
                                 :ideializer_id,
                                 :locality,
                                 :idea_category_id,
                                 { dev_ids: [] },
                                 { facilitator_ids: [] },
                                 :possibility_reward,
                                 :possibility_business,
                                 :status,
                                 :problem_to_solve,
                                 :suffering_people,
                                 :proposed_solution,
                                 :differential)
  end

  def idea_params2
    params.require(:idea).permit!
  end

  def resolve_layout
    case action_name
    when 'index'
      # 'devise_layout'
      'application'
    else
      'application'
    end
  end
end
