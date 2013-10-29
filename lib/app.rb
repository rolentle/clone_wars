require 'sinatra'
require 'better_errors'

require './lib/clone_wars'

class CloneWarsApp < Sinatra::Base
  set :root, 'lib/app'
  configure :development do
    use BetterErrors::Middleware
    BetterErrors.application_root = "lib/app"
  end

  get '/' do
    erb :index, :layout => false
  end

  get '/self-defense-denver' do
    erb :page, :locals => { :title => "WEEEE" }
  end

end
