module OurApi
  class Base
    IP_ADDRESS_REGEX = /^((?:(?:^|\.)(?:\d|[1-9]\d|1\d{2}|2[0-4]\d|25[0-5])){4})$/

    attr_reader :ip, :access_key

    def initialize ip, access_key
      @ip = ip
      @access_key = access_key
    end

    private

    def ip_valid?
      ip =~ IP_ADDRESS_REGEX ? true : false
    end
  
    def acess_key_valid?
      access_key == '123123' ? true : false
    end
  end
end
