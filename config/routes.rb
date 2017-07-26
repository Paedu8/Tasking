Rails.application.routes.draw do
  
  devise_for :users

  resources :todo_lists do
  	resources :todo_items do
  		collection do
  				match 'search' => "todo_items#search", via: [:get, :post], as: :search
  			end
  		member do 
  			patch :complete

  		end
  	end
end 

  root "todo_lists#index"

end
