class AddUserToUploads < ActiveRecord::Migration
  def self.up
    add_column :uploads, :user_id, :integer
    remove_column :uploads, :email_from
  end

  def self.down
    remove_column :uploads, :user_id
    add_column :uploads, :email_from, :string    
  end
end
