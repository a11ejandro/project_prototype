require 'rails_helper'

RSpec.describe Api::V1::SessionsController, type: :controller do
  before do
    request.accept = 'application/json'
  end

  it 'should retrieve rest token with valid request' do
      get_token

      expect(json['status']).to be 200
      expect(@rest_token).to be_present
  end

  it 'should change token on logout with valid rest token' do
    @user = FactoryGirl.create(:user)
    get_token(@user)
    post 'sign_out', params: { rest_token: @rest_token }
    expect(json['status']).to be 200
    expect(@user.rest_token).to_not eql @rest_token
  end

  it 'should register with valid credentials' do
    last_user = User.last
    post 'sign_up', params: {email: 'valid@email.com', password: 'password'}
    expect(json['status']).to be 200

    new_user = User.last
    expect(new_user).to_not eql last_user
    expect(new_user.role).to eql REGULAR_USER
  end
end