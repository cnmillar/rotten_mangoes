class MoviesController < ApplicationController
	respond_to :html, :json
	def index
		@movies = Movie.all
	end

	def create
		@movie = Movie.new(movie_params)

		if @movie.save
			 # UserMailer.welcome_email(@user).deliver_now
			redirect_to movie_path(@movie), notice: "#{@movie.title} was submitted successfully!"
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

	def search
		if params[:duration] == "under"
			max = 90
			min = 0
		elsif params[:duration] == "between"
			max = 120
			min = 90
		elsif params[:duration] == "over"
			max = 3000
			min = 120
		end

		@search_results = Movie.all

		if !params[:search_term].empty? 
			@search_results = @search_results.title_director_search(params[:search_term])
		elsif !params[:duration].empty?
			@search_results = @search_results.duration_search(max, min)
		end
	end

  protected

  def movie_params
    params.require(:movie).permit(:title, :director, :runtime_in_minutes, :description, :poster_image_url, :release_date, :image, :remote_image_url)
  end

end