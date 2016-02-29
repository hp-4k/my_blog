unless Rails.env.production?
  
  Sidekiq.configure_server do |config|
    config.redis = { url: "redis://#{ENV['IP']}:6379" }
  end
  
  Sidekiq.configure_client do |config|
    config.redis = { url: "redis://#{ENV['IP']}:6379" }
  end
  
end