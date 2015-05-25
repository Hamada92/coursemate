ENV['RAILS_ENV'] ||= 'test'
require 'spec_helper'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'capybara/rails'

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|

  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!
end

def login(user)
  page.driver.post user_session_path, 'user[email]' => user.email, 'user[password]' => user.password
end

def create_question
  visit '/questions/new'
  select 'Course Related', from: 'Category'
  fill_in 'Name', with: 'CISC 121'
  fill_in 'Title', with: 'How to write a for loop in python?'
  fill_in 'Body', with: 'Can someone explain for loops?'
  click_button 'Post'
  expect(page).to have_content('How to write a for loop in python?')

end