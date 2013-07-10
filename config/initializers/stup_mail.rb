ActionMailer::Base.smtp_settings = {
  :address => "smtp.gmail.com",
  :port => 587,
  :authentication => :plain,
  :domain => 'railscast.com',
  :user_name => 'sachinsingh.7903@gmail.com',
  :password => 'singh22196095',
  :enable_starttls_auto => true
}


