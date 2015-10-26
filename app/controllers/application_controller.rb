class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  def sign_in(user)
    @current_user = user
    session[:session_token] = user.reset_session_token!
  end

def current_user
  @current_user ||= User.find_by_session_token(session[:session_token])
end

  def sign_out
    current_user.try(:reset_session_token!)
    session[:session_token] = nil
  end

  def block_private_goal_page

    if current_user.nil?
      redirect_to new_session_url
    elsif (current_user.id != Goal.find(params[:id]).user_id) && Goal.find(params[:id]).private
      redirect_to user_url(Goal.find(params[:id]).user_id)
    end
  end
end
