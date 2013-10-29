require './test/test_helper'
require './lib/clone_wars'

class PageStoreTest < MiniTest::Test

  def test_it_exists
    assert PageStore
  end

  def test_it_creates_page
    page = PageStore.create({:title => "title omg"})
    assert_kind_of Page, page
    assert_equal "title omg", page.title
  end

end
