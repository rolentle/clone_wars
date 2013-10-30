require './test/test_helper'
require 'rack/test'
require 'pry'

require './lib/app.rb'

class CloneWarsAppTest < Minitest::Test
  include Rack::Test::Methods

  attr_reader :pages

  def setup
    PageStore.create(title: 'This is a title')
    PageStore.create(title: 'Rad Stuff')
    PageStore.create(title: 'Do not read this')
    @pages = PageStore.all
  end
  
  def teardown
    PageStore.clear_table
  end

  def app
    CloneWarsApp
  end

  def test_home_page
    get '/'
    assert_equal 200, last_response.status
  end

  def test_one_page_url
    page = PageStore.create(title: 'does one work')
    get "/#{page.url}"
    assert_equal 200, last_response.status
  end

  def test_page_urls
    pages.each do |page|
      get page.url 
      assert_equal 200, last_response.status
    end
  end

  def test_create_page
    assert_equal 3, PageStore.all.count
    params = {
      :page => {
        :title => "samples",
        :body => "anything"
      }
    }
    post '/page', params
    assert_equal 4, PageStore.all.count
  end

  def test_admin_pages_shows_all_pages
    get '/admin/pages'
    assert_equal 200, last_response.status
  end
end
