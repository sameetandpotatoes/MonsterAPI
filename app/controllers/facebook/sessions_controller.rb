class Facebook::SessionsController < ApplicationController
  def create
    auth = request.env['omniauth.auth']
    user = User.from_omniauth(auth)
    session[:user_id] = user.id
    if params["e"].nil?
      redirect_to facebook_home_path
    else
      user["e"] = "all"
      user.save!
      redirect_to "/auth/twitter?e=all"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
