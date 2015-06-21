require 'sinatra/base'
require 'sinatra/reloader' if Sinatra::Base.development?

class BaseController < Sinatra::Base
  set :views, 'lib/views'
  set :public_folder, 'public'

  configure :development do
    register Sinatra::Reloader
  end
end
