Rails.application.routes.draw do
 root 'posts#index'
 get '/posts/admin', controller: 'posts', action: 'admin'
 get '/posts/notfound', controller: 'posts', as: 'notfound'
 resources :posts
end
