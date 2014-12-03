class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :users_memberships

  def current_user
    User.find_by(id: session[:user_id])
  end

  private

  def users_memberships
    if current_user
      @users_memberships = current_user.memberships.all
    else
      redirect_to signin_path, notice: "You must be logged in to access that action"
    end
  end

  helper_method :current_user
end
