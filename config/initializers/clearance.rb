  # Configure Clearance someplace sensible,
  # like config/initializers/clearance.rb
  #
  # If you want users to only be signed in during the current session
  # instead of being remembered, do this:
  #
  #   config.cookie_expiration = lambda { }
  #
  # @example
  #   Clearance.configure do |config|
  #     config.mailer_sender     = 'me@example.com'
  #     config.cookie_expiration = lambda { 2.weeks.from_now.utc }
  #   end

Clearance.configure do |config|
  config.cookie_expiration = lambda { 2.weeks.from_now.utc }
end