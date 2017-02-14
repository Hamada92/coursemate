ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'mocha/mini_test'
require 'sidekiq/testing'
Sidekiq::Testing.fake!


class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  include FactoryGirl::Syntax::Methods

  # Add more helper methods to be used by all tests here...
end


class ActionController::TestCase
  include Devise::Test::ControllerHelpers
end
