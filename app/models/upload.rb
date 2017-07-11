############################### Up'n'Link Trunk ############################### 
# Copyright (C) 2012 Jaume Sola - jaumesola.com - upnlink.com
# This software is publicly available under the GPL v3 license terms.
# You may also obtain it under alternative licenses.
# Other files packaged along this one may have a different licensing.
# See the /LICENSE file or http://jaumesola.com/licenses/upnlink.html
###############################################################################

class Upload < ActiveRecord::Base
    attr_accessible :attachment, :email_to, :message, :expiration, :available
    validates_presence_of :attachment #use if the attribute is required
    mount_uploader :attachment, AttachmentUploader
    
    belongs_to :user
    
    before_create :set_expiration
    
    def set_expiration
       self.expiration = Time.now +
         Rails.application.config.upnlink_default_upload_expiration
    end
    
    def filename
       File.basename( attachment.url )
    end
    
    def self.delete_expired
      
      # Delete expired files to preserve storage space
      # Note that database rows are kept, but
      # the "available" column is set to false as a flag 
      
      @ups = Upload::find( :all,  
        :conditions => [ 'available = ? AND expiration < ?', true, Time.now ],
        :order => :attachment
        ) 
        
      @ups.each do |u|
        u.remove_attachment!
        u.available = false
        # for some reason the attachment validation fails,
        # for that reason we disable validation checking 
        saved = u.save :validate => false
      end

    end
    
end