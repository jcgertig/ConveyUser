Rails.application.config.middleware.use OmniAuth::Builder do
  provider :convey, ENV['CONVEY_ID'], ENV['CONVEY_SECRET']
end
