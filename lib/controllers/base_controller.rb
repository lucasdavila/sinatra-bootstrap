require 'sinatra/base'
require 'sinatra/reloader' if Sinatra::Base.development?

class BaseController < Sinatra::Base
  set :views, 'lib/views'

  configure :development do
    register Sinatra::Reloader
  end
end
