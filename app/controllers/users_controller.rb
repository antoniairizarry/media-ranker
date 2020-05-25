class UsersController < ApplicationController
  
  def index
    @users = User.all
  end

  def show
    user_id = params[:id]
    @user = User.find_by(id: user_id)

    if @user.nil?
      head :not_found
      return
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    if @user.nil?
      flash[:failure]= "Cannot find user"
      redirect_to root_path
    end
  end

  def login_form
    @user = User.new
  end

  def login
    user = User.find_by(user_params)
    if user
      session[:user_id] = user.id
      flash[:success] = "Successfully logged in as existing user #{user_params}"
    else
      user = User.create(user_params)
      session[:user_id] = user.id
      flash[:success] = "Successfully logged in as new user #{user_params}"
    end
    redirect_to root_path
    return
  end

  def current
    user_id = session[:id]
    @current_user = User.find_by(id: user_id)
    unless @current_user
      flash[:error] = "You must be logged in to see this page."
      redirect_to root_path
      return
    end
  end

  def logout
    user_id = session[:id]
    @current_user = User.find_by(id: user_id)
    if @current_user
      session[:user_id] = nil
      flash[:success] = "Successfully logged out"
    else
      flash[:failure] = "Error logging out"
    end
    redirect_to root_path
  end
end

private

def user_params
  return params.require(:user).permit(:username)
end