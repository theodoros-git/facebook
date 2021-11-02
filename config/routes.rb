Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'general#index'

  scope 'users', as: 'users' do
    get '/sign_up', to: 'user#signup', as: 'signup'
    post '/sign_up', to: 'user#signup_form', as: 'signupform'
  end

end
