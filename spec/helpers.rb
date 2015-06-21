module Helpers
  def response_data
    JSON.parse last_response.body
  end

  def model_instance_to_json
    serializer_class ? serializer_class.new(model_instance).to_json(root: false) : model_instance.to_json
  end

  def model_instance
    create model_name
  end

  def last_model_instance_to_json
    serializer_class ? serializer_class.new(last_model_instance).to_json(root: false) : last_model_instance.to_json
  end

  def last_model_instance
    model_class.last
  end

  def model_class
    eval model_name.to_s.classify
  end


  # you can overwrite this method in the spec class, to define a serializer
  # that will be used to JSON converstions

  def serializer_class
  end

  def model_name
    raise 'please define the model_name in a let block'
  end
end
