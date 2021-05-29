module Services
  class Ip2loc
    # https://ip2loc.com/documentation

    attr_reader :ip

    BASE_URL = 'https://api.ip2loc.com'
    ACCESS_KEY = '811uvH4OHIuER4TufwE9UiaPch2sffwu'
    PARAMS_TO_INCLUDE = 'country_name,city,location_latitude,location_longitude'

    def initialize ip
      @ip = ip
    end

    def get_ip_coordinates
      response = RestClient.get "#{BASE_URL}/#{ACCESS_KEY}/#{ip}", {
        params: { 
          include: PARAMS_TO_INCLUDE 
        }
      }
      return {} unless response.code == 200
      coordinates response
    end

    private

    def coordinates ip_info
      data = JSON.parse(ip_info.body)
      { latitude: data.dig('location_latitude'), longitude: data.dig('location_longitude') }
    end
  end
end
