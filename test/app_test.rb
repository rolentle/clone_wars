require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require 'rack/test'
require 'pry'

require './lib/app.rb'

class CloneWarsAppTest < Minitest::Test
  include Rack::Test::Methods

  def app
    CloneWarsApp
  end

  def test_home_page
    get '/'
    assert_equal 200, last_response.status
  end
end
