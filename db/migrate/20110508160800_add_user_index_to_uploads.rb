class AddUserIndexToUploads < ActiveRecord::Migration
  def self.up
    add_index :uploads, :user_id
  end

  def self.down
    remove_index :uploads, :user_id
  end
end
