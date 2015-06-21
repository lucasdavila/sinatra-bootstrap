class ResourceController < ApiController
  options '/' do
  end

  # overwrite in a child controller the methods you want to allow to the resource:

  # get '/search' do
  #   search_resources
  # end

  # get '/:id' do
  #   get_resource
  # end

  # get '/' do
  #   get_resources
  # end

  # post '/' do
  #   post_resource
  # end

  # put '/:id' do
  #   put_resource
  # end

  # delete '/:id' do
  #   destroy_resource
  # end

  protected

  # rest methods helpers

  def search_resources
    if params[:q].blank?
      status 400
      [ send_the_query_param_message ].to_json
    else
      resources_to_json search
    end
  end

  def get_resource
    resource_to_json
  end

  def get_resources
    if any_resources_required_param?
      resources_to_json @resources || resources
    else
      status 400
      [ send_at_least_one_param_message(resources_required_params) ].to_json
    end
  end

  def post_resource
    @resource = resource_class.new params

    before_post

    if @resource.save
      after_post
      status 201
      resource_to_json
    else
      status 400
      { errors: @resource.errors }.to_json
    end
  end

  def put_resource
    @resource = resource

    # using request.params instead of params, because params also includes splat and captures params
    # that are not part of the request body.
    if @resource.update request.params
      resource_to_json
    else
      status 400
      { errors: @resource.errors }.to_json
    end
  end

  def delete_resourse
    resource.destroy
  end

  # callbacks

  def before_post
  end

  def after_post
  end

  # resource

  def resource_to_json
    _resource = @resource || resource
    has_serializer? ? serializer_class.new(_resource).to_json(root: false) : _resource.to_json
  end

  def resource
    resource_class.find params[:id]
  end

  def resource_class
    eval resource_class_name
  end

  def resource_class_name
    self.class.name.sub('Controller', '')
  end

  # resources

  def resources_to_json _resources, root = false
    if has_serializer?
      _resources = _resources.map{ |r| serializer_class.new(r).serializable_hash }
    end

    if root
      _resources = { root => _resources }
    end

    _resources.to_json
  end

  def resources
    filter resource_class.all, resources_required_params
  end

  def any_resources_required_param?
    (params.keys & resources_required_params.map(&:to_s)).any?
  end

  def resources_required_params
    []
  end

  def filter query, required_params
    required_params.each do |required_param|
      value = params[required_param]

      next if value.nil?

      name = required_param.to_s
      query = query.where("#{name} = ?", value)
    end

    query
  end

  # search

  def search
    raise 'Please overwrite the search method!'
  end

  # message

  def send_at_least_one_param_message params
    "Please send at least one of these params: #{params.join(', ')}"
  end

  def send_the_query_param_message
    "Please send the query param (q)"
  end
  # serializer

  def serializer_class
    has_serializer? ? eval(serializer_class_name) : nil
  end

  def has_serializer?
    Object.const_defined? serializer_class_name
  end

  def serializer_class_name
    "#{resource_class_name}Serializer"
  end
end
