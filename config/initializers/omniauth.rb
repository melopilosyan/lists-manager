Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_APP_SECRET'],
      scope: 'public_profile', info_fields: 'id,name,link', secure_image_url: true,
      display: 'popup', provider_ignores_state: true
end
