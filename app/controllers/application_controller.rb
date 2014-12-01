class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

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

  helper_method :current_user
end
