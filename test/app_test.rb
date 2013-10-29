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

  def app
    CloneWarsApp
  end

  def test_home_page
    get '/'
    assert_equal 200, last_response.status
  end

  def test_about_page
    get '/self-defense-denver'
    assert_equal 200, last_response.status
  end

  def test_page_urls
    pages.each do |page|
      get page.url 
      assert_equal 200, last_response.status
    end
  end
end
