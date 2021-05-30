 
class Api::V1::WeatherController < ApplicationController
  def get_weather_by_ip_address
    weather = OurApi::Weather.new(params).get_weather
    render json: weather
  end
end
