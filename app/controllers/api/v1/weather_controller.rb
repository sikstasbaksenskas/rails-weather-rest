 
class Api::V1::WeatherController < ApplicationController
  IP_ADDRESS_REGEX = /^((?:(?:^|\.)(?:\d|[1-9]\d|1\d{2}|2[0-4]\d|25[0-5])){4})$/

  def get_weather_by_ip_address
    # validate request data
    render json: { error: "IP or acess key is invalid" } and return unless ip_valid? && acess_key_valid?

    # get location coord
    coordinates = Services::Ip2loc.new(params[:ip]).get_ip_coordinates
    render json: { error: "coordinates not found" } and return if coordinates.empty?

    # get weather
    weather = Services::OpenWeatherMap.new(coordinates).get_weather
    render json: { error: "weather not found" } and return if weather.empty?

    render json: weather
  end

  private

  def ip_valid?
    params[:ip] =~ IP_ADDRESS_REGEX ? true : false
  end

  def acess_key_valid?
    params[:access_key] == '123123' ? true : false
  end
end
