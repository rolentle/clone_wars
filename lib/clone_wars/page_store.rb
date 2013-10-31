require 'sequel'
require 'sqlite3'
require 'redcarpet'

class PageStore

  def self.create(page_attributes)
    database[:pages].insert(page_attributes)
    Page.new(page_attributes)
  end

  def self.htmlify(raw_markdown)
    markdown.render(raw_markdown)
  end

  def self.markdown
    @markdown ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML)
  end

  def self.all
    database[:pages].to_a.map do |page_data|
      Page.new(page_data)
    end
  end

  def self.database
    return @database if @database && @database.table_exists?(:pages)
    unless ENV['RACK_ENV'] == 'test'
      @database = Sequel.sqlite('db/clone_wars.sqlite3')
    else
      @database = Sequel.sqlite('test/db/clone_wars.sqlite3')
    end
    unless @database.table_exists?(:pages)
      @database.create_table :pages do 
        primary_key :id
        String      :title
        Text        :body
      end
    end
    @database
  end

  def self.clear_table
    database.drop_table(:pages) if database.table_exists?(:pages)
  end

  def self.find_by_url(url)
    all.find do |page|
      page.url == url
    end
  end

  def self.find(id)
    attributes = database.from(:pages).where(:id => id).to_a[0]
    if !attributes.nil?
      Page.new(attributes)
    end
  end

  def self.update(id, attributes)
    status = database.from(:pages).where(:id => id).update(attributes)
    if status > 0
      find(id)
    end
  end

end
