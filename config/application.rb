# frozen_string_literal: true
require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module DraStats
  class Application < Rails::Application
    config.load_defaults 5.1
    config.api_only = true

    config.generators do |g|
      g.helper_specs false
      g.javascripts false
      g.orm :active_record, primary_key_type: :uuid
      g.stylesheets false
      g.test_framework :rspec
      g.view_specs false
    end
  end
end
