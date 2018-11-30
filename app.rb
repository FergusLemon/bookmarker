require 'sinatra/base'

class Bookmarker < Sinatra::Base

  get '/' do
    'Hello World'
  end
end
