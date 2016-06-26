class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :init_response_json

  LIST_CHANGED_MSG = 'List\'s status is changed. Please reload the section.'

  def current_user_info
    render json: current_user && (user_info = current_user.info) || { authenticated: false }
  end

 private
  def authenticate_user!
    current_user || render_nok('Please login')
  end

  def current_user
    @current_user ||= User.find_by id: session[:user_id]
  end
  helper_method :current_user

  def init_response_json
    @json = { status: :nok, msg: 'Wrong params' }
  end

  def render_nok(msg = nil)
    msg == false && (@json[:status] = :ok)
    msg && (@json[:msg] = msg)
    render json: @json
  end
end

