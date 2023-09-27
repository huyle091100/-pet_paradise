require 'rails_helper'

describe UsersController, type: :controller do
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

      it "should let a user see all the users" do
        get :index
        expect( response.code ).to eq("200")
      end
    end

    context "user is staff" do
      before(:each) do
        login_with create( :staff )
      end

      it "shouldn't let a user see all the users" do
        get :index
        expect( response.code ).to eq("302")
      end
    end

    context "user is customer" do
      before(:each) do
        login_with create( :user )
      end

      it "shouldn't let a user see all the users" do
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

      it "should go to new user page" do
        get :new
        expect( response.code ).to eq("200")
      end
    end

    context "user is staff" do
      before(:each) do
        login_with create( :staff )
      end

      it "shouldn't go to new user page" do
        get :new
        expect( response.code ).to eq("302")
      end
    end

    context "user is customer" do
      before(:each) do
        login_with create( :user )
      end

      it "shouldn't go to new user page" do
        get :new
        expect( response.code ).to eq("302")
      end
    end
  end

  describe "#create" do
    context "admin create new user" do
      before(:each) do
        login_with create( :admin )
      end

      let!(:user_counter) { User.all.count }
      let(:params){{
        "repeater-group": {
          "0": {
            "email": "user1@example.com"
          },
          "1": {
            "email": "user2@example.com"
          }
        },
        "role": "user"
      }}
      
      it "should create a new instance given valid attributes" do
        post :create, params: params
        expect(User.all.count).to eq(user_counter + 2)
      end
    end

    context "staff create new user" do
      before(:each) do
        login_with create( :staff )
      end

      let!(:user_counter) { User.all.count }
      let(:params){{
        "repeater-group": {
          "0": {
            "email": "user1@example.com"
          },
          "1": {
            "email": "user2@example.com"
          }
        },
        "role": "user"
      }}
      
      it "should create a new instance given valid attributes" do
        post :create, params: params
        expect(User.all.count).to eq(user_counter)
      end
    end

    context "customer create new user" do
      before(:each) do
        login_with create( :user )
      end

      let!(:user_counter) { User.all.count }
      let(:params){{
        "repeater-group": {
          "0": {
            "email": "user1@example.com"
          },
          "1": {
            "email": "user2@example.com"
          }
        },
        "role": "user"
      }}
      
      it "should create a new instance given valid attributes" do
        post :create, params: params
        expect(User.all.count).to eq(user_counter)
      end
    end
  end

  describe "#destroy" do
    context "staff destroy an user" do
      before(:each) do
        login_with create( :staff )
      end

      let!(:user1) { create( :user ) }
      let!(:user_counter) { User.all.count }
      let(:params){{
        "id": user1.id,
      }}
      
      it "shouldn't destroy user1" do
        delete :destroy, params: params
        expect(User.all.count).to eq(user_counter)
      end
    end

    context "customer destroy an user" do
      before(:each) do
        login_with create( :user )
      end

      let!(:user1) { create( :user ) }
      let!(:user_counter) { User.all.count }
      let(:params){{
        "id": user1.id,
      }}
      
      it "should't destroy user1" do
        delete :destroy, params: params
        expect(User.all.count).to eq(user_counter)
      end
    end
  end
end