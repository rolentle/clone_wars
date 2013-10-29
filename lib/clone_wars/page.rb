class Page

  attr_accessor :title, :body

  def initialize(attributes = {})
    @title = attributes[:title]
    @body = attributes[:body]
  end

  def url
    title.gsub(' ', '-').downcase.gsub(/[^\w-]/, '')
  end

end
