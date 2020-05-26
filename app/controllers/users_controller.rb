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
    @user = User.find_by(user_params)

    if !@user
      @user = User.new(user_params)
      if @user.save
        flash[:success] = "Successfully created new user #{@user.username} with ID #{@user.id}"
      else
        render :login_form, status: :bad_request
        return
      end
    else
      flash[:success] = "Successfully logged in as existing user #{@user.username}"
    end

    session[:user_id] = @user.id
    redirect_to root_path
  end

  def logout
    user = User.find_by(id: session[:user_id])
    if user
      session[:user_id] = nil
      flash[:success] = "Successfully logged out"
      redirect_to root_path
      return
    else
      session[:user_id] = nil
      redirect_to root_path
      return
    end
  end
end

private

def user_params
  return params.require(:user).permit(:username)
end