Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV['TWITTER_CONSUMER_KEY'], ENV['TWITTER_CONSUMER_SECRET']
  provider :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_APP_SECRET'],
            scope: 'basic_info,email,user_likes,user_about_me,user_birthday,
                    user_education_history,user_events,user_groups,
                    user_interests,friends_about_me'
end
