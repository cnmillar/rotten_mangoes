class Admin::UsersController < ApplicationController

	before_filter :authorize

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			redirect_to admin_users_path, notice: "Successfully added #{@user.firstname}!"
		else
			render :new
		end
	end

	def index
		@users = User.all.page(params[:page]).per(4)
	end

	def show
		@user = User.find(params[:id])
	end

	def destroy
		@user = User.find(params[:id])
		UserMailer.delete_email(@user).deliver
		@user.destroy
		redirect_to admin_users_path
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update_attributes(user_params)
    	redirect_to admin_users_path
    else
      render :edit
    end
	end

	def switch_user
		@user = User.find(params[:user_id])
		session[:user_id] = @user.id
		redirect_to user_path(@user)
	end

	def switch_back
		@user = User.find(params[:user_id])
		session[:user_id] = @user.id
		redirect_to admin_users_path
	end

	protected

	def authorize
		unless current_admin
			flash[:error] = "Unauthorized access"
			redirect_to movies_path
			false
		end
	end

	def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation, :admin)
  end
end