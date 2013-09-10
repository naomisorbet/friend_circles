FriendsCircles::Application.routes.draw do
  resources :users, :only => [:new, :create, :show]
  resources :password_resets
  resource :session, :only => [:new, :create, :destroy]
end
