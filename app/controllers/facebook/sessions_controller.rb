class Facebook::SessionsController < ApplicationController
  def create
    auth = request.env['omniauth.auth']
    user = User.from_omniauth(auth)
    @graph = Koala::Facebook::API.new(user.oauth_token)
    @profile = @graph.get_object('me')
    @friends = @graph.get_connections('me', 'friends').shuffle!.take(5)
    @events = @graph.get_connections('me', 'events').shuffle!.take(3)
    @interests = @graph.get_connections('me', 'interests').shuffle!.take(3)
    binding.pry
    session[:user_id] = user.id
    if !params['e'].nil?
      user['e'] = 'all'
      user.save!
      redirect_to '/auth/twitter?e=all'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
