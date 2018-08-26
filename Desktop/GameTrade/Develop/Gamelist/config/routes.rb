Rails.application.routes.draw do

	root to: 'list#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	patch '/update', to: 'list#update'

end
