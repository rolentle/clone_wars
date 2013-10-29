require 'yaml/store'

class PageStore

  def self.create(page_attributes)
    database.transaction do
      database['pages'] << page_attributes
    end
    Page.new(page_attributes)
  end

  def self.all
    database.transaction do
      database['pages'].map do |page_data|
        Page.new(page_data)
      end
    end
  end

  def self.database
    return @database if @database
    unless ENV['RACK_ENV'] == 'test'
      @database ||= YAML::Store.new('db/clone_wars')
    else
      @database ||= YAML::Store.new('test/db/clone_wars')
    end
    @database.transaction do
      @database['pages'] ||= []
    end
    @database
  end

  def self.clear_table
    database.transaction do
      database['pages'] = []
    end
  end

  def self.find_by_url(url)
    all.find do |page|
      page.url == url
    end
  end
end
