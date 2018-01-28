require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
  config.root = Rails.root.join('tmp') # adding these...
  config.cache_dir = 'carrierwave' # ...two lines

  config.fog_provider = 'fog/aws'                        # required
  config.fog_credentials = {
    provider:              'AWS',                        # required
    aws_access_key_id:    ENV["AWS_ACCESS_KEY_ID"],
    aws_secret_access_key:  ENV["AWS_SECRET_ACCESS_KEY"],
    region:         ENV["AWS_REGION"],
    endpoint:       ENV["AWS_ENDPOINT"]
  }

  # For testing, upload files to local `tmp` folder.
  if Rails.env.test? || Rails.env.cucumber?
    config.storage = :file
    config.enable_processing = false
    config.root = "#{Rails.root}/tmp"
  end

  if Rails.env.development? 
    config.fog_directory  = ENV["AWS_BUCKET_DEV"]                          # required
  elsif Rails.env.production?
    config.fog_directory  = ENV["AWS_BUCKET_PROD"]
  end                          # required

  # config.s3_access_policy = :public_read                          # Generate http:// urls. Defaults to :authenticated_read (https://)
  config.fog_public     = false                                        # optional, defaults to true
  config.fog_attributes = { 'Cache-Control' => "max-age=#{365.day.to_i}" } # optional, defaults to {}
end
