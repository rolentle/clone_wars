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

  def test_can_create_page
    visit '/admin/pages/new'
    fill_in 'title', :with => 'chamber of secrets'
    fill_in 'body', :with => 'harry second year'
    click_button 'Publish'
    assert page.has_content?('chamber of secrets'), 'page got no content, fool!'
  end

  def test_can_edit_page
    PageStore.create(title: "weema", body: "guts")
    visit '/admin/pages/1/edit'
    assert_equal 'weema', find_field("title").value
    fill_in 'title', :with => 'mouth'
    fill_in 'body', :with => 'teeth'
    click_button 'Re-publish'
    refute page.has_content?('weema')
    assert page.has_content?('mouth')
  end

end
