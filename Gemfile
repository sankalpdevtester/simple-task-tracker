source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.0.4"

# Use postgresql as the database for Active Record
gem "pg", "~> 1.4"

# Use the Puma web server
gem "puma", "~> 5.0"

# Use JavaScript with ESM
gem "jsbundling-rails"

# Hotwire's "turbo-rails" and "stimulus-rails" are not supported in Rails 7
# Use "turbo" and "stimulus" directly
gem "turbo-rails"
gem "stimulus-rails"

# Build JSON APIs with ease
gem "jbuilder", "~> 2.11"

# Use Redis adapter to run Action Cable in production
# gem "redis", "~> 4.0"

# Use Active Storage variant
# gem "image_processing", "~> 1.2"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", ">= 1.4.4", require: false

# Use Rack CORS
gem "rack-cors"

# Use devise for authentication
gem "devise"

# Use react-rails for React integration
gem "react-rails"

group :development, :test do
  # Call "byebug" anywhere in the code to stop execution and get a debugger console
  gem "byebug", platforms: %i[mri mingw x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling "console" anywhere in the code.
  gem "web-console", ">= 4.1.0"
  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # gem "rails-miniprofiler", "~> 2.0"
  # Speed up commands on slow machines
  gem "spring"
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem "capybara", ">= 3.26"
  gem "selenium-webdriver"
  # Easy installation and setup of popular testing libraries
  gem "webdrivers"
end