class AddExpirationIndexToUploads < ActiveRecord::Migration
  def self.up
    add_index :uploads, [ :available, :expiration ]
  end

  def self.down
    remove_index :uploads, [ :available, :expiration ]
  end
end
