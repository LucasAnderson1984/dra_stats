# frozen_string_literal: true
require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module DraStats
  class Application < Rails::Application
    config.load_defaults 5.1
    config.api_only = true
  end
end
