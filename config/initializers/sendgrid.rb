if Rails.env.development?

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  user_name:            ENV["SENDGRID_USERNAME_DEV"],
  password:             ENV["SENDGRID_PASSWORD_DEV"],
  domain:               ENV["SENDGRID_DOMAIN_DEV"],
  address:              ENV["SENDGRID_ADDRESS_DEV"],
  port:                 587,
  authentication:       'plain',
  enable_starttls_auto: true 
}

elsif Rails.env.production?

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  user_name:            ENV["SENDGRID_USERNAME_PROD"],
  password:             ENV["SENDGRID_PASSWORD_PROD"],
  domain:               ENV["SENDGRID_DOMAIN_PROD"],
  address:              ENV["SENDGRID_ADDRESS_PROD"],
  port:                 587,
  authentication:       'plain',
  enable_starttls_auto: true 
}

end