require 'sinatra/base'
require File.join(File.dirname(__FILE__), 'lib', 'bookmark')
require File.join(File.dirname(__FILE__), 'lib', 'comment')
require File.join(File.dirname(__FILE__), 'lib', 'database_connection_setup')

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
    redirect '/bookmarks'
  end

  get '/bookmarks/:id/edit' do
    @id = params['id']
    erb :edit_bookmarks
  end

  put '/bookmarks/:id' do
    Bookmark.update(params['id'], params['url'], params['title'])
    redirect '/bookmarks'
  end

  get '/bookmarks/:id/add-comment' do
    @bookmark_id = params['id']
    erb :add_comments
  end

  post '/bookmarks/:id' do
    Comment.create(params['bookmark_id'], params['comment'])
    redirect '/bookmarks'
  end

  get 'bookmarks/:id/comments' do
    @comments = Bookmark.get_comments(params[:id])
    erb :view_comments
  end
end
