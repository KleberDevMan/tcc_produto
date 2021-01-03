class MenusController < ApplicationController
  # load_and_authorize_resource
  before_action :set_menu, only: [:show, :edit, :update, :destroy]
  before_action :set_combos, only: [:new, :edit, :update, :create]

  # GET /menus
  def index
    @q = Menu.roots.ransack(params[:q])
    @menus = @q.result.page(params[:page])
  end

  # GET /menus/1
  def show
  end

  # GET /menus/new
  def new
    if params[:pai].present?
      @pai = params[:pai]
    end

    @menu = Menu.new
  end

  # GET /menus/1/edit
  def edit
  end

  # POST /menus
  def create
    @menu = Menu.new(menu_params)
    if params[:pai].present?
      @menu.parent = Menu.find(params[:pai])
    end

    if @menu.save
      redirect_to @menu, notice: t('notice.menu.created')
    else
      render :new
    end
  end

  # PATCH/PUT /menus/1
  def update
    if @menu.update(menu_params)
      redirect_to @menu, notice: t('notice.menu.updated')
    else
      render :edit
    end
  end

  # DELETE /menus/1
  def destroy
    @menu.destroy
    redirect_to menus_url, notice: t('notice.menu.deleted')
  end

  private

  #Método que carrega os objetos para serem utilizados no form
  def set_combos
    @profiles = Profile.to_select
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_menu
    @menu = Menu.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def menu_params
    params.require(:menu).permit(:active, :icon, :name, :url, :position, profile_ids:[])
  end
end
