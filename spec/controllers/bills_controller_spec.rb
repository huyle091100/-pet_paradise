require 'rails_helper'

describe BillsController, type: :controller do
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

      it "should let a user see all the bills" do
        get :index
        expect( response.code ).to eq("200")
      end
    end

    context "user is staff" do
      before(:each) do
        login_with create( :staff )
      end

      it "should let a user see all the bills" do
        get :index
        expect( response.code ).to eq("200")
      end
    end

    context "user is customer" do
      before(:each) do
        login_with create( :user )
      end

      it "shouldn't let a user see all the bills" do
        get :index
        expect( response.code ).to eq("302")
      end
    end
  end

  describe "#show" do
    context "anonymous user" do
      before(:each) do
        login_with nil
      end

      let!(:bill) { create(:bill) }

      it "redirect to login page" do
        get :show, params: {id: bill.id}
        expect( response ).to redirect_to( new_user_session_path )
      end
    end

    context "user is admin" do
      before(:each) do
        login_with create( :admin )
      end

      let!(:bill) { create(:bill) }

      it "should go to new bills page" do
        get :show, params: {id: bill.id}
        expect( response.code ).to eq("200")
      end
    end

    context "user is staff" do
      before(:each) do
        login_with create( :staff )
      end

      let!(:bill) { create(:bill) }

      it "should go to new bills page" do
        get :show, params: {id: bill.id}
        expect( response.code ).to eq("200")
      end
    end

    context "user is customer" do
      before(:each) do
        login_with create( :user )
      end

      let!(:bill) { create(:bill) }

      it "shouldn't go to new bills page" do
        get :show, params: {id: bill.id}
        expect( response.code ).to eq("302")
      end
    end
  end

  describe "#update" do
    context "customer update a bill" do
      before(:each) do
        login_with create( :user )
      end

      let!(:bill) { create(:bill) }
      let(:params){{
        "id": bill.id
      }}
      
      it "should update a instance given valid attributes" do
        patch :update, params: params
        expect(bill.is_shipped).to eq(false)
      end
    end
  end
end