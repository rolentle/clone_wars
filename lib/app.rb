require 'sinatra'
require 'better_errors'
require 'sinatra/advanced_routes'
require './lib/clone_wars'
require "pry"

class CloneWarsApp < Sinatra::Base
  register Sinatra::AdvancedRoutes
  set :method_override, true

  set :root, 'lib/app'
  configure :development do
    use BetterErrors::Middleware
    BetterErrors.application_root = "lib/app"
  end

  not_found do
    erb :not_found
  end

  get '/' do
    erb :index, :layout => false
  end

  post '/page' do
    attributes = params[:page]
    PageStore.create(attributes)
    redirect '/admin/pages'
  end

  put '/page/:id' do |id|
    page = PageStore.update(id.to_i, params[:page])
    if page 
      redirect '/admin/pages'
    else
      redirect "/admin/pages/#{id}/edit"
    end
  end

  get '/admin/pages/new' do
    erb :new_page, :locals => { :page => Page.new }
  end

  get '/admin/pages' do
    erb :admin_pages, :locals => { :pages => PageStore.all }
  end

  get '/admin/pages/:id/edit' do |id|
    page = PageStore.find(id.to_i)
    if page
      erb :edit_page, :locals => { :page => page }
    else
      redirect '/admin/pages'
    end
  end

  get '/:url' do |url|
    page = PageStore.find_by_url(url)
    if page
      erb :page, :locals => { :page => page }
    else
      error 404
    end
  end


end
