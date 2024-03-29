class MoviesController < ApplicationController
  helper_method :sort_direction, :sort_column
  before_filter :store_session_info
  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie::RATINGS
    @movies = Movie.where("title is not null")
    if params[:sort] 
      @movies = @movies.order("#{sort_column} #{sort_direction}")
      if params[:ratings]
        ratings = params[:ratings].keys
      elsif session[:ratings]
        params[:ratings] = session[:ratings]
        redirect_to params
      end
    elsif session[:sort]
      params[:sort] = session[:sort]
      redirect_to params
    else
      ratings = @all_ratings
    end
    @movies = @movies.by_ratings(ratings)
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end
  private 
  def sort_column
    %w[title rating description release_date].include?(params[:sort]) ? params[:sort] : "title" 
  end  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc" 
  end
  def store_session_info
    store_session_ratings
    store_session_sort_and_direction
  end
  def store_session_ratings
    session[:ratings] = params[:ratings] if params[:ratings]
  end
  def store_session_sort_and_direction
    session[:sort] = params[:sort] if params[:sort]
    session[:direction] = params[:direction] if params[:direction]
  end
end
