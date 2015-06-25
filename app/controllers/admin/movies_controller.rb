class Admin::MoviesController < ApplicationController

	before_filter :authorize

	def destroy
		@movie = Movie.find(params[:id])
		@movie.destroy
		redirect_to movies_path
	end

	protected

	def authorize
		unless current_admin
			flash[:error] = "Unauthorized access"
			redirect_to movies_path
			false
		end
	end
end	