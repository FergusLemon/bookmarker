require 'sinatra/base'
require File.join(File.dirname(__FILE__), 'lib', 'bookmark')

class Bookmarker < Sinatra::Base

  configure do
    enable :method_override
  end

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
    Bookmark.create(params['url'], params['title'])
    redirect '/bookmarks'
  end

  delete '/bookmarks/:id' do
    Bookmark.delete(params['id'])
    redirect 'bookmarks'
  end
end
