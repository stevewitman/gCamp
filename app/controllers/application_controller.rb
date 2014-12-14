class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  before_action :require_login
  before_action :current_memberships


  class AccessDenied < StandardError
  end

  rescue_from AccessDenied, with: :render_404

  private

  def require_login
    unless current_user
      redirect_to signin_path, notice: 'You must be logged in to access that action'
    end
  end

  def render_404
    render "public/404", status: 404, layout: false
  end

  def current_memberships
    if current_user
      @current_memberships = current_user.memberships.all
    end
  end

  helper_method :current_user

  private

  def current_user
    # just return current_user if it is already set otherwise set it
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def current_user?
    current_user.present?
  end

end
