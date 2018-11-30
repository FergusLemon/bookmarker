require 'sinatra/base'
require File.join(File.dirname(__FILE__), 'lib', 'bookmark')

class Bookmarker < Sinatra::Base

  before do
    @bookmark_list = Bookmark.all
  end

  get '/' do
    erb :index
  end
end
