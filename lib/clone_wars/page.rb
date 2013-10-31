class Page

  attr_accessor :title, :body, :id

  def initialize(attributes = {})
    @title = attributes[:title]
    @body = attributes[:body]
    @id = attributes[:id]
  end

  def url
    title.gsub(' ', '-').downcase.gsub(/[^\w-]/, '')
  end

  def html_body
    body
  end

end
