class Twitter::SessionsController < ApplicationController
  include TwitterHelper
  MAX_ATTEMPTS = 3
  NUM_ATTEMPTS = 0
  def create
    session[:access_token] = request.env['omniauth.auth']['credentials']['token']
    session[:access_token_secret] = request.env['omniauth.auth']['credentials']['secret']
    redirect_to twitter_show_path, notice: 'Signed in'
  end
  def show
    if session['access_token'] && session['access_token_secret']
      begin
        @user = client.user(include_entities: true)
        @sum = @user.statuses_count + @user.friends_count + @user.followers_count + @user.favorites_count
        @tweets = client.user_timeline.take(3)
        @three = client.friends.take(3)
        @three.last.name.dup.gsub! @three.last.name, "and " + @three.last.name
        @mentions = client.mentions_timeline
        @suggestions = client.suggestions.take(3)
        @suggestions.last.slug.dup.gsub! @suggestions.last.slug, "and " + @suggestions.last.slug
        @trends = client.trends.take(3)
        @trends.last.name.dup.gsub! @trends.last.name, "and " + @trends.last.name
        tweets = []
        count = 0
        topics = ["coffee"]
        streaming.filter(:track => topics.join(",")) do |object|
          count < 3 ? tweets << object.text : break
          count+=1
        end
        count = 0
        random = []
        streaming.sample do |object|
          if (object.is_a?(Twitter::Tweet) && count < 3)
            random << object.text
            count += 1
          else
            break
          end
        end
        binding.pry
      rescue Twitter::Error::TooManyRequests => error
        if NUM_ATTEMPTS <= MAX_ATTEMPTS
          # NOTE: Your process could go to sleep for up to 15 minutes but if you
          # retry any sooner, it will almost certainly fail with the same exception.
          sleep error.rate_limit.reset_in
          retry
        else
          raise
        end
      end
    else
      redirect_to show_path, notice: 'Signed in'
    end
  end

  def error
    flash[:error] = 'Sign in with Twitter failed'
    redirect_to root_path
  end

  def destroy
    reset_session
    redirect_to root_path, notice: 'Signed out'
  end
end
