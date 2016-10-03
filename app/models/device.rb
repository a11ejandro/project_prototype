class Device < ActiveRecord::Base

  validates :token,    presence: true, if: :platform_has_token?
  validates :platform, inclusion: {in: [DEVICE_ANDROID, DEVICE_IOS, DEVICE_WEB]}

  belongs_to :user

  before_create :set_auth_token

  [DEVICE_ANDROID, DEVICE_IOS, DEVICE_WEB].each do |platform_name|
    define_method "is_#{platform_name}?" do
      self.platform == platform_name
    end
  end

  def platform_has_token?
    self.platform != DEVICE_WEB
  end

  private

  def set_auth_token
    self.auth_token = SecureRandom.uuid
  end
end
