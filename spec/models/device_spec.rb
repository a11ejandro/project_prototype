require 'rails_helper'

RSpec.describe Device, type: :model do
  it 'should be valid with default valid params' do
    @device = FactoryGirl.build(:device)
    expect(@device).to be_valid
  end

  it 'should validate presence of token for non-web platforms' do
    @device = FactoryGirl.build(:device, platform: DEVICE_IOS, token: '')
    expect(@device).to_not be_valid
  end

  it 'should not validate presence of token for web platform' do
    @device = FactoryGirl.build(:device, token: '', platform: DEVICE_WEB)
    expect(@device).to be_valid
  end

  it 'should validate inclusion of platform in platforms list' do
    @device = FactoryGirl.build(:device, platform: 'arduino')
    expect(@device).to_not be_valid
  end
end