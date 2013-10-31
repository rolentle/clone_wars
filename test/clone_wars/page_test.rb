require './test/test_helper'
require './lib/clone_wars/page'

require 'pry'
class PageTest < Minitest::Test

  attr_reader :page, :attributes

  def setup
    @attributes = {
      :title => "Chamber of secrets",
      :body => "Lorem ipsum is way fun"
    }
    @page = Page.new(@attributes)
  end

  def test_page_exists
    assert_kind_of Page, page
  end

  def test_page_has_a_title_and_body
    assert_equal attributes[:title], page.title
    assert_equal attributes[:body], page.body
  end

  def test_page_has_a_url
    assert_equal "chamber-of-secrets", page.url
  end

  def test_page_has_a_clean_url
    page = Page.new(title: "skldfuo$ %% d ?? /sjdlf?'!'")
    assert_equal "skldfuo--d--sjdlf", page.url
  end

  def test_its_has_html_body
    page = Page.new(title: 'Yeah!', body: '###Headline', html_body: "<h3>Headline</h3>\n")
    assert_equal "<h3>Headline</h3>\n", page.html_body
  end
end
