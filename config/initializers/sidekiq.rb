Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://10.137.128.220:6379' }
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://10.137.128.220:6379' }
end
