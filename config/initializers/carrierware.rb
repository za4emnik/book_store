if Rails.env.development? || Rails.env.test?
  CarrierWave.configure do |config|
    config.storage = :file
  end
end

if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
      provider:              'AWS',
      aws_access_key_id:     ENV['AWS_ACCESS_KEY_ID'],
      aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
      region:                ENV['AWS_REGION']
    }
    config.storage = :fog
    config.fog_directory  = ENV['AWS_FOG_DIRECTORY']
    config.fog_public     = false
    config.fog_attributes = { cache_control: "public, max-age=#{365.day.to_i}" }
  end
end
