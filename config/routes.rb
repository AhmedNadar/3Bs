Rails.application.routes.draw do
 root 'posts#index'
 get '/posts/admin', controller: 'posts', action: 'admin'
 resources :posts
end
