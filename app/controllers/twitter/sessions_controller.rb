class Twitter::SessionsController < ApplicationController
  def create
    # logger.info request.inspect
    # logger.info request.env.inspect
    # logger.info request["env"].inspect
    # logger.info request.env['omniauth.auth']
    session[:access_token] = request.env['omniauth.auth']['credentials']['token']
    session[:access_token_secret] = request.env['omniauth.auth']['credentials']['secret']
    redirect_to twitter_show_path, notice: 'Signed in'
  end

  def show
    if session['access_token'] && session['access_token_secret']
      @user = client.user(include_entities: true)
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
