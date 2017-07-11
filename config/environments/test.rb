############################### Up'n'Link Trunk ###############################
# Copyright (C) 2012 Jaume Sola - jaumesola.com - upnlink.com
# This software is publicly available under the GPL v3 license terms.
# You may also obtain it under alternative licenses.
# Other files packaged along this one may have a different licensing.
# See the /LICENSE file or http://jaumesola.com/licenses/upnlink.html
###############################################################################

UpnLink::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # The test environment is used exclusively to run your application's
  # test suite.  You never need to work with it otherwise.  Remember that
  # your test database is "scratch space" for the test suite and is wiped
  # and recreated between test runs.  Don't rely on the data there!
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false
  
  ### Mailer

  config.action_mailer.raise_delivery_errors = true

  # :sendmail defaults to:
  # config.action_mailer.sendmail_settings = {
  #   :location => '/usr/sbin/sendmail',
  #   :arguments => '-i -t'
  # }
  config.action_mailer.delivery_method = :sendmail
  # Remove -t option for CentOS/Exim
  config.action_mailer.sendmail_settings = { :arguments => '-i' }
  config.action_mailer.perform_deliveries = true

  # for clearance  
  config.action_mailer.default_url_options = config.upnlink_action_mailer_default_url_options_test
  
  # Specifies the header that your server uses for sending files

  # X-SENDIFLE FOR APACHE
  # IMPORTANT: mod_xsendfile must be installed on the server
  # and the following directives added to the domain's VirtualHost
  # XSendFile on
  # XSendFilePath /home/path/to/rails/uploads
  config.action_dispatch.x_sendfile_header = "X-Sendfile"
  
  # Disable Rails's static asset server
  # In production, Apache or nginx will already do this
  config.serve_static_assets = false
  
  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation can not be found)
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners
  config.active_support.deprecation = :notify
  
     

  # Raise exceptions instead of rendering exception templates
  config.action_dispatch.show_exceptions = false

  # Disable request forgery protection in test environment
  config.action_controller.allow_forgery_protection    = false

  # Tell Action Mailer not to deliver emails to the real world.
  # The :test delivery method accumulates sent emails in the
  # ActionMailer::Base.deliveries array.
  #config.action_mailer.delivery_method = :test

  # Use SQL instead of Active Record's schema dumper when creating the test database.
  # This is necessary if your schema can't be completely dumped by the schema dumper,
  # like if you have constraints or database-specific column types
  # config.active_record.schema_format = :sql

  # Print deprecation notices to the stderr
  config.active_support.deprecation = :stderr
    
  # log more
  config.active_support.log_activity = true
  config.active_support.log_level = :debug
  config.log_level = :debug
  
end