module OurApi
  class Weather < Base
    def get_weather
      return { error: "IP, acess key, is invalid" } unless request_valid?

      coordinates = Services::Ip2loc.new(ip).get_ip_coordinates                   # get location coord
      return { error: "coordinates not found" } if coordinates.empty?

      weather = Services::OpenWeatherMap.new(coordinates, timestamp).get_weather  # get weather
      return { error: "weather not found" } if weather.empty?

      weather
    end

    private

    def request_valid?
      timestamp.nil? ? 
        ip_valid? && acess_key_valid? :
        ip_valid? && acess_key_valid? && unix_timestamp_valid?
    end
  end
end
