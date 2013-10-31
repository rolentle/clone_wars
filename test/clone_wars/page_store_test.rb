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
    # skip
    page = PageStore.create({:title => "title omg"})
    assert_kind_of Page, page
    assert_equal "title omg", page.title
  end

  def test_it_gets_all_pages
    # skip
    pages = PageStore.all
    assert_equal [], pages
    PageStore.create(title: 'First one')
    PageStore.create(title: 'Second one')
    PageStore.create(title: 'Third one')
    assert_equal 3, PageStore.all.count
  end

  def test_it_has_a_database
    # skip
    assert PageStore.database
  end

  def test_it_can_find_by_url
    # skip
    page = PageStore.create(title: 'testing title find')
    found_page = PageStore.find_by_url(page.url)
    assert_equal page.title, found_page.title
  end

  def test_it_can_find_with_id
    page = PageStore.create(title: 'wednesday')
    assert_equal "wednesday", PageStore.find(1).title
  end

  def test_it_can_update_a_page
    PageStore.create(title: 'afternoon', body: 'tea')
    updated_attributes = { title: 'zoom zoom', body: 'boom boom' }
    page = PageStore.update(1, updated_attributes)
    assert_equal "zoom zoom", page.title
    assert_equal "boom boom", page.body
  end

  def test_it_can_convert_md_to_html
    markdown = "#Headline"
    html = PageStore.htmlify(markdown)
    assert_equal "<h1>Headline</h1>\n", html
  end

  def test_html_body_gets_added_to_the_database
    PageStore.create(title: 'Hey', body: '#Test')
     page  = PageStore.find(1)
     assert_equal "<h1>Test</h1>\n", page.html_body
  end


end
