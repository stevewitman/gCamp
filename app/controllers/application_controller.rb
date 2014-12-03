class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :users_memberships

  def current_user
    User.find_by(id: session[:user_id])
  end

  private

  # *** from class notes Dec 1
  # def require_login
  #   unless current_user
  #     render file: 'public/404.html', status: :not_found, layout: false
  #   end
  # end

  def users_memberships
    if current_user
      @users_memberships = current_user.memberships.all
    end
  end

  helper_method :current_user
end
