class Facebook::SessionsController < ApplicationController
  def create
    auth = request.env['omniauth.auth']
    # logger.info "AUTH=#{auth.inspect}"
    # logger.info "REQUEST=#{request.inspect}"
    # logger.info request["env"].inspect
    user = User.from_omniauth(auth)
    session[:user_id] = user.id
    redirect_to facebook_home_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end
