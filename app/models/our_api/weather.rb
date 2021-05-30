module OurApi
  class Weather < Base
    def get_weather
      return { error: "IP or acess key is invalid" } unless ip_valid? && acess_key_valid?

      coordinates = Services::Ip2loc.new(ip).get_ip_coordinates        # get location coord
      return { error: "coordinates not found" } if coordinates.empty?

      weather = Services::OpenWeatherMap.new(coordinates).get_weather  # get weather
      return { error: "weather not found" } if weather.empty?

      weather
    end
  end
end
