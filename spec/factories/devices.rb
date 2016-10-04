FactoryGirl.define do
  factory :device do
    platform [DEVICE_WEB, DEVICE_ANDROID, DEVICE_IOS].sample
    token {"#{platform}-token"}
    auth_token SecureRandom.uuid
  end
end
