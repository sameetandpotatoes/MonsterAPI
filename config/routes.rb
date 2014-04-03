TwitterAPI::Application.routes.draw do
  get '/', to: 'pages#home', as: 'root'
  root 'pages#home', as: 'home'
  get '/all', to: 'pages#all', as: 'all'
  scope module: 'linkedin' do
    if Rails.env.development?
      get '/auth/linkedin', to: redirect('https://www.linkedin.com/uas/oauth2/authorization?response_type=code&client_id=75z6k06m8oq8ee&scope=r_fullprofile+rw_nus+r_contactinfo+r_network&state=DCEEFf424&redirect_uri=http://localhost:3000/auth/linkedin/callback')
    else
      get '/auth/linkedin', to: redirect('https://www.linkedin.com/uas/oauth2/authorization?response_type=code&client_id=75kxz9etany3wc&scope=r_fullprofile+rw_nus+r_contactinfo+r_network&state=DCEEFf424&redirect_uri=http://monsterapi.herokuapp.com/auth/linkedin/callback')
    end
    get '/auth/linkedin/callback', to: 'sessions#create', as: 'linkedin_sessions'
  end
  scope module: 'github' do
    if Rails.env.development?
      get '/auth/github', to: redirect('https://github.com/login/oauth/authorize?scope=user:email&client_id=8cf2d11f0dab4703c71f')
    else
      get '/auth/github', to: redirect('https://github.com/login/oauth/authorize?scope=user:email&client_id=cfa43a5294fcefe70d7b')
    end
    get '/auth/github/callback', to: 'sessions#create', as: 'github_sessions'
    get '/auth/failure', to: 'sessions#error'
  end
  namespace :twitter do
    get '/', to: 'home#home', as: 'home'
    get '/profile', to: 'sessions#show', as: 'show'
    delete '/signout', to: 'sessions#destroy', as: 'signout'
  end
  scope module: 'twitter' do
    get '/auth/twitter/callback', to: 'sessions#create', as: 'callback'
    get '/auth/failure', to: 'sessions#error', as: 'failure'
  end
  namespace :facebook do
    get '/', to: 'home#home', as: 'home'
  end
  scope module: 'facebook' do
    get 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
    get 'auth/failure', to: redirect('/'), via: [:get, :post]
    get 'signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]
  end
end
