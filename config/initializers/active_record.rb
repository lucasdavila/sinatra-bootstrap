# remove deprecation warning (of future implementation) on models that mount carrierwave uploader
# TODO remove this on new versions of active record
ActiveRecord::Base.raise_in_transactional_callbacks = true
