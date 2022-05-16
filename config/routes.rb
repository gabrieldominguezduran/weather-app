Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#show"
  get '/countries', to: 'home#countries'
  post '/states', to: 'home#states'
  post '/cities', to: 'home#cities'
  post '/weather', to: 'home#weather'
end
