  class ApplicationController < ActionController::Base
# good
  protect_from_forgery with: :exception

# good
  before_action :require_login

# somewhere else?
  before_action :current_memberships

  class AccessDenied < StandardError
  end

  rescue_from AccessDenied, with: :render_404

  def seed_db
    Rails.application.load_seed
    redirect_to root_path, notice: 'Re-seeded database'
  end

  private
# good
  def require_login
    unless current_user
      redirect_to signin_path, notice: 'You must be logged in to access that action'
    end
  end

  def render_404
    render "public/404", status: 404, layout: false
  end

# somewhere else?
  def current_memberships
    if current_user
      @current_memberships = current_user.memberships.all
    end
  end

  helper_method :current_user


  private

# good
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  # def current_user?
  #   current_user.present?
  # end

end
