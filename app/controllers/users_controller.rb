class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :current_user_or_admin, only: [:new, :create, :edit, :update]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path, notice: 'User was successfully created'
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update(user_params)
      redirect_to users_path, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path, notice: 'User was successfully removed.'
  end

  private

    def set_user
      begin
        @user = User.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        raise AccessDenied
      end
    end

    def current_user_or_admin
      raise AccessDenied unless current_user == @user || is_admin?
    end

    def user_params
      # look up ... hash method.merge ... for refactor possibilities
      if is_admin?
        params.require(:user).permit( :first_name,
                                      :last_name,
                                      :email,
                                      :admin,
                                      :password,
                                      :password_confirmation,
                                      :pivotal_tracker_token,
                                      :admin)
      else
        params.require(:user).permit( :first_name,
                                      :last_name,
                                      :email,
                                      :admin,
                                      :password,
                                      :password_confirmation,
                                      :pivotal_tracker_token)
      end
    end
end
