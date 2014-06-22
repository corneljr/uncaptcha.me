Twiggler::Application.routes.draw do

  resources :users
  root 'test#index'

  post '/captcha', to: 'captchas#js'
  get '/captcha/get', to: 'captchas#get'
  post '/captcha/check', to: 'captchas#check'
  post '/captcha/status', to: 'captchas#status'

  post '/new_domain', to: 'domains#create'

  post '/g0d8kskrjf', to: 'webhooks#index'

end
