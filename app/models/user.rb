class User < ActiveRecord::Base
  has_one :request
  has_many :tutorabilities
  has_many :tutoringsessions
  # validates :email, format: { with: /@nths219.org|@d219.org/, 
  #   message: "School account only!" }
  def self.from_omniauth(auth)
    where(email:auth.info.email).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.email=auth.info.email
      user.image=auth.info.image
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end
end