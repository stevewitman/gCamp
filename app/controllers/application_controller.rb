class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :projects

  # layout :select_layout
  #
  # private
  # def select_layout
  #   if current_user.nil?
  #     "marketing"
  #   else
  #     "application"
  #   end
  # end

  def current_user
    User.find_by(id: session[:user_id])
  end

  private

    def projects
      @projects = Project.all
    end

  helper_method :current_user
end
