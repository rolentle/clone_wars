class Page

  attr_accessor :title

  def initialize(attributes = {})
    @title = attributes[:title]
  end

  def slug
    title.gsub(' ', '-')
  end

end
