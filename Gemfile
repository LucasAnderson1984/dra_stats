source 'https://rubygems.org'

ruby '2.3.3'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'classy_enum', '4.0.0'
gem 'figaro'
gem 'jsonapi-resources'
gem 'pg'
gem 'puma', '~> 3.7'
gem 'rack-cors'
gem 'rails', '~> 5.1.4'
gem 'ransack', '~> 1.8.3'
gem 'rubocop', '0.49.1', require: false
gem 'simple_form'

group :development, :test do
  gem 'byebug'
  gem 'letter_opener'
  gem 'rspec-rails'
end

group :development do
  gem 'flay'
  gem 'flog'
  gem 'foreman'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'scss_lint', require: false
  gem 'web-console', '~> 3.5.1'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'rails-controller-testing'
  gem 'shoulda-matchers'
  gem 'simplecov'
end
