############################### Up'n'Link Trunk ############################### 
# Copyright (C) 2012 Jaume Sola - jaumesola.com - upnlink.com
# This software is publicly available under the GPL v3 license terms.
# You may also obtain it under alternative licenses.
# Other files packaged along this one may have a different licensing.
# See the /LICENSE file or http://jaumesola.com/licenses/upnlink.html
###############################################################################

# This is recover sessions in flash uploads

require 'rack/utils'
 
class FlashSessionCookieMiddleware
   
  def initialize(app, session_key = '_session_id')
    @app = app
    @session_key = session_key
  end
 
  def call(env)
    if env['HTTP_USER_AGENT'] =~ /^(Adobe|Shockwave) Flash/
      req = Rack::Request.new(env)
      p = req.params
      env['HTTP_COOKIE'] = [ @session_key,
                             req.params[@session_key] ].join('=').freeze unless req.params[@session_key].nil?
      env['HTTP_ACCEPT'] = "#{req.params['_http_accept']}".freeze unless req.params['_http_accept'].nil?
    end
 
    @app.call(env)
  end
  
end