############################### Up'n'Link Trunk ############################### 
# Copyright (C) 2012 Jaume Sola - jaumesola.com - upnlink.com
# This software is publicly available under the GPL v3 license terms.
# You may also obtain it under alternative licenses.
# Other files packaged along this one may have a different licensing.
# See the /LICENSE file or http://jaumesola.com/licenses/upnlink.html
###############################################################################

class UserMailer < ActionMailer::Base
  
  def upload_email( upload, download_link, result )
    @upload = upload
    @download_link = download_link
    
    if @upload.email_to == nil
       recipients = upload.user.email
       result.concat 'Email notice sent TO YOU ONLY.'
    else
       recipients = upload.email_to + ', ' + upload.user.email
       result.concat 'Email notice sent to the recipient and yourself.'
    end
    
    mail(
      :from => upload.user.email,
      :to => recipients,
      :subject => "Download #{@upload.filename}"
      )
      
  end
  
end