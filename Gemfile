source 'https://rubygems.org'

ruby "2.2.1"

gem 'rails', '4.2.1'
gem 'pg'
gem 'uglifier', '>= 1.3.0'
gem 'oj'
gem 'kaminari'
gem 'puma'
gem 'responders', '~> 2.0'

group :production do
  gem 'rails_12factor'
end

group :development, :test do
  gem 'fabrication'
  gem "faker"
  gem 'cyrillizer'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'quiet_assets'
  gem 'pry'
  gem 'spring'
  gem "spring-commands-rspec"
end

group :test do
  gem 'rspec-rails'
  gem 'database_cleaner'
  gem 'poltergeist'
  gem 'capybara'
end
