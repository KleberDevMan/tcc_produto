class UsersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  # before_action :set_paper_trail_whodunnit, only: [:create]

  before_action :set_user, only: [:show, :edit, :update, :destroy]
  # before_action :set_combos, only: [:new, :edit, :update]

  # add_breadcrumb "Usuários", :users_path

  # GET /users
  def index
    @q = User.order(updated_at: :desc).ransack(params[:q])
    @users = @q.result.page params[:page]
  end

  #Método que realiza a alteração de perfil e órgão do usuário
  def alterar_perfil
    current_user.update(perfil_atual: params[:perfil_atual], orgao_atual: params[:orgao_atual].to_i)
    redirect_to root_path
  end

  # GET /users/1
  def show
    # add_breadcrumb "Visualizar", user_path(@user)
  end

  # GET /users/new
  def new
    # add_breadcrumb "Cadastrar", new_user_path
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    # redirect_to edit_user_registration_path#, layout
    # add_breadcrumb "Visualizar", user_path(@user) if last_action.eql? 'show'
    # add_breadcrumb "Alterar", edit_user_path(@user)
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to users_path, notice: t('notice.created')
    else
      render :new
    end
  end

  # PATCH/PUT /users/1
  def update
    # binding.pry
    if params[:user][:secretarias].present? and params[:user][:secretarias].first == ""
      params[:user][:secretarias].shift
    end
    if @user.update(user_params)
      redirect_to users_path, notice: t('notice.updated')
    else
      render :edit
    end
  end

  # DELETE /users/1
  def destroy
    if @user.destroy
      render json: nil, status: :ok
    else
      render json: nil, status: :internal_server_error
    end
  end

  #
  # def security
  #   @user = current_user
  # end

  private

  # def set_combos
  #   # @orgaos = Secretaria.all.order(nome: :asc).map{|a| [a.nome,a.id]}
  #   @profiles = Profile.order(name: :asc).map { |p| [p.name, p.id] }
  # end

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def user_params
    params.require(:user).permit(:name,
                                 :cpf,
                                 :email,
                                 :telephone,
                                 :biography,
                                 :token,
                                 :img,
                                 :link_or_img,
                                 :img_link,
                                 :password,
                                 :registered_by_id,
                                 :password_confirmation,
                                 { profile_ids: [] })
  end
end