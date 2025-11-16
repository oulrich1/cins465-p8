source 'https://rubygems.org'

ruby '3.3.6'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 7.1.0'

# Use sqlite3 as the database for development/test, mysql for production
gem 'sqlite3', '~> 2.0', group: [:development, :test]
gem 'mysql2', '~> 0.5', group: :production

# Use SCSS for stylesheets
gem 'sass-rails', '~> 6.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster.
gem 'turbolinks', '~> 5'

# Build JSON APIs with ease.
gem 'jbuilder', '~> 2.11'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Use Puma as the app server
gem 'puma', '~> 6.0'

# Sprockets for asset pipeline (keeping for compatibility)
gem 'sprockets-rails'

group :development, :test do
  # Debugging
  gem 'debug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'web-console'
end

gem 'devise', '~> 4.9'
gem 'foundation-rails', '~> 6.7'
gem 'simple_form', '~> 5.3'

# Timezone data for Windows
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
