require 'spec_helper'

describe Genre do
  it "saves new" do
    genre = Genre.new(category: "Comedy")
    genre.save
    genre.category.should == "Comedy"
  end

  it "has many videos" do
    genre = Genre.create(category: "Comedy")
    video1 = Video.create(title: "Monk", description: "Monk is Monk", small_cover_url: "/tmp/monk.jpg", large_cover_url: "/tmp/monk_large.jpg")
    video2 = Video.create(title: "Family Guy", description: "Well, a guy with a family", small_cover_url: "/tmp/family_guy.jpg", large_cover_url: "/tmp/monk_large.jpg")
    genre.videos << video1
    genre.videos << video2
    genre.videos.size.should == 2
  end

  it {should have_many(:videos)}
end