class Admin::GenresController < ApplicationController

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      flash[:notice] = "Genre was successfully created."
      redirect_to edit_admin_genre_path(@genre.id)
    else
      flash[:notice] = "Genre was false created."
      @genres = Genre.all
      render :index
    end
  end

  def index
    @genre = Genre.new
    @genres = Genre.all
  end

  def edit
  end

  def update
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end

end
