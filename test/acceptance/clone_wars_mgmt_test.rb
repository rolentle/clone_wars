require './test/test_helper'
require 'bundler'
Bundler.require
require 'rack/test'
require 'capybara'
require 'capybara/dsl'
require './lib/app'

Capybara.app = CloneWarsApp
Capybara.register_driver :rack_test do |app|
  Capybara::RackTest::Driver.new(app, :headers => { 'User-Agent' => 'Capybara' })
end

class CloneWarsMgmtTest < Minitest::Test
  include Capybara::DSL

  def teardown
    PageStore.clear_table
  end

  def test_create_edit_page
    visit '/admin/pages/new'
    fill_in 'title', :with => 'chamber of secrets'
    fill_in 'body', :with => 'harry second year'
    click_button 'Publish'
    assert page.has_content?('chamber of secrets'), 'page got no content, fool!'
  end

end
