Rails.application.routes.draw do
  get '/*ip/:access_key', to: 'api/v1/weather#get_weather_by_ip_address', format: false
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
