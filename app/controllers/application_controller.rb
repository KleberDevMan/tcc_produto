class ApplicationController < ActionController::Base
  # before_action :authenticate_user!
  # load_and_authorize_resource

  add_breadcrumb I18n.t('breadcrumb.home'), '/'
  before_action :set_default_breadcrumbs, only: [:index, :show, :edit, :update, :new, :create]
  before_action :configure_permitted_parameters, if: :devise_controller?

  layout :set_layout

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden }
      format.html { render "/msg_errors/denied", layout: 'devise_layout', alert: I18n.t('unauthorized.manage.all') }
    end
  end

  private

  # Breadcrumbs generic
  def set_default_breadcrumbs
    if params[:controller].eql? 'versions' # logs

      # verifica se está querendo ver os logs de um registro específico
      #   path: index > show > logs
      if params[:action] == 'index' and params[:id].present? and params[:from_show].present?
        $id_model_version = params[:id]
      elsif params[:action] == 'index' and !params[:from_show].present? and last_action != 'show'
        $id_model_version = nil
      end

      # adiciona o crumb da index
      add_breadcrumb I18n.t("activerecord.models.#{params[:item_type].tableize}"), "/#{params[:item_type].tableize}"

      # adiciona o crumb show model
      add_breadcrumb I18n.t('breadcrumb.show'), "/#{params[:item_type].tableize}/#{$id_model_version}" if $id_model_version.present?

      # adiciona crumb logs
      link = params[:action].eql?('show') ? "/#{params[:controller]}?item_type=#{params[:item_type]}" : nil
      add_breadcrumb I18n.t("activerecord.models.#{params[:controller]}"), link
    else
      # adiciona o crumb da index
      add_breadcrumb I18n.t("activerecord.models.#{params[:controller]}"), "/#{params[:controller]}"
    end

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

    add_breadcrumb(I18n.t("breadcrumb.#{params[:action]}"), link) #unless params[:action] == 'index'
  end

  # Retorna nome da ultima action
  def last_action
    Rails.application.routes.recognize_path(request.referrer)[:action]
  end

  # Define o layout da tela de login/cadastro
  def set_layout
    if devise_controller? #&& resource_class == Admin
      "devise_layout"
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :name, :telephone, :biography])
  end
end
