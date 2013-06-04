require 'spec_helper'

describe Video do
  it "saves new" do
    video = Video.new(title: "Monk", description: "Monk is Monk", small_cover_url: "/tmp/monk.jpg", large_cover_url: "/tmp/monk_large.jpg")
    video.save
    Video.first.title.should == "Monk"
  end

  it "belongs to genre" do
    video = Video.create(title: "Family Guy", description: "Well, a guy with a family", small_cover_url: "/tmp/family_guy.jpg", large_cover_url: "/tmp/monk_large.jpg")
    genre = Genre.create(category: "Comedy")
    video.genre = genre
    video.genre.category.should == "Comedy"
  end

  it "validates presence of title" do
    video = Video.new(description: "Well, a guy with a family", small_cover_url: "/tmp/family_guy.jpg", large_cover_url: "/tmp/monk_large.jpg")
    video.save.should == false
  end

  it "validates presence of description" do
    video = Video.new(title: "Monk", small_cover_url: "/tmp/monk.jpg", large_cover_url: "/tmp/monk_large.jpg")
    video.save.should == false
  end

  it {should belong_to(:genre)}
  it {should validate_presence_of(:title)}
  it {should validate_presence_of(:description)}
end