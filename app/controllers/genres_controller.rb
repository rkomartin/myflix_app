class GenresController < ApplicationController
  def index
    @genres = Genre.all
  end

  def show
    @genre = Genre.find_by_id(params[:id])
    if @genre.nil?
      flash[:alert] = "This genre does NOT exist!"
      redirect_to genres_path
    end
  end
end