class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def require_signin
    unless current_user
      session[:intended_url] = request.url
      redirect_to new_session_url, notice: "Please sign in first!"
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user

  def current_user?(user)
 	current_user == user
  end

  helper_method :current_user?

  def require_admin_or_creator
    unless current_user_admin? || is_creator? 
      redirect_to root_url, notice: "Unauthorized access!"
    end
  end

  helper_method :require_admin_or_creator

  def current_user_admin_or_creator?(event_created_by)
    current_user_admin? || (current_user == creator(event_created_by)) 
  end

  helper_method :current_user_admin_or_creator?

  def current_user_admin?
    current_user && current_user.admin?
  end

  helper_method :current_user_admin?

  def creator(event_created_by)
    User.find_by(name: event_created_by)
  end

  helper_method :creator

  def is_creator?
    current_user == creator(Event.find(params[:id]).created_by)
  end

  helper_method :is_creator?

  def already_registered?(event)
    event.registrations.pluck("user_id").include?(current_user.id)
  end

  helper_method :already_registered?

end
