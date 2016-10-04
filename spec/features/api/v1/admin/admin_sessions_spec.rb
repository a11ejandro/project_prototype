require 'rails_helper'

RSpec.describe Api::V1::Admin::SessionsController, type: :controller do
  before do
    @admin = FactoryGirl.create(:user, :admin)
    @admin_device = FactoryGirl.create(:device, user: @admin)
    @user = FactoryGirl.create(:user)
    request.accept = 'application/json'
  end

  it 'should not sign in with non - admin credentials' do
    post 'sign_in', params: {email: @user.email, password: 'password'}

    expect(json['status']).to be 107
    expect(json['result']).to eql BASE_ERRORS[:invalid_credentials]
    expect(json['auth_token']).to_not be_present
  end

  it 'should sign in with admin credentials' do
    get_token(@admin)

    expect(json['status']).to be 200
    expect(@auth_token).to be_present
  end

  it 'should change token on logout with valid auth token' do
    get_token(@admin)
    post 'sign_out', params: {auth_token: @auth_token}
    expect(json['status']).to be 200
    expect(Device.find_by(auth_token: @auth_token)).to be_nil
  end
end