Rails.application.routes.draw do
  get '/*ip', to: 'api/v1/weather#get_weather_by_ip_address', format: false

  # namespace :api do
  #   namespace :v1 do
  #     resources :weather do
  #       custom routes
  #     end
  #   end
  # end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
