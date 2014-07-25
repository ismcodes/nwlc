Mail.defaults do
  delivery_method :smtp, { :address   => "smtp.sendgrid.net",
                           :port      => 587,
                           :domain    => "isaacmoldofsky.com",
                           :user_name => "rubular",
                           :password  => ENV['SENDGRID_PASSWORD'],
                           :authentication => 'plain',
                           :enable_starttls_auto => true }
end