Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post  'logins',     to: 'logins#create'
  delete'logins',     to: 'logins#destroy'

  get   '/users',     to: 'users#index'
  get   '/users/:id', to: 'users#show'
  post  '/users',     to: 'users#create'

  get   '/tags',      to: 'tags#index'
  post  '/tags',      to: 'tags#create'
  post  '/tags/:id',  to: 'tags#update'
end
