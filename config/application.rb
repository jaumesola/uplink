############################### Up'n'Link Trunk ###############################
# Copyright (C) 2012 Jaume Sola - jaumesola.com - upnlink.com
# This software is publicly available under the GPL v3 license terms.
# You may also obtain it under alternative licenses.
# Other files packaged along this one may have a different licensing.
# See the /LICENSE file or http://jaumesola.com/licenses/upnlink.html
###############################################################################

require File.expand_path('../boot', __FILE__)

require 'rails/all'


# If you have a Gemfile, require the gems listed there, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env) if defined?(Bundler)

module UpnLink
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    # config.autoload_paths += %W(#{config.root}/extras)
    config.autoload_paths += %W(#{config.root}/app/middleware/)

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # JavaScript files you want as :defaults (application.js is always included).
    # config.action_view.javascript_expansions[:defaults] = %w(jquery rails)

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]
    
  end
end

### Parameters that will normally change for each specific Up'n'Link installation

# (this require doesn't work on Ruby 2 so content pasted below)
# Up'n'Link installation specific parameters 
# require 'config/parameters'

# so e.g. "2.weeks" can be used in upnlink_default_upload_expiration
require 'active_support/core_ext/numeric/time'

module UpnLink
  class Application < Rails::Application
        
    # UpnLink parameters
    config.upnlink_logo_link = 'http://www.example.com' # typically organization's home page
    
    # UNUSED
    # where new users can request an account
    # if set, a "register here" link will be added to the login page
    #config.upnlink_register_link = 'http://www.example.com/register.html'    
    
    config.upnlink_title = "Up'n'Link Default Installation"
    config.upnlink_mailer_sender = 'donotreply@example.com'
    config.upnlink_action_mailer_default_url_options = { :host => 'upnlink.example.com' }
    config.upnlink_action_mailer_default_url_options_test = { :host => 'test.example.com' }
    config.upnlink_action_mailer_default_url_options_development = { :host => 'localhost:3000' } 
    config.upnlink_uploads_directory = "#{Rails.root}/uploads"
    config.upnlink_default_upload_expiration = 1.week
    config.upnlink_minimum_free_disk_space_kb = 2000000 # 2GB
    
  end
end


Clearance.configure do |config|
  config.mailer_sender =  Rails.application.config.upnlink_mailer_sender
end