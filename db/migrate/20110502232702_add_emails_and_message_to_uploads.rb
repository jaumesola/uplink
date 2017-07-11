class AddEmailsAndMessageToUploads < ActiveRecord::Migration
  def self.up
    add_column :uploads, :email_from, :string
    add_column :uploads, :email_to, :string
    add_column :uploads, :message, :text
  end

  def self.down
    remove_column :uploads, :message
    remove_column :uploads, :email_to
    remove_column :uploads, :email_from
  end
end
