class MoviesController < ApplicationController
	respond_to :html, :json
	def index
		@movies = Movie.all
	end

	def create
		@movie = Movie.new(
			title: params[:movie][:title],
			director: params[:movie][:director],
			runtime_in_minutes: params[:movie][:runtime_in_minutes],
			description: params[:movie][:description],
			poster_image_url: params[:movie][:poster_image_url],
			release_date: params[:movie][:release_date]
			)

		if @movie.save
			redirect_to movie_path(@movie)
		else
			render :new
		end
	end

	def new
		@movie = Movie.new
	end

	def edit
		@movie = Movie.find(params[:id])
	end

	def show
		@movie = Movie.find(params[:id])
	end

	def update
		@movie = Movie.find(params[:id])
		if @movie.update_attributes(movie_params)
			respond_to do |format|
				format.html { redirect_to movies_path }
				format.json { render json:{success:true, movie: @movie } }
			end
    else
      render :edit
    end
	end

	def destroy
		@movie = Movie.find(params[:id])
		if @movie.destroy
			redirect_to movies_path
		else
			redirect_to movie_path(@movie)
		end
	end

  protected

  def movie_params
    params.require(:movie).permit(:title, :director, :runtime_in_minutes, :description, :poster_image_url, :release_date)
  end

end