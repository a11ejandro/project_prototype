class User < ApplicationRecord
  authenticates_with_sorcery!
  scoped_search on: [:first_name, :last_name, :email, :role]

  mount_uploader :avatar, AvatarUploader

  has_many :devices

  validates :email, presence: true
  validates :role, inclusion: [ADMIN, REGULAR_USER, QA]
  validates_uniqueness_of :email
  validates :email, format: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates :password, length: {minimum: 6}, if: -> { new_record? || changes['password'] }

  scope :order_by, ->(field_name = 'id', sort_order = 'asc') do
    if USER_ORDERABLE_FIELDS.include?(field_name) && sort_order.downcase.in?(%w(asc desc))
      order(field_name => sort_order)
    else
      all
    end
  end

  def self.find_by_token(token, role = REGULAR_USER)
    self.where(role: role).joins(:devices).where('devices.auth_token = ?', token).first
  end

  def admin?
    role == ADMIN
  end

  def qa?
    role == QA
  end
end
