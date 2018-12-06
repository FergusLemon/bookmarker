require 'sinatra/base'
require File.join(File.dirname(__FILE__), 'lib', 'bookmark')

class Bookmarker < Sinatra::Base

  before do
    @bookmarks = Bookmark.all
  end

  get '/' do
    erb :index
    redirect '/bookmarks'
  end

  get '/bookmarks' do
    erb :bookmarks
  end

  post '/bookmarks' do
    url = params['url']
    title = params['title']
    Bookmark.create(url, title)
    redirect '/bookmarks'
  end

  post '/bookmarks/delete' do
    id = params['id']
    p id
    Bookmark.delete(id)
    redirect 'bookmarks'
  end
end
