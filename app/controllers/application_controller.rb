class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :require_login
  before_action :current_memberships

  def current_user
    User.find_by(id: session[:user_id])
  end

  def seed_db
    Rails.application.load_seed
    redirect_to root_path
  end

  class AccessDenied < StandardError
  end

  rescue_from AccessDenied, with: :render_404

  private

  def require_login
    unless current_user
      render file: 'public/404.html', status: :not_found, layout: false
    end
  end

  def render_404
    render "public/404", status: 404, layout: false
  end

  def current_memberships
    if current_user # ********************************************************** can this go away?
      @current_memberships = current_user.memberships.all
    end
  end

  # def current_projects_users
  #   if current_user # ********************************************************** can this go away?
  #     @current_memberships = current_user.memberships.all
  #       @current_memberships.each do |membership|
  #       end
  #   end
  # end



  helper_method :current_user
  

end
