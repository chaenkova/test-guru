class SessionController < ApplicationController
  skip_before_action :authenticate_user!

  def new
  end

  def create
    @user = User.find_by(login: params[:login])
    if @user&.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to session[:original_url] || root_path
    else
      flash.now[:alert] = 'Verify your login and password please'
      render :new
    end
  end

  def destroy
    session.clear if logged_in?
    redirect_to root_path
  end
end