require 'rails_helper'

describe "User create validate" do
  before(:each) do
    @user = create(:user)
    @attr = {
      phone_number: "0123456789",
      email: "example@example.co.uk",
      password: "password"
    }
  end
  it "should create a new instance given valid attributes" do
    user = User.new(@attr)
    expect(user).to be_valid
  end

  it "should invalid when phone_number wrong" do
    user = User.new(@attr.merge(phone_number: "012x"))
    expect(user).to be_invalid
  end

  it "should invalid when password and confirm_password not match" do
    user = User.new(@attr.merge(password_confirmation: "012x"))
    expect(user).to be_invalid
  end
end