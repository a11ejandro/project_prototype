class AddBasicFieldsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :birthday, :date, default: Date.parse("1970-01-01")
    add_column :users, :first_name, :string, default: ''
    add_column :users, :last_name, :string, default: ''
    add_column :users, :role, :string, default: REGULAR_USER
    add_column :users, :avatar, :string
    add_column :users, :state, :string
    add_column :users, :rest_token, :string, default: SecureRandom.uuid
  end
end
