class UsersController < ApplicationController
  def index 
    @user = User.new
    render :index
  end
  
  def show
    @user = User.find_by(id: params[:id])
    render :show
  end
  
  def new
    @user = User.new
    render :new
  end
  
  def create
    @user = User.new(user_params)
    # @user.password = params[:password]
    if @user.save
      redirect_to users_url
    else
      flash[:errors] = ['Email/Password combination did not create a new user']
      redirect_to new_user
    end
  end
  
  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
  
end