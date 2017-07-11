class RemoveFilenameFromUploads < ActiveRecord::Migration
  def self.up
    remove_column :uploads, :filename
  end

  def self.down
    add_column :uploads, :filename, :string    
  end
end
