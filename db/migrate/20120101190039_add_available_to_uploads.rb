class AddAvailableToUploads < ActiveRecord::Migration
  def self.up
    add_column :uploads, :available, :boolean, :default => true, :null => false
  end

  def self.down
    remove_column :uploads, :available
  end
end
