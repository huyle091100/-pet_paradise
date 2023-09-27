require 'rails_helper'

describe ProductsController, type: :controller do
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

      it "should let a user see all the products" do
        get :index
        expect( response.code ).to eq("200")
      end
    end

    context "user is staff" do
      before(:each) do
        login_with create( :staff )
      end

      it "should let a user see all the products" do
        get :index
        expect( response.code ).to eq("200")
      end
    end

    context "user is customer" do
      before(:each) do
        login_with create( :user )
      end

      it "shouldn't let a user see all the products" do
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

      it "should go to new products page" do
        get :new
        expect( response.code ).to eq("200")
      end
    end

    context "user is staff" do
      before(:each) do
        login_with create( :staff )
      end

      it "should go to new products page" do
        get :new
        expect( response.code ).to eq("200")
      end
    end

    context "user is customer" do
      before(:each) do
        login_with create( :user )
      end

      it "shouldn't go to new products page" do
        get :new
        expect( response.code ).to eq("302")
      end
    end
  end

  describe "#create" do
    context "admin create new product" do
      before(:each) do
        login_with create( :admin )
      end

      let!(:product_counter) { Product.all.count }
      let(:params){{
        "product": {
          "name": "product name",
          "description": "product description",
          "quantity": 10,
          "price": 10000,
          "category": "dog",
        }
      }}
      
      it "should create a new instance given valid attributes" do
        post :create, params: params
        expect(Product.all.count).to eq(product_counter + 1)
      end
    end

    context "staff create new user" do
      before(:each) do
        login_with create( :staff )
      end

      let!(:product_counter) { Product.all.count }
      let(:params){{
        "product": {
          "name": "product name",
          "description": "product description",
          "quantity": 10,
          "price": 10000,
          "category": "dog",
        }
      }}
      
      it "should create a new instance given valid attributes" do
        post :create, params: params
        expect(Product.all.count).to eq(product_counter + 1)
      end
    end

    context "customer create new user" do
      before(:each) do
        login_with create( :user )
      end

      let!(:product_counter) { Product.all.count }
      let(:params){{
        "product": {
          "name": "product name",
          "description": "product description",
          "quantity": 10,
          "price": 10000,
          "category": "dog",
        }
      }}
      
      it "should create a new instance given valid attributes" do
        post :create, params: params
        expect(Product.all.count).to eq(product_counter)
      end
    end
  end

   describe "#destroy" do
    context "customer destroy an product" do
      before(:each) do
        login_with create( :user )
      end

      let!(:product1) { create( :product ) }
      let!(:product_counter) { Product.all.count }
      let(:params){{
        "id": product1.id,
      }}
      
      it "should't destroy product1" do
        delete :destroy, params: params
        expect(Product.all.count).to eq(product_counter)
      end
    end
  end
end