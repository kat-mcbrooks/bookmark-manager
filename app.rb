require 'sinatra/base'
require 'sinatra/reloader'
require './lib/bookmark'

class BookmarkManager < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    "Bookmark Manager"
  end

  get '/bookmarks' do
    @bookmarks = Bookmark.all
    erb :'bookmarks/index' 
  end

  get '/bookmarks/new' do 
    erb :'bookmarks/new'
  end

  post '/bookmarks' do 
    Bookmark.create(url: params[:url]) #needs to be a keyword arg so that we can pass it to the connection.exec() query string in the Model
    redirect '/bookmarks'
  end

  run! if app_file == $0
end