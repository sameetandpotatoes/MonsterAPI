# Twitter Session Controller
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
        @three = client.friends.take(4)
        @three.last.name.dup.gsub! @three.last.name, "and " + @three.last.name
        @mentions = client.mentions_timeline
        @suggestions = client.suggestions.take(5)
        @suggestions.last.slug.dup.gsub! @suggestions.last.slug, "and " + @suggestions.last.slug
        @trends = client.trends.take(4)
        @trends.last.name.dup.gsub! @trends.last.name, "and " + @trends.last.name
        @topictweets = []
        count = 0
        topics = ['coffee']
        streaming.filter(track: topics.join(',')) do |object|
          count < 4 ? @topictweets << object.text : break
          count += 1
        end
      rescue Twitter::Error::TooManyRequests => error
        if NUM_ATTEMPTS <= MAX_ATTEMPTS
          sleep error.rate_limit.reset_in
          retry
        else
          raise
        end
      end
      if !current_user.nil? && current_user['e'] == 'all'
        redirect_to '/auth/github'
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
