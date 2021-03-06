class SessionsController < ApplicationController
  
  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      log_in(user)
      redirect_to articles_for_user_path(user.slug)
    else
      flash.now[:danger] = "Invalid email or password"
      render 'pages/home'
    end
  end

  def destroy
    log_out
    flash[:success] = "You are now logged out"
    redirect_to root_url
  end
  
end
