class AddExpirationToUploads < ActiveRecord::Migration
  def self.up
    add_column :uploads, :expiration, :date
  end

  def self.down
    remove_column :uploads, :expiration
  end
end
