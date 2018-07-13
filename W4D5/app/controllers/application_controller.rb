class ApplicationController < ActionController::Base
  helper_method :current_user
  # protect_from_forgery with: :exception
  
  def log_in_user!(user)
    session[:session_token] = user.reset_session_token!
  end
  
  def current_user
    return nil unless session[:session_token]
    @current_user ||= User.find_by(session_token: session[:session_token])
  end
  
  def logged_in?
    return true if session[:session_token]
  end
  
  def log_out!
    return nil unless logged_in?
    current_user.reset_session_token!
    session[:session_token] = nil
  end
end
