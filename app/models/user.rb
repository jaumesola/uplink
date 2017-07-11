############################### Up'n'Link Trunk ############################### 
# Copyright (C) 2012 Jaume Sola - jaumesola.com - upnlink.com
# This software is publicly available under the GPL v3 license terms.
# You may also obtain it under alternative licenses.
# Other files packaged along this one may have a different licensing.
# See the /LICENSE file or http://jaumesola.com/licenses/upnlink.html
###############################################################################

class User < ActiveRecord::Base
  attr_accessible :email, :password, :admin
  include Clearance::User
  
  has_many :uploads, :dependent => :destroy
  
  validates :password, :presence => true, :length => { :minimum => 6 }
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, :format => { :with => email_regex }
  
  # HACK: Clearance::Admin::User DISABLED
  # Below is the code that it should include:
  
  #attr_protected :admin # needs to be accesible
  
  def admin?
    self.admin
  end
  
end
