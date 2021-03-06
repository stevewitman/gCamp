  class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :require_login
  before_action :current_memberships

  class AccessDenied < StandardError
  end

  rescue_from AccessDenied, with: :render_404

  helper_method :current_user
  helper_method :current_memberships
  helper_method :authorize_member
  helper_method :authorize_owner
  helper_method :project_owners
  helper_method :is_member?
  helper_method :is_co_member?
  helper_method :is_owner?
  helper_method :is_admin?

  private

    def require_login
      unless current_user
        store_location
        redirect_to signin_path, notice: 'You must be logged in to access that action'
      end
    end

    def redirect_back_or(default)
      redirect_to(session[:return_url] || default)
      session.delete(:return_url)
    end

    def store_location
      session[:return_url] = request.url if request.get?
    end

    def render_404
      render "public/404", status: 404, layout: false
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def is_member?
      @project.memberships.where(role: "Member").pluck(:user_id).include? current_user.id
    end

    def is_co_member?(user)
      !(user.memberships.all.pluck(:project_id) & current_user.memberships.all.pluck(:project_id)).empty?
    end

    def is_owner?
      @project.memberships.where(role: "Owner").pluck(:user_id).include? current_user.id
    end

    def is_admin?
      current_user.admin
    end

    def current_memberships
      if current_user
        @current_memberships = current_user.memberships.all
      end
    end

    def authorize_member
      raise AccessDenied unless(is_member? || is_owner? || is_admin?)
    end

    def authorize_owner
      raise AccessDenied unless(is_owner? || is_admin?)
    end

    def project_owners
      @project.memberships.where(role: "Owner")
    end

end
