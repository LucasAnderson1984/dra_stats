# frozen_string_literal: true
require File.expand_path('../config/application', __FILE__)
require 'rubocop/rake_task'

Rails.application.load_tasks
RuboCop::RakeTask.new

task :eslint do
  system('node_modules/.bin/eslint app/assets/javascripts') or exit 1
end

task :client_eslint do
  system('client/node_modules/.bin/eslint client') or exit 1
end

task :scss_lint do
  system('scss-lint client/src/assets') or exit 1
end

namespace :test do
  task :js do
    system('npm test') or exit 1
  end
end

task default: %w(spec test:js rubocop client_eslint eslint scss_lint)
