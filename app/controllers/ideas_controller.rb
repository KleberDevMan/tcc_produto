class IdeasController < ApplicationController
  layout :resolve_layout
  before_action :authenticate_user!
  load_and_authorize_resource

  skip_forgery_protection

  skip_before_action :set_default_breadcrumbs

  add_breadcrumb I18n.t('texts.idea.my_ideas'), :my_ideas_ideas_path, only: [:my_ideas]
  add_breadcrumb I18n.t('texts.idea.wall_of_ideas'), :ideas_path, only: [:index]

  before_action :set_idea, only: [:show, :edit, :update, :destroy]
  before_action :set_combos, only: [:edit, :update, :new, :create]
  before_action :prepare_q, only: [:index]

  SHOW_INFO_MY_IDEAS = 'show_info_my_ideas'.freeze
  SHOW_INFO_INDEX = 'show_info_ideas'.freeze

  def index
    @show_info = cookies[SHOW_INFO_INDEX]

    @q = Idea.quick_filter(params[:quick_filter], current_user.id)
             .includes(:collaborations, :idea_category)
             .order(updated_at: :desc)
             .ransack(params[:q])

    @ideas = @q.result.page(params[:page]).per(12)
  end

  def show
    if last_action.eql? 'my_ideas' or params[:breadcrumb]&.include? I18n.t('texts.idea.my_ideas')
      add_breadcrumb I18n.t('texts.idea.my_ideas'), :my_ideas_ideas_path
    else
      add_breadcrumb I18n.t('texts.idea.wall_of_ideas'), :ideas_path
      impressionist(@idea) unless current_user.id == @idea.ideializer_id
    end

    add_breadcrumb I18n.t('breadcrumb.show'), idea_path(@idea)
  end

  def new
    add_breadcrumb I18n.t('texts.idea.my_ideas'), :my_ideas_ideas_path
    add_breadcrumb I18n.t('breadcrumb.new'), :new_idea_path
    @idea = Idea.new
  end

  def edit
    if last_action.eql? 'my_ideas'
      add_breadcrumb I18n.t('texts.idea.my_ideas'), :my_ideas_ideas_path

    elsif last_action.eql? 'show'
      if params[:breadcrumb].include? I18n.t('texts.idea.my_ideas')
        add_breadcrumb I18n.t('texts.idea.my_ideas'), :my_ideas_ideas_path
      else
        add_breadcrumb I18n.t('texts.idea.wall_of_ideas'), :ideas_path
      end
      add_breadcrumb I18n.t('breadcrumb.show'), idea_path(@idea, breadcrumb: params[:breadcrumb])
    end

    add_breadcrumb I18n.t('breadcrumb.edit'), edit_idea_path(@idea)
  end

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

    result = false

    ActiveRecord::Base.transaction do
      begin
        result = @idea.update(idea_params)
        Notification.create_notification('edit_collaboration_admin', @idea)
      rescue => error
        raise ActiveRecord::Rollback
      end
    end

    respond_to do |format|
      if result
        format.html { redirect_to @idea, notice: t('notice.updated') }
        format.json { render :show, status: :ok, location: @idea }
      else
        format.html { render :edit }
        format.json { render json: @idea.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if @idea.destroy
      render json: nil, status: :ok
    else
      render json: nil, status: :internal_server_error
    end
  end

  def my_ideas
    @show_info = cookies[SHOW_INFO_MY_IDEAS]

    all = Idea.where(ideializer_id: current_user.id)
    @qtd_all = all.count

    @qtd_publics = all.select { |aw| aw.status == 'public' }.count
    @persent_publics = @qtd_all > 0 ? @qtd_publics * 100 / @qtd_all : @qtd_all

    @qtd_privates = all.select { |aw| aw.status == 'private' }.count
    @persent_privates = @qtd_all > 0 ? @qtd_privates * 100 / @qtd_all : @qtd_all

    # visualizacoes
    views = Impression.where(impressionable_type: 'Idea', impressionable_id: [all.pluck(:id)]).distinct(:request_hash)
    @qtd_views = views.length
    five_days_ago = views.where(created_at: 5.days.ago.to_date..4.days.ago.to_date).count
    four_days_ago = views.where(created_at: 4.days.ago.to_date..3.days.ago.to_date).count
    tree_days_ago = views.where(created_at: 3.days.ago.to_date..2.days.ago.to_date).count
    two_days_ago = views.where(created_at: 2.days.ago.to_date..Date.yesterday).count
    yesterday = views.where(created_at: Date.yesterday..Date.today).count
    today = views.where(created_at: Date.today..Date.tomorrow).count
    @last_five_days = [five_days_ago, four_days_ago, tree_days_ago, two_days_ago, yesterday, today]

    # taxa de colaboração
    @tax_collaboration = 0
    qty_ideas_with_collaboration = all.joins(:collaborations).distinct.pluck(:id).count
    unless qty_ideas_with_collaboration.zero?
      @tax_collaboration = (qty_ideas_with_collaboration / @qtd_all * 100).to_f.round(1)
    end

    # filtro
    @q = all.order(updated_at: :desc).ransack(params[:q])

    # paginacao
    @ideas = @q.result.page(params[:page]).per(9)
  end

  def create_collaboration
    collaboration = Collaboration.new
    collaboration.idea_id = params[:id]
    collaboration.type_collaboration = params[:type_collaboration]
    collaboration.user_id = params[:user_id]

    @result = false

    ActiveRecord::Base.transaction do
      begin
        @result = collaboration.save
        Notification.create_notification('new_collaboration', collaboration.idea)
      rescue
        raise ActiveRecord::Rollback
      end
    end

    respond_to do |format|
      if @result
        UserMailer.with(collaboration: collaboration).new_collaboration.deliver_now
        flash[:success_colaborar] = true
        format.html { redirect_to idea_path @idea.id }
      else
        flash[:fail_colaborar] = true
        format.html { redirect_to idea_path @idea.id }
      end
    end
  end

  def dashboard

  end

  def destroy_collaboration
    collaborations = Collaboration.where(user_id: params[:user_id], idea_id: params[:idea_id])

    result = false

    ActiveRecord::Base.transaction do
      begin
        result_delete = collaborations.destroy_all
        Notification.create_notification('quit_collaboration', result_delete.first.idea)

        result = true
      rescue => error
        raise ActiveRecord::Rollback
      end
    end

    respond_to do |format|
      if result
        format.json { render json: nil, status: :ok }
      else
        format.json { render json: nil, status: :internal_server_error }
      end
    end
  end

  def update_state
    @cities = ConectaAddressBr::Cities.by_state_single(params[:state_uf]).insert(0, t('texts.select'))
  end

  private

  def set_combos
    @states = ConectaAddressBr::States.all
    @cities = (@idea.state ? ConectaAddressBr::Cities.by_state_single(@idea.state) : [])
  end

  def set_idea
    @idea = Idea.includes(:ideializer, :collaborators).find(params[:id])
  end

  def idea_params
    params.require(:idea).permit(:title,
                                 :id,
                                 :description,
                                 :ideializer_id,
                                 :state,
                                 :city,
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

  def resolve_layout
    case action_name
    when 'index'
      # 'devise_layout'
      'application'
    else
      'application'
    end
  end

  def prepare_q
    if params[:q]
      params[:q].delete(:possibility_business_eq) if params[:q][:possibility_business_eq].eql?(0.to_s)
      params[:q].delete(:possibility_reward_eq) if params[:q][:possibility_reward_eq].eql?(0.to_s)
    end
  end

  # def from_mural_ideas?
  #   !last_action.eql?('my_ideas') and !params[:breadcrumb]&.include? I18n.t('texts.idea.my_ideas')
  # end
end
