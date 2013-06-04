class Video < ActiveRecord::Base
  belongs_to :genre
  
  validates :title, presence: true
  validates :description, presence: true
end