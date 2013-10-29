require './test/test_helper'
require './lib/clone_wars'

class PageStoreTest < MiniTest::Test

  def teardown
    PageStore.clear_table
  end

  def test_it_exists
    assert PageStore
  end

  def test_it_creates_page
    page = PageStore.create({:title => "title omg"})
    assert_kind_of Page, page
    assert_equal "title omg", page.title
  end

  def test_it_gets_all_pages
    pages = PageStore.all
    assert_equal [], pages
    PageStore.create(title: 'First one')
    PageStore.create(title: 'Second one')
    PageStore.create(title: 'Third one')
    assert_equal 3, PageStore.all.count
  end

  def test_it_has_a_database
    assert PageStore.database
  end

  def test_it_can_find_by_url
    page = PageStore.create(title: 'testing title find')
    found_page = PageStore.find_by_url(page.url)
    assert_equal page.title, found_page.title 
  end
end
