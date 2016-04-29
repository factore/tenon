module Tenon
  class BaseController < ApplicationController
    include Pundit

    # Not worried about forgery here, you need to be logged in
    skip_before_action :verify_authenticity_token

    layout :layout_for_resource

    before_action :set_page_title, :set_default_context_title
    before_action :require_admin, unless: :devise_controller?

    rescue_from Pundit::NotAuthorizedError do |exception|
      flash[:warning] = 'You are not authorized to access that page.'
      redirect_to root_path
    end

    private

    def layout_for_resource
      'tenon/application'
    end

    def set_page_title
      case params[:action]
      when 'new', 'create'
        @page_title = "New #{params[:controller].gsub('tenon/', '').singularize.humanize}".titleize
      when 'edit', 'update'
        @page_title = "Edit #{params[:controller].gsub('tenon/', '').singularize.humanize}".titleize
      else
        @page_title = params[:controller].gsub('tenon/', '').humanize.titleize
      end
      @page_title = 'Tenon' if params[:controller].gsub('tenon/', '') == 'index'
    end

    def set_default_context_title
      @context_title = controller_name.humanize
    end

    def require_admin
      unless current_user && current_user.staff?
        flash[:warning] = "You're not authorized for that." if current_user
        redirect_to new_user_session_path
      end
    end

    def xhr_or_js?
      request.xhr? || request.format.js? || request.format.json?
    end
  end
end
