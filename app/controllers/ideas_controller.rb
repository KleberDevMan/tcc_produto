class IdeasController < ApplicationController
  layout :resolve_layout
  before_action :authenticate_user!
  load_and_authorize_resource

  skip_forgery_protection

  skip_before_action :set_default_breadcrumbs

  add_breadcrumb I18n.t('texts.idea.my_ideas'), :my_ideas_ideas_path, only: [:my_ideas]
  add_breadcrumb I18n.t('texts.idea.wall_of_ideas'), :ideas_path, only: [:index]

  before_action :set_idea, only: [:show, :edit, :update, :destroy]
  before_action :prepare_q, only: [:index]

  def index
    @q = Idea.quick_filter(params[:quick_filter], current_user.id)
             .includes(:collaborations, :idea_category)
             .ransack(params[:q], default_order: { updated_at: :desc })

    @ideas = @q.result.page(params[:page]).per(12)
  end

  def show
    if last_action.eql? 'my_ideas' or params[:breadcrumb]&.include? I18n.t('texts.idea.my_ideas')
      add_breadcrumb I18n.t('texts.idea.my_ideas'), :my_ideas_ideas_path
    else
      add_breadcrumb I18n.t('texts.idea.wall_of_ideas'), :ideas_path
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
    all = Idea.where(ideializer_id: current_user.id)
    @qtd_all = all.count

    @qtd_publics = all.select { |aw| aw.status == 'public' }.count
    @persent_publics = @qtd_all > 0 ? @qtd_publics * 100 / @qtd_all : @qtd_all

    @qtd_privates = all.select { |aw| aw.status == 'private' }.count
    @persent_privates = @qtd_all > 0 ? @qtd_privates * 100 / @qtd_all : @qtd_all

    @qtd_views = 1168 #
    @last_week = [3, 2, 7, 5, 4, 6, 8]

    @tax_collaboration = 66

    @q = all.ransack(params[:q], default_order: { updated_at: :desc })

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

  private

  def set_idea
    @idea = Idea.find(params[:id])
  end

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
end
