  class ApplicationController < ActionController::Base
# good
  protect_from_forgery with: :exception

# good
  before_action :require_login
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




  helper_method :current_user
  helper_method :current_memberships
  helper_method :authorize_member
  helper_method :authorize_owner
  # helper_method :project_owner?
  helper_method :is_member?
  helper_method :is_owner?
  helper_method :is_admin?

  private

    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def is_member?
      @project.memberships.where(role: "Member").pluck(:user_id).include? current_user.id
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

    # This was in Tasks Controller
    #  def authorize_member
    #   raise AccessDenied unless @project.memberships.pluck(:user_id).include? current_user.id ||
    #   current_user.admin
    # end

    def authorize_owner
      raise AccessDenied unless(is_owner? || is_admin?)
    end

    # returns an array of owner memberships for the current project ... NOT USED???
    # def project_owner?
    #   @project.memberships.where(role: "Owner").pluck(:user_id).include? current_user.id || is_admin
    # end

    # returns an array of owner memberships for the current project
    def project_owners
      @project.memberships.where(role: "Owner")
    end

end
