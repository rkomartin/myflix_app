require 'spec_helper'

describe QueueItemsController do
  describe "GET index" do
    it "sets the @queue_items to the queue items of the logged in user" do
      alex = Fabricate(:user)
      set_current_user(alex)
      queue_item1 = Fabricate(:queue_item, user: alex)
      queue_item2 = Fabricate(:queue_item, user: alex)
      get :index
      expect(assigns(:queue_items)).to match_array([queue_item1, queue_item2])
    end

    it_behaves_like "requires sign in" do
      let(:action) { get :index }
    end
  end

  describe "POST create" do
    it "redirects to the my queue page" do
      set_current_user
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(response).to redirect_to my_queue_path
    end

    it "creates a queue item" do
      set_current_user
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.count).to eq(1)    
    end

    it "creates the queue item that is associated with the video" do
      set_current_user
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.first.video).to eq(video)  
    end

    it "creates the queue item that is associated with the signed in user" do
      alex = Fabricate(:user)
      set_current_user(alex)
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.first.user).to eq(alex)
    end

    it "puts the video as the last one in the queue" do
      alex = Fabricate(:user)
      set_current_user(alex)
      monk = Fabricate(:video)
      south_park = Fabricate(:video)
      Fabricate(:queue_item, video: monk, user: alex)
      post :create, video_id: south_park.id
      south_park_queue_item = QueueItem.where(video_id: south_park.id, user_id: alex.id).first
      expect(south_park_queue_item.position).to eq(2)
    end

    it "does not add the video to the queue if the video is already in the queue" do
      alex = Fabricate(:user)
      set_current_user(alex)
      monk = Fabricate(:video)
      Fabricate(:queue_item, video: monk, user: alex)
      post :create, video_id: monk.id
      expect(alex.queue_items.count).to eq(1)
    end

    it_behaves_like "requires sign in" do
      let(:action) { post :create, video_id: 3 }
    end
  end

  describe "DELETE destroy" do
    it "redirects to the my queue page" do
      set_current_user
      queue_item = Fabricate(:queue_item)
      delete :destroy, id: queue_item.id
      expect(response).to redirect_to my_queue_path
    end

    it "deletes the queue item" do
      alex = Fabricate(:user)
      set_current_user(alex)
      queue_item = Fabricate(:queue_item, user: alex)
      delete :destroy, id: queue_item.id
      expect(QueueItem.count).to eq(0)
    end

    it "normalizes the remaining queue items" do
      alice = Fabricate(:user)
      set_current_user(alice)
      queue_item1 = Fabricate(:queue_item, user: alice, position: 1)
      queue_item2 = Fabricate(:queue_item, user: alice, position: 2)
      delete :destroy, id: queue_item1.id
      expect(QueueItem.first.position).to eq(1)
    end

    it "does not delete the queue item if the current user does not own that queue item" do
      alex = Fabricate(:user)
      bob = Fabricate(:user)
      set_current_user(alex)
      queue_item = Fabricate(:queue_item, user: bob)
      delete :destroy, id: queue_item.id
      expect(QueueItem.count).to eq(1)
    end

    it_behaves_like "requires sign in" do
      let(:action) { delete :destroy, id: 3 }
    end
  end

  describe "POST update_queue" do
    context "with valid inputs" do
      it "redirects to the my queue page" do
        alice = Fabricate(:user)
        set_current_user(alice)
        video = Fabricate(:video)
        queue_item1 = Fabricate(:queue_item, user: alice, video: video, position: 1)
        queue_item2 = Fabricate(:queue_item, user: alice, video: video, position: 2)
        post :update_queue, queue_items: [{id: queue_item1.id, position: 2}, {id: queue_item2, position: 1}]
        expect(response).to redirect_to my_queue_path
      end

      it "reorders my queue items" do
        alice = Fabricate(:user)
        set_current_user(alice)
        video = Fabricate(:video)
        queue_item1 = Fabricate(:queue_item, user: alice, video: video, position: 1)
        queue_item2 = Fabricate(:queue_item, user: alice, video: video, position: 2)
        post :update_queue, queue_items: [{id: queue_item1.id, position: 2}, {id: queue_item2, position: 1}]
        expect(alice.queue_items).to eq([queue_item2, queue_item1])
      end

      it "normalizes the position numbers" do
        alice = Fabricate(:user)
        set_current_user(alice)
        video = Fabricate(:video)
        queue_item1 = Fabricate(:queue_item, user: alice, video: video, position: 1)
        queue_item2 = Fabricate(:queue_item, user: alice, video: video, position: 2)
        post :update_queue, queue_items: [{id: queue_item1.id, position: 3}, {id: queue_item2, position: 2}]
        expect(alice.queue_items.map(&:position)).to eq([1, 2])        
      end
    end

    context "with invalid inputs" do
      it "redirects to the my queue page" do
        alice = Fabricate(:user)
        set_current_user(alice)
        video = Fabricate(:video)
        queue_item1 = Fabricate(:queue_item, user: alice, video: video, position: 1)
        queue_item2 = Fabricate(:queue_item, user: alice, video: video, position: 2)
        post :update_queue, queue_items: [{id: queue_item1.id, position: 3.4}, {id: queue_item2, position: 2}]
        expect(response).to redirect_to my_queue_path  
      end

      it "sets the flash error message" do
        alice = Fabricate(:user)
        set_current_user(alice)
        video = Fabricate(:video)
        queue_item1 = Fabricate(:queue_item, user: alice, video: video, position: 1)
        queue_item2 = Fabricate(:queue_item, user: alice, video: video, position: 2)
        post :update_queue, queue_items: [{id: queue_item1.id, position: 3.4}, {id: queue_item2, position: 2}]
        expect(flash[:error]).to be_present
      end

      it "does not change the queue items" do
        alice = Fabricate(:user)
        set_current_user(alice)
        video = Fabricate(:video)
        queue_item1 = Fabricate(:queue_item, user: alice, video: video, position: 1)
        queue_item2 = Fabricate(:queue_item, user: alice, video: video, position: 2)
        post :update_queue, queue_items: [{id: queue_item1.id, position: 3}, {id: queue_item2, position: 2.1}]
        expect(queue_item1.reload.position).to eq(1)
      end
    end

    context "with queue items that do not belong to the current users" do
      it "does not change the queue items" do
        alice = Fabricate(:user)
        set_current_user(alice)
        bob = Fabricate(:user)
        video = Fabricate(:video)
        queue_item1 = Fabricate(:queue_item, user: bob, video: video, position: 1)
        queue_item2 = Fabricate(:queue_item, user: alice, video: video, position: 2)
        post :update_queue, queue_items: [{id: queue_item1.id, position: 3}, {id: queue_item2, position: 2}]
        expect(queue_item1.reload.position).to eq(1)
      end
    end

    it_behaves_like "requires sign in" do
      let(:action) { post :update_queue, queue_items: [{id: 2, position: 1}, {id: 5, position: 1}] }
    end
  end
end