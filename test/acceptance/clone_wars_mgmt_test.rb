require './test/test_helper'
require 'bundler'
Bundler.require
require 'rack/test'
require 'capybara'
require 'capybara/dsl'
require 'rack_session_access/capybara'

require './lib/app'

Capybara.app = CloneWarsApp
Capybara.register_driver :rack_test do |app|
  Capybara::RackTest::Driver.new(app, :headers => { 'User-Agent' => 'Capybara' })
end

class CloneWarsMgmtTest < Minitest::Test
  include Capybara::DSL

  attr_reader :admin

  def setup
    @admin = Capybara::Session.new(:rack_test, CloneWarsApp)
    @admin.visit '/login'
    @admin.fill_in 'user', :with => "admin"
    @admin.fill_in 'password', :with => "admin"
    @admin.click_button "Sign in"
  end


  def teardown
    PageStore.clear_table
  end

  def test_can_create_page
    admin.visit '/admin/pages/new'
    admin.fill_in 'title', :with => 'chamber of secrets'
    admin.fill_in 'body', :with => 'harry second year'
    admin.click_button 'Publish'
    assert admin.has_content?('chamber of secrets'), 'page got no content, fool!'
  end

  def test_can_edit_page
    PageStore.create(title: "weema", body: "guts")
    admin.visit '/admin/pages/1/edit'
    assert_equal 'weema', admin.find_field("title").value
    admin.fill_in 'title', :with => 'mouth'
    admin.fill_in 'body', :with => 'teeth'
    admin.click_button 'Re-publish'
    refute admin.has_content?('weema')
    assert admin.has_content?('mouth')
  end

end
