require File.expand_path('../boot', __FILE__)

require 'rails/all'
require 'rest_client'
require 'twitter'
require "net/http"
require "uri"
Bundler.require(:default, Rails.env)

module TwitterAPI
  class Application < Rails::Application
    config.assets.enabled = true
    config.assets.js_compressor = :uglifier
    config.assets.css_compressor = :sass
    config.action_controller.page_cache_directory = "#{Rails.root.to_s}/public/deploy"
    config.static_cache_control = "public, max-age=31536000"
  end
end
