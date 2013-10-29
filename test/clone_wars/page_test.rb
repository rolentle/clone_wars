require './test/test_helper'
require './lib/clone_wars/page'

class PageTest < Minitest::Test

  attr_reader :page, :attributes

  def setup
    @attributes = {
      :title => "chamber of secrets"
    }
    @page = Page.new(@attributes)
  end

  def test_page_exists
    assert_kind_of Page, page
  end

  def test_page_has_a_title
    assert_equal attributes[:title], page.title
  end

  def test_page_has_a_slug
    assert_equal "chamber-of-secrets", page.slug
  end

end
