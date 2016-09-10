require 'rails_helper'

RSpec.describe User, type: :model do
  it 'should be valid with default valid params' do
    @user = FactoryGirl.build(:user)
    expect(@user).to be_valid
  end

  it 'should validate uniqueness of email' do
    @user_1 = FactoryGirl.create(:user)
    @user_2 = FactoryGirl.build(:user, email: @user_1.email)

    expect(@user_2).to_not be_valid
  end

  it 'should validate presence of email' do
    @user = FactoryGirl.build(:user, email: nil)
    expect(@user.valid?).to be false
  end

  it 'should validate presence of password' do
    @user = FactoryGirl.build(:user, password: nil)
    expect(@user).to_not be_valid
  end

  it 'should validate length of password' do
    @user = FactoryGirl.build(:user, password: '12345')
    expect(@user.valid?).to be false
  end
end
