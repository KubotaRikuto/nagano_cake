class Admin::GenresController < ApplicationController
  #ログインしていない状態で管理者ページにアクセスすると、ログイン画面へリダイレクト(adminは例外なし)
  before_action :authenticate_admin!

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      flash[:notice] = "Genre was successfully created."
      redirect_to admin_genres_path
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
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      flash[:notice] = "You have updated genre successfully."
      redirect_to admin_genres_path
    else
      render :edit
    end
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end

end
