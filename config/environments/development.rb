# frozen_string_literal: true
Rails.application.configure do
  config.cache_classes = false
  config.eager_load = false
  config.consider_all_requests_local = true
  config.action_controller.perform_caching = false
  config.action_mailer.raise_delivery_errors = false
  config.active_support.deprecation = :log
  config.active_record.migration_error = :page_load
  config.assets.debug = true
  config.assets.digest = true
  config.assets.raise_runtime_errors = true
  config.action_view.raise_on_missing_translations = true
  config.action_controller.action_on_unpermitted_parameters = :raise

  config.action_mailer.default_url_options = { host: Figaro.env.HOST }
  config.action_mailer.delivery_method = :letter_opener
end

Rails.application.routes.default_url_options[:host] = ENV.fetch(
  'HOST',
  'http://localhost:3000'
)
