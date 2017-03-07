class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :verify_current_user
  helper_method :current_user

  def verify_current_user
    redirect_to root_path unless current_user
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
