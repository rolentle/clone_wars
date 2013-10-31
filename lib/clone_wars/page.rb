class Page

  attr_accessor :title, :body, :id, :html_body

  def initialize(attributes = {})
    @title = attributes[:title]
    @body = attributes[:body]
    @id = attributes[:id]
    @html_body = attributes[:html_body]
  end

  def url
    title.gsub(' ', '-').downcase.gsub(/[^\w-]/, '')
  end
end
