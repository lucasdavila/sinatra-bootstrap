class HomeController < BaseController
  get '/' do
    erb :index
  end
end
