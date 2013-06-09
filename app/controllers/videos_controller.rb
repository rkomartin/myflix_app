class VideosController < ApplicationController
  before_filter :require_user
  def index
    @videos = Video.all
  end

  def show
    @video = Video.find_by_id(params[:id])
    if @video.nil?
      flash[:alert] = "This video does NOT exist!"
      redirect_to videos_path
    end
  end

  def search
    @results = Video.search_by_title(params[:search_term])
  end
end