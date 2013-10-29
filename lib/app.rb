require 'sinatra'
require 'better_errors'

class CloneWarsApp < Sinatra::Base
  set :root, 'lib/app'
  configure :development do
    use BetterErrors::Middleware
    BetterErrors.application_root = "lib/app"
  end

  get '/' do
    erb :index
  end
end
