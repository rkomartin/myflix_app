class Genre < ActiveRecord::Base
  has_many :videos, order: "created_at DESC"

  def recent_videos
    videos.first(6)
  end
end