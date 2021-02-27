Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'public#index'

  get  'search' 	=> 'public#search'
  post 'login/' 	=> 'public#login'
  post 'register/' 	=> 'public#register'

  post 'newlocation/'=> 'member#newlocation'

  get '/@:uri_segment1' 			=> 'member#index'
  get '/@:uri_segment1/activity' 	=> 'member#activity'
  get '/@:uri_segment1/logout' 		=> 'member#logout'
  
end
