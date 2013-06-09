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

  describe "#recent_videos" do
    it "returns the videos in the reverse chronological order by created_at" do
      comedies = Genre.create(category: "comedies")
      futurama = Video.create(title: "Futurama", description: "space travel!", genre: comedies, created_at: 1.day.ago)
      south_park = Video.create(title: "South Park", description: "crazy kids!", genre: comedies)
      expect(comedies.recent_videos).to eq([south_park, futurama])
    end

    it "returns all the videos if there are less than 6 videos" do
      comedies = Genre.create(category: "comedies")
      futurama = Video.create(title: "Futurama", description: "space travel!", genre: comedies, created_at: 1.day.ago)
      south_park = Video.create(title: "South Park", description: "crazy kids!", genre: comedies)
      expect(comedies.recent_videos.count).to eq(2)
    end

    it "returns 6 videos if there are more than 6 videos" do
      comedies = Genre.create(category: "comedies")
      7.times {Video.create(title: "foo", description: "bar", genre: comedies)}
      expect(comedies.recent_videos.count).to eq(6)
    end

    it "returns the most recent 6 videos" do
      comedies = Genre.create(category: "comedies")
      6.times {Video.create(title: "foo", description: "bar", genre: comedies)}
      tonights_show = Video.create(title: "Tonights show", description: "talk show", genre: comedies, created_at: 1.day.ago)
      expect(comedies.recent_videos).not_to include(tonights_show)
    end

    it "returns an empty array if the category does not have any videos" do
      comedies = Genre.create(category: "comedies")
      expect(comedies.recent_videos).to eq([])     
    end
  end
end