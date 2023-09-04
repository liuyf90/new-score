# Load the Rails application.
require_relative "application"
# Set the default time zone to Beijing.
Rails.application.configure do
    config.time_zone = 'Beijing'
end
# Initialize the Rails application.
Rails.application.initialize!


