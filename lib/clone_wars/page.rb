class Page

  attr_accessor :title

  def initialize(attributes = {})
    @title = attributes[:title]
  end

  def url
    '/' + title.gsub(' ', '-').downcase
  end

end
