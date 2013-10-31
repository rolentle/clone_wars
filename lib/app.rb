require 'sinatra'
require 'better_errors'
require 'sinatra/advanced_routes'
require './lib/clone_wars'
require 'rack_session_access'
require "pry"

class CloneWarsApp < Sinatra::Base
  register Sinatra::AdvancedRoutes
  set :method_override, true
  set :root, 'lib/app'

  configure :development do
    use BetterErrors::Middleware
    BetterErrors.application_root = "lib/app"
  end

  configure do
    enable :sessions
  end

  helpers do
    def authenticate!
      if params[:user] == "admin" && params[:password] == "admin"
        session[:user] == "admin"
      end
      #redirect '/login' unless session[:user]
    end
  end

  not_found do
    erb :not_found
  end

  get '/' do
    erb :index, :layout => false
  end
  
  ['/page', '/page/'].each do |url|
    post url do
      authenticate!
      attributes = params[:page]
      PageStore.create(attributes)
      redirect '/admin/pages'
    end
  end

  put '/page/:id' do |id|
    authenticate!
    page = PageStore.update(id.to_i, params[:page])
    if page
      redirect '/admin/pages'
    else
      redirect "/admin/pages/#{id}/edit"
    end
  end

  get '/admin/pages' do
    authenticate!
    erb :admin_pages, :locals => { :pages => PageStore.all, :title => 'Pages' },
                      :layout => :admin_layout
  end

  get '/admin/pages/new' do
    authenticate!
    erb :new_page, :locals => { :page => Page.new, :title => "New Page" }, :layout => :admin_layout
  end

  get '/admin/pages/:id/edit' do |id|
    authenticate!
    page = PageStore.find(id.to_i)
    if page
      erb :edit_page, :locals => { :page => page, :title => "Edit Page" },
                      :layout => :admin_layout
    else
      redirect '/admin/pages'
    end
  end

  get '/login' do
    erb :login, :layout => false
  end

  post '/login' do
    if params[:user] == "admin" && params[:password] == "admin"
      session[:user] = "admin"
      redirect '/admin/pages'
    else
      redirect '/'
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
