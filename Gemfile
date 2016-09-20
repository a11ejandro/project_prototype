source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.0', '>= 5.0.0.1'
gem 'rack-cors'
# Use Puma as the app server in development
gem 'puma', '~> 3.0'

# Use Sorcery for rest-token authentication
gem 'sorcery'
gem 'listen'

# Use Postgres as main DB
gem 'pg'

# Use jbuilder for convinient JSON templates
gem 'jbuilder'

# Convenient tools for filtering and pagination
gem 'scoped_search'
gem 'will_paginate'

# UI
gem 'haml'
gem 'jquery-rails'
gem 'bootstrap-sass'

# Image management
gem 'mini_magick'
gem 'carrierwave'


gem 'better_errors'
gem 'binding_of_caller', :platforms=>[:mri_19, :mri_20, :rbx]
gem 'rails_layout'

# Use Delayed Job for task scheduling
gem 'delayed_job_active_record'

# API documentation
gem 'swagger-docs'
gem 'swagger-ui_rails'

group :development do
  gem 'capistrano', '~> 3.3.5', require: false
  gem 'capistrano-rvm', '~> 0.1', require: false
  gem 'capistrano-rails', '~> 1.1', require: false
  gem 'capistrano-bundler', '~> 1.1', require: false
  gem 'capistrano-nginx-unicorn', :git => 'https://github.com/timoshenkoav/capistrano-nginx-unicorn.git', :branch => 'master'
  gem 'capistrano-rails-console'
end

group :production, :develop, :staging do
  gem 'unicorn'
end

group :development, :test do
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'rspec-rails'
  gem 'annotate'
  gem 'timecop'
end

group :development, :test, :develop do
  gem 'pry'
  gem 'pry-nav'
  gem 'pry-rails'
end
