# Load the Rails application.
require File.expand_path('../application', __FILE__)
ActionMailer::Base.smtp_settings = {
  :user_name => 'zakaz@poedemvtour.ru',
  :password => 'Silena15',
  :domain => 'poedemvtour.ru',
  :address => 'smtp.mail.ru',
  :port => 465,
  :authentication => :plain,
  :enable_starttls_auto => true
}
# Initialize the Rails application.
Rails.application.initialize!
