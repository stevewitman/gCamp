class AuthenticationController < PublicController

  def new
    @user = User.new
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      if session[:request_path] == nil
        redirect_to projects_path
      else
        redirect_path = session[:request_path]
        session[:request_path] = nil
        redirect_to redirect_path
      end
    else
      @sign_in_error = "Username / password combination is invalid"
      render :new
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end


end
