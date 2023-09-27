require 'rails_helper'

describe RoomsController, type: :controller do
  describe "#index" do
    context "anonymous user" do
      before(:each) do
        login_with nil
      end

      it "redirect to login page" do
        get :index
        expect( response ).to redirect_to( new_user_session_path )
      end
    end

    context "user is admin" do
      before(:each) do
        login_with create( :admin )
      end

      it "should let a user see all the rooms" do
        get :index
        expect( response.code ).to eq("200")
      end
    end

    context "user is staff" do
      before(:each) do
        login_with create( :staff )
      end

      it "shouldn't let a user see all the rooms" do
        get :index
        expect( response.code ).to eq("302")
      end
    end

    context "user is customer" do
      before(:each) do
        login_with create( :user )
      end

      it "shouldn't let a user see all the rooms" do
        get :index
        expect( response.code ).to eq("302")
      end
    end
  end

  describe "#new" do
    context "anonymous user" do
      before(:each) do
        login_with nil
      end

      it "redirect to login page" do
        get :new
        expect( response ).to redirect_to( new_user_session_path )
      end
    end

    context "user is admin" do
      before(:each) do
        login_with create( :admin )
      end

      it "should go to new rooms page" do
        get :new
        expect( response.code ).to eq("200")
      end
    end

    context "user is staff" do
      before(:each) do
        login_with create( :staff )
      end

      it "shouldn't go to new rooms page" do
        get :new
        expect( response.code ).to eq("302")
      end
    end

    context "user is customer" do
      before(:each) do
        login_with create( :user )
      end

      it "shouldn't go to new rooms page" do
        get :new
        expect( response.code ).to eq("302")
      end
    end
  end

  describe "#create" do
    context "admin create new room" do
      before(:each) do
        login_with create( :admin )
      end

      let!(:room_counter) { Room.all.count }
      let(:params){{
        "room": {
          "r_type": "apartment",
          "weight": "less_than_5",
          "quantity": 10,
          "price": 10000,
        }
      }}
      
      it "should create a new instance given valid attributes" do
        post :create, params: params
        expect(Room.all.count).to eq(room_counter + 1)
      end
    end

    context "staff create new user" do
      before(:each) do
        login_with create( :staff )
      end

      let!(:room_counter) { Room.all.count }
      let(:params){{
        "room": {
          "r_type": "apartment",
          "weight": "less_than_5",
          "quantity": 10,
          "price": 10000,
        }
      }}
      
      it "should create a new instance given valid attributes" do
        post :create, params: params
        expect(Room.all.count).to eq(room_counter)
      end
    end

    context "customer create new user" do
      before(:each) do
        login_with create( :user )
      end

      let!(:room_counter) { Room.all.count }
      let(:params){{
        "room": {
          "r_type": "apartment",
          "weight": "less_than_5",
          "quantity": 10,
          "price": 10000,
        }
      }}
      
      it "should create a new instance given valid attributes" do
        post :create, params: params
        expect(Room.all.count).to eq(room_counter)
      end
    end
  end

   describe "#destroy" do
    context "staff destroy a room" do
      before(:each) do
        login_with create( :staff )
      end

      let!(:room1) { create( :room ) }
      let!(:room_counter) { Room.all.count }
      let(:params){{
        "id": room1.id,
      }}
      
      it "shouldn't destroy room1" do
        delete :destroy, params: params
        expect(Room.all.count).to eq(room_counter)
      end
    end

    context "customer destroy an room" do
      before(:each) do
        login_with create( :user )
      end

      let!(:room1) { create( :room ) }
      let!(:room_counter) { Room.all.count }
      let(:params){{
        "id": room1.id,
      }}
      
      it "should't destroy room1" do
        delete :destroy, params: params
        expect(Room.all.count).to eq(room_counter)
      end
    end
  end
end