class ApplicationController < ActionController::Base
  helper Tenon::Engine.helpers

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :authenticate

  def authenticate
    if request.host =~ /\A[A-Za-z0-9-].+\.ocean\.factore\.ca\Z/
      authenticate_or_request_with_http_basic('Tenon') do |username, password|
        username == 'tenon' && password == 'mightyoak'
      end
    end
  end
end
