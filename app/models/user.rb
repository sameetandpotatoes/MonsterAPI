class User < ActiveRecord::Base
  serialize :linkedin_results, JSON
  serialize :github_results, JSON
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid      = auth.uid
      user.oauth_token = auth.credentials.token
      user.linkedin_results ||= {}
      user.github_results ||= {}
      user.save!
    end
  end
end
