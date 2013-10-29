require 'sinatra'
require 'better_errors'
require 'sinatra/advanced_routes'
require './lib/clone_wars'

class CloneWarsApp < Sinatra::Base
  register Sinatra::AdvancedRoutes

  set :root, 'lib/app'
  configure :development do
    use BetterErrors::Middleware
    BetterErrors.application_root = "lib/app"
  end

  get '/' do
    erb :index, :layout => false
  end

  get '/:url' do |url|
    page = PageStore.find_by_url(url)
    erb :page, :locals => { :page => page }
  end
end
