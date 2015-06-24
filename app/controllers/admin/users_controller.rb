class Admin::UsersController < ApplicationController

	before_filter :authorize

	def new
		@user = User.new
	end

	def index
		@users = User.all.page(params[:page]).per(1)
	end

	def show
		@user = User.find(params[:id])
	end

	def destroy
		@user = User.find(params[:id])
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

	protected

	def authorize
		unless current_user && current_user.admin
			flash[:error] = "unauthorized access"
			redirect_to movies_path
			false
		end
	end

	def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation, :admin)
  end
end