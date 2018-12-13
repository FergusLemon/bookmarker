require 'sinatra/base'
require File.join(File.dirname(__FILE__), 'lib', 'bookmark')
require File.join(File.dirname(__FILE__), 'lib', 'comment')
require File.join(File.dirname(__FILE__), 'lib', 'tag')
require File.join(File.dirname(__FILE__), 'lib', 'bookmark_tag')
require File.join(File.dirname(__FILE__), 'lib', 'user')
require File.join(File.dirname(__FILE__), 'lib', 'database_connection_setup')

class Bookmarker < Sinatra::Base

  configure do
    enable :method_override
    enable :sessions
    set :session_secret, ENV.fetch('SESSION_SECRET') { SecureRandom.hex(64) }
  end

  before do
    @bookmarks = Bookmark.all
  end

  get '/' do
    erb :index
  end

  post '/users' do
    user = User.create(username: params['username'], password: params['password'])
    session[:user_id] = user.id
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

  get '/bookmarks/:id/comments/new' do
    @bookmark_id = params['id']
    erb :add_comments
  end

  post '/bookmarks/:id/comment' do
    Comment.create(params['comment'], params['id'])
    redirect '/bookmarks'
  end

  get '/bookmarks/:id/comments' do
    @comments = Comment.where(params[:id])
    erb :view_comments
  end

  get '/bookmarks/:id/tags/new' do
    @bookmark_id = params['id']
    erb :add_tags
  end

  post '/bookmarks/:id/tag' do
    tag = Tag.create(params['content'], params['id'])
    tag_id = tag.id
    BookmarkTag.create(bookmark_id: params['id'], tag_id: tag_id)
    redirect '/bookmarks'
  end

  get '/bookmarks/:id/tags' do
    @tags = Tag.where(params[:id])
    erb :view_tags
  end

  get '/tags/:id/bookmarks' do
    @bookmarks = Bookmark.where(params['id'])
    erb :view_bookmarks
  end
end
