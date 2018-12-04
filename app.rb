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
    Bookmark.new(url)
    redirect '/bookmarks'
  end
end
