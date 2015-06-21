class ApiController < BaseController
  # allow access params on controllers when the request body is JSON.
  use Rack::PostBodyContentTypeParser

  configure :development do
    set :show_exceptions, false #:after_handler
  end

  before do
    content_type :json

    headers 'Access-Control-Allow-Origin' => '*',
            'Access-Control-Allow-Headers' => ['Content-Type']#,
            # 'Access-Control-Allow-Methods' => ['OPTIONS', 'GET', 'POST', 'PUT', 'DELETE']
  end

  error ActiveRecord::RecordNotFound do
    status 404
    env['sinatra.error'].message.to_json
  end

  error Exception do
    status 500
    'Unexpected error'.to_json
  end
end
