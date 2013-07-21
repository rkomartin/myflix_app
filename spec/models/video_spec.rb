require 'spec_helper'

describe Video do
  it "saves new" do
    video = Video.new(title: "Monk", description: "Monk is Monk", small_cover: File.open(File.join(Rails.root, "/public/tmp/monk.jpg")), large_cover: File.open(File.join(Rails.root, "/public/tmp/monk_large.jpg")))
    video.save
    Video.first.title.should == "Monk"
  end

  it "belongs to genre" do
    video = Video.create(title: "Family Guy", description: "Well, a guy with a family", small_cover: File.open(File.join(Rails.root, "/public/tmp/monk.jpg")), large_cover: File.open(File.join(Rails.root, "/public/tmp/monk_large.jpg")))
    genre = Genre.create(category: "Comedy")
    video.genre = genre
    video.genre.category.should == "Comedy"
  end

  it "validates presence of title" do
    video = Video.new(description: "Well, a guy with a family", small_cover: File.open(File.join(Rails.root, "/public/tmp/monk.jpg")), large_cover: File.open(File.join(Rails.root, "/public/tmp/monk_large.jpg")))
    video.save.should == false
  end

  it "validates presence of description" do
    video = Video.new(title: "Monk", small_cover: File.open(File.join(Rails.root, "/public/tmp/monk.jpg")), large_cover: File.open(File.join(Rails.root, "/public/tmp/monk_large.jpg")))
    video.save.should == false
  end

  it {should belong_to(:genre)}
  it {should validate_presence_of(:title)}
  it {should validate_presence_of(:description)}
  it {should have_many(:reviews).order("created_at DESC") }

  describe "search_by_title" do
    it "returns an empty array if there is no match" do
      futurama = Video.create(title: "Futurama", description: "Space Travel!")
      back_to_future = Video.create(title: "Back to Future", description: "Time Travel!")
      expect(Video.search_by_title("hello")).to eq([])
    end

    it "returns an array of one video for an exact match" do
      futurama = Video.create(title: "Futurama", description: "Space Travel!")
      back_to_future = Video.create(title: "Back to Future", description: "Time Travel!")
      expect(Video.search_by_title("Futurama")).to eq([futurama])
    end

    it "returns an array of one video for a partial match" do
      futurama = Video.create(title: "Futurama", description: "Space Travel!")
      back_to_future = Video.create(title: "Back to Future", description: "Time Travel!")
      expect(Video.search_by_title("urama")).to eq([futurama])
    end

    it "returns an array of all matches ordered by created_at" do
      futurama = Video.create(title: "Futurama", description: "Space Travel!", created_at: 1.day.ago)
      back_to_future = Video.create(title: "Back to Future", description: "Time Travel!")
      expect(Video.search_by_title("Futur")).to eq([back_to_future, futurama])
    end

    it "returns an empty array for a search with an empty string" do
      futurama = Video.create(title: "Futurama", description: "Space Travel!", created_at: 1.day.ago)
      back_to_future = Video.create(title: "Back to Future", description: "Time Travel!")
      expect(Video.search_by_title("")).to eq([])
    end
  end
end