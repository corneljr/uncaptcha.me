Twiggler::Application.routes.draw do
  root 'home#intro'
  get 'home/intro'

  post '/users', to: 'users#create'
  get '/preferences', to: 'users#preferences'
  get '/preferences/edit', to: 'users#edit'
  put '/preferences/update', to: 'users#update'

  get '/captcha/js', to: 'captcha#js'
  get '/captcha/css', to: 'captcha#css'
  get '/captcha/get', to: 'captcha#get'
  post '/captcha/check', to: 'captcha#check'
  post '/captcha/status', to: 'captcha#status'

  post '/new_domain', to: 'domains#create'

  post '/g0d8kskrjf', to: 'webhooks#index'

end
