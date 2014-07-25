OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '603675554006-hknct1dq9kuior5k8kq5st3gies7ipu3.apps.googleusercontent.com', ENV['OAUTH_SECRET'], {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end
