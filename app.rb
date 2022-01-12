require 'sinatra/base'
require 'sinatra/reloader'
require './lib/bookmark'

class BookmarkManager < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  enable :sessions, :method_override

  get '/' do
    "Bookmark Manager"
  end

  get '/bookmarks' do
    
    p @bookmarks = Bookmark.all #logic of retrieving bookmarks from db is done by the Model. 
    erb :'bookmarks/index' 
  end

  get '/bookmarks/new' do 
    erb :'bookmarks/new'
  end

  post '/bookmarks' do 
    Bookmark.create(url: params[:url], title: params[:title]) #needs to be a keyword arg so that we can pass it to the connection.exec() query string in the Model
    redirect '/bookmarks'
  end

  delete '/bookmarks/:id' do #not sure how this :id works!? something to do with override?
    p params #{"_method"=>"DELETE", "id"=>"279"}
    Bookmark.delete(id: params[:id])
    redirect '/bookmarks'
  end

  run! if app_file == $0
end