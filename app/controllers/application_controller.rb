class ApplicationController < ActionController::Base

  helper_method :current_user, :logged_in?

  def index; end

  private

  def authenticate_user!
    unless current_user
      session[:original_url] = request.original_url
      redirect_to login_path
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user.present?
  end
end
