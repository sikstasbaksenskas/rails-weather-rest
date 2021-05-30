module Services
  class OpenWeatherMap
    # https://openweathermap.org/api/one-call-api

    attr_reader :latitude, :longitude, :timestamp

    BASE_URL = 'https://api.openweathermap.org/data/2.5/onecall'
    ACCESS_KEY = 'cb2c0fb32229e2a63ce9de481f38c64f'
    PARAMS_TO_EXCLUDE = 'hourly,daily,minutely'

    def initialize coordinates, timestamp
      @longitude = coordinates.dig(:longitude)
      @latitude = coordinates.dig(:latitude)
      @timestamp = timestamp
    end

    def get_weather
      response = RestClient.get "#{BASE_URL}", get_weather_params
      return {} unless response.code == 200
      weather response
    end

    private

    def get_weather_params
      params = {
        params: { 
          lat: latitude,
          lon: longitude,
          exclude: PARAMS_TO_EXCLUDE,
          appid: ACCESS_KEY
        }
      }
      params[:params][:dt] = timestamp if timestamp.present?
      params
    end

    def weather weather_info
      JSON.parse weather_info.body
    end
  end
end
