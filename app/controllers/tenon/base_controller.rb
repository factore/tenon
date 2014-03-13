class Tenon::BaseController < ApplicationController
  layout :layout_for_resource

  before_filter :set_crumbs, :set_title
  before_filter :require_admin, unless: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    flash[:warning] = exception.message
    redirect_to '/tenon'
  end

  private

  def layout_for_resource
    if devise_controller?
      'tenon/login'
    else
      'tenon/application'
    end
  end

  def set_crumbs
    @controller_crumb = params[:controller]
    @action_crumb = params[:action]
  end

  def set_title
    case params[:action]
    when 'new', 'create'
      @page_title = "New #{params[:controller].gsub('tenon/', '').singularize.humanize} - Tenon".titleize
    when 'edit', 'update'
      @page_title = "Edit #{params[:controller].gsub('tenon/', '').singularize.humanize} - Tenon".titleize
    else
      @page_title = params[:controller].gsub('tenon/', '').humanize.titleize + ' - Tenon'
    end
    @page_title = 'Tenon' if params[:controller].gsub('tenon/', '') == 'index'
  end

  def require_admin
    unless current_user && current_user.staff?
      flash[:warning] = "You're not authorized for that." if current_user
      redirect_to new_user_session_path
    end
  end
end
