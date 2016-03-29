class ApplicationController < ActionController::Base
  helper Tenon::Engine.helpers

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :authenticate
  before_filter :store_location

  layout :layout_for_resource

  def authenticate
    if request.host =~ /\A[A-Za-z0-9-].+\.ocean\.factore\.ca\Z/
      authenticate_or_request_with_http_basic('Tenon') do |username, password|
        username == 'tenon' && password == 'mightyoak'
      end
    end
  end

  def store_location
    # store last url - this is needed for post-login redirect to
    # whatever the user last visited.
    return unless request.get?
    if  !request.path.match('/users/sign_in') &&
        !request.path.match('/users/sign_up') &&
        !request.path.match('/users/password/new') &&
        !request.path.match('/users/password/edit') &&
        !request.path.match('/users/confirmation') &&
        !request.path.match('/users/sign_out') &&
        !request.path.match(%r{^api\/v1\/.*}) &&
        !xhr_or_js? # don't store ajax calls
      session[:previous_url] = request.fullpath
    end
  end

  protected

  def layout_for_resource
    if devise_controller?
      'tenon/login'
    else
      'tenon/application'
    end
  end

  def after_sign_in_path_for(_)
    session[:previous_url] || edit_profile_path
  end
end
