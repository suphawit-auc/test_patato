class ReviewsController < ApplicationController
  before_action :has_moviegoer_and_movie, :only => [:new, :create , :edit]
    protected
    def has_moviegoer_and_movie
      @movie = Movie.find_by_id(params[:movie_id])
      unless @current_user
        flash[:warning] = 'You must be logged in to create or edit a review.'
        redirect_to movie_path(@movie)
      end
      unless (@movie = Movie.where(:id => params[:movie_id]))
        flash[:warning] = 'Review must be for an existing movie.'
        redirect_to movies_path
      end
    end
    public
    def new
      @movie = Movie.find_by_id(params[:movie_id])
      @review = @movie.reviews.build
    end
    def create
      @movie = Movie.find_by_id(params[:movie_id])
      # since moviegoer_id is a protected attribute that won't get
      # assigned by the mass-assignment from params[:review], we set it
      # by using the << method on the association.  We could also
      # set it manually with review.moviegoer = @current_user.
      # params.permit!
      @current_user.reviews << @movie.reviews.build(params[:review].permit!)
      redirect_to movie_path(@movie)
    end

    def edit
      @movie = Movie.find_by_id(params[:movie_id])
      @review = Review.find_by_id(params[:id])
      if @current_user.uid != @review.moviegoer.uid
        flash[:warning] = 'It not your review you can not edit'
        redirect_to movie_path(@movie)
      end
    end

    def update
      @movie = Movie.find_by_id(params[:movie_id])
      @review = Review.find_by_id(params[:id])
      
      if @review.update!(params[:review].permit(:potatoes , :comments))
          flash[:notice] = "#{@movie.title} review was successfully updated."
          redirect_to movie_path(@movie)
      else 
          render 'edit'
      end
    end
    
    def destroy
      @movie = Movie.find_by_id(params[:movie_id])
      @review = Review.find_by_id(params[:id])
      @review.destroy()
      flash[:notice] = "review id #{@review.id} was Deleted."
      redirect_to movie_path(@movie)
  end
  end