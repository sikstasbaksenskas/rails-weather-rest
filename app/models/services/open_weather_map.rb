module Services
  class OpenWeatherMap
    # https://openweathermap.org/api/one-call-api

    attr_reader :latitude, :longitude

    BASE_URL = 'https://api.openweathermap.org/data/2.5/onecall'
    ACCESS_KEY = 'cb2c0fb32229e2a63ce9de481f38c64f'
    PARAMS_TO_EXCLUDE = 'hourly,daily,minutely'

    def initialize coordinates
      @longitude = coordinates.dig(:longitude)
      @latitude = coordinates.dig(:latitude)
    end

    def get_weather
      response = RestClient.get "#{BASE_URL}", {
        params: { 
          lat: latitude,
          lon: longitude,
          exclude: PARAMS_TO_EXCLUDE,
          appid: ACCESS_KEY
        }
      }
      return {} unless response.code == 200
      weather response
    end

    private

    def weather weather_info
      data = JSON.parse(weather_info.body)
    end
  end
end
