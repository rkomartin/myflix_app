require 'spec_helper'

describe QueueItem do
	it { should belong_to(:user) }
	it { should belong_to(:video) }

	describe "#video_title" do
		it "returns the title of the associated video" do
			video = Fabricate(:video, title: 'Monk')
			queue_item = Fabricate(:queue_item, video: video)
			expect(queue_item.video_title).to eq('Monk')
		end
	end

	describe "#rating" do
		it "returns the rating of the review when the review is present" do
			video = Fabricate(:video)
			user = Fabricate(:user)
			review = Fabricate(:review, user: user, video: video, rating: 4)
			queue_item = Fabricate(:queue_item, user: user, video: video)
			expect(queue_item.rating).to eq(4)
		end

		it "returns nil when the review is not present" do
			video = Fabricate(:video)
			user = Fabricate(:user)
			queue_item = Fabricate(:queue_item, user: user, video: video)
			expect(queue_item.rating).to eq(nil)
		end
	end

	describe "#category_name" do
		it "returns the category's name of the video" do
			genre = Fabricate(:genre, category: "comedies")
			video = Fabricate(:video, genre: genre)
			queue_item = Fabricate(:queue_item, video: video)
			expect(queue_item.category_name).to eq("comedies")
		end
	end

	describe "#genre" do
		it "returns the genre of the video" do
			genre = Fabricate(:genre)
			video = Fabricate(:video, genre: genre)
			queue_item = Fabricate(:queue_item, video: video)
			expect(queue_item.genre).to eq(genre)
		end
	end
end