class Admin::UsersController < ApplicationController

	before_filter :authorize

	def index
		@users = User.all
	end

	def show

	end

	def destroy

	end

	def edit

	end

	def update

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