# config/initializers/recaptcha.rb
Recaptcha.configure do |config|
  config.site_key  = ENV['RECAPTCHA_ASKTODAY_PUBLIC_KEY']
  config.secret_key = ENV['RECAPTCHA_ASKTODAY_PRIVATE_KEY']
end