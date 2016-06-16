class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user_info
    user_info = { authenticated: false }
    current_user && (user_info = current_user.info)
    render json: user_info
  end

 private
  def authenticate_user!
    current_user || render(json: {status: :nok, msg: 'Please login' })
  end

  def current_user
    @current_user ||= User.find_by id: session[:user_id]
  end
end

