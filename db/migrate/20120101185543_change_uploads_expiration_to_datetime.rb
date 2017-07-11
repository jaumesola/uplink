class ChangeUploadsExpirationToDatetime < ActiveRecord::Migration
  def self.up
    change_column :uploads, :expiration, :datetime
  end

  def self.down
    change_column :uploads, :expiration, :date    
  end
end
