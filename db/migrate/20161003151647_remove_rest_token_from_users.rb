class RemoveRestTokenFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :rest_token
  end
end
