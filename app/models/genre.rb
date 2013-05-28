class Genre < ActiveRecord::Base
  has_many :videos
end