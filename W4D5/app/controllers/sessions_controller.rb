class SessionsController < ApplicationController
  helper_method :current_user
  def new
    render :new
  end
  
  def create
    user = User.find_by_credentials(
      params[:user][:email],
      params[:user][:password]
    )
    if user
      log_in_user!(user)
      redirect_to users_url
    else
      flash[:errors] = ['Wrong username/password combination']
      render :new
    end
  end
  
  def destroy
    log_out!
    redirect_to users_url
  end
  
end

#Write controller methods and the accompanying routes so that users can log in and log out. Should session be a singular resource?
#Controller#create should re-set the appropriate user's session_token and session[:session_token].
#For now just redirect them to a User#show page which simply displays that user's email.