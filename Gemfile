source 'https://rubygems.org'

ruby '2.3.0'
gem 'foreman'

# some conflict somewhere- not sure why this is needed
gem 'minitest', '5.8.3'

gem 'rails', '4.2.5'
gem 'pg'

gem 'sass-rails'

gem 'devise'
gem 'omniauth'
gem 'omniauth-stripe-connect'
gem 'omniauth-quickbooks'
gem 'tzinfo-data'
gem 'json'

gem 'stripe'
gem 'stripe_event'
gem 'stripe-ruby-mock'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
end

group :development do
  gem 'awesome_print'
end

group :production do
  gem 'rails_12factor'
end

gem 'dotenv-rails', :groups => [:development, :test]

gem 'gon'
