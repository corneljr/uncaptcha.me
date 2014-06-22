Twiggler::Application.routes.draw do
  root 'home#intro'
  get 'home/intro'

  post '/users', to: 'users#create'
  get '/preferences', to: 'users#preferences'
  patch '/preferences/update', to: 'users#update'

  get '/bitcoin_donation', to: 'home#bitcoin_donation'

  get '/captcha/js', to: 'captcha#js'
  get '/captcha/css', to: 'captcha#css'
  get '/captcha/get', to: 'captcha#get'
  post '/captcha/check', to: 'captcha#check'
  get '/captcha/status', to: 'captcha#status'

  post '/g0d8kskrjf', to: 'webhooks#index'

end
