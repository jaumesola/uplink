class AddAttachmentColumnToUploads < ActiveRecord::Migration
  def self.up
    add_column :uploads, :attachment, :string
  end

  def self.down
    remove_column :uploads, :attachment
  end
end
