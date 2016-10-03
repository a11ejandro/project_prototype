class CreateDevices < ActiveRecord::Migration[5.0]
  def change
    create_table :devices do |t|
      t.integer  :user_id
      t.string   :token
      t.string   :auth_token
      t.string   :platform, default: DEVICE_WEB

      t.timestamps
    end
  end
end
