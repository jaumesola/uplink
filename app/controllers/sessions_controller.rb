############################### Up'n'Link Trunk ############################### 
# Copyright (C) 2012 Jaume Sola - jaumesola.com - upnlink.com
# This software is publicly available under the GPL v3 license terms.
# You may also obtain it under alternative licenses.
# Other files packaged along this one may have a different licensing.
# See the /LICENSE file or http://jaumesola.com/licenses/upnlink.html
###############################################################################

class SessionsController < Clearance::SessionsController
   
  def flash_success_after_create
     # no message 
  end

  def flash_success_after_destroy
     # no message 
  end

  def flash_failure_after_create
    # only message changed from original
    flash.now[:failure] = translate(:bad_email_or_password,
      :scope   => [:clearance, :controllers, :sessions],
      :default => "Incorrect email or password.")
  end
    
end