class User < ActiveRecord::Base
  serialize :linkedin_results, JSON
  serialize :github_results, JSON
  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end

  end
end
