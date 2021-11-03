Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'general#index', as: 'index'

  scope 'users', as: 'users' do
    get '/sign_up', to: 'user#signup', as: 'signup'
    post '/sign_up', to: 'user#signup_form', as: 'signupform'
    post '/login', to: 'user#login', as: 'login'
    get '/dashboard', to: 'user#dashboard', as: 'dashboard'
  end

end
