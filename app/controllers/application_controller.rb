class ApplicationController < ActionController::Base
  # before_action :authenticate_user!
  # load_and_authorize_resource

  add_breadcrumb I18n.t('breadcrumb.home'), '/', unless: :devise_controller?
  before_action :set_default_breadcrumbs, only: [:index, :show, :edit, :update, :new, :create], unless: :devise_controller?
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_profiles_s
  before_action :set_notifications

  layout :set_layout

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden }
      format.html { render "/pages/denied", layout: 'devise_layout', alert: I18n.t('unauthorized.manage.all') }
    end
  end

  protected

  # Breadcrumbs generic
  def set_default_breadcrumbs
    # adiciona o crumb da index
    add_breadcrumb I18n.t("activerecord.models.#{params[:controller]}"), "/#{params[:controller]}"

    if params[:action] == "index"
      link = nil
    elsif params[:action] == "show"
      link = "/#{params[:controller]}/#{params[:id]}"
    elsif params[:action] == "new"
      link = "/#{params[:controller]}/new"
    elsif params[:action] == 'edit'
      add_breadcrumb I18n.t('breadcrumb.show'), "/#{params[:controller]}/#{params[:id]}" if last_action.eql? 'show'
      link = nil
    elsif params[:action] == 'create'
      link = nil
    elsif params[:action] == 'update'
      add_breadcrumb t('breadcrumb.show'), "/#{params[:controller]}/#{params[:id]}" if params[:from_show].present?
      link = nil
    else
      link = "/#{params[:controller]}/#{params[:id]}/#{params[:action]}"
    end

    unless %w[index my_ideas].include? params[:action]
      add_breadcrumb(I18n.t("breadcrumb.#{params[:action]}"), link)
    end
  end

  # Retorna nome da ultima action
  def last_action
    Rails.application.routes.recognize_path(request.referrer)[:action]
  end

  # Define o layout da tela de login/cadastro
  def set_layout
    if devise_controller? #&& resource_class == Admin
      if params[:controller] == 'devise/registrations' and params[:action] == 'edit'
        "application"
      else
        "devise_layout"
      end
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:email, :name, :telephone, :biography, :img, :link_or_img, :img_link, :password, :password_confirmation, :remember_me, :current_password) }

    devise_parameter_sanitizer.permit(:sign_in) { |u| u.permit(:email, :name, :telephone, :biography, :img, :link_or_img, :img_link, :password, :password_confirmation, :remember_me, :current_password) }

    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:email, :name, :telephone, :biography, :img, :link_or_img, :img_link, :password, :password_confirmation, :remember_me, :current_password) }
  end

  def set_profiles_s
    @profiles_s = current_user.present? ? current_user.profiles.map(&:namespace) : []
  end

  def set_notifications
    @notifications = Notification.not_viewed.where(user_id: current_user&.id)
    # Notification.where(user_id: current_user.id).update_all(visualized: false)
  end
end
