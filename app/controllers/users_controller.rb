class UsersController < ApplicationController
  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)

  	if @user.save
      session[:admin_id] = @user.id if @user.admin
      session[:user_id] = @user.id
      # UserMailer.welcome_email(@user).deliver_now
  		redirect_to movies_path, notice: "Welcome aboard, #{@user.firstname}!"
  	else
  		render :new
  	end
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end
  
  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation, :admin)
  end
end
