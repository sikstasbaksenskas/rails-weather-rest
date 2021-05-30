module OurApi
  class Base
    IP_ADDRESS_REGEX = /^((?:(?:^|\.)(?:\d|[1-9]\d|1\d{2}|2[0-4]\d|25[0-5])){4})$/

    attr_reader :ip, :access_key, :timestamp
    attr_accessor :error

    def initialize params
      @ip = params[:ip]
      @access_key = params[:access_key]
      @timestamp = params[:timestamp]
    end

    private

    def ip_valid?
      ip =~ IP_ADDRESS_REGEX ? true : false
    end
  
    def acess_key_valid?
      access_key == '123123' ? true : false
    end

    def unix_timestamp_valid?
      # timestamp is valid when 
      # 1. it's not nil and contains only integers
      # 2. requested date is from the previous 5 days
      timestamp_valid = timestamp.scan(/\D/).empty?
      return false unless timestamp_valid
      requested_date = Time.at(timestamp.to_i).strftime('%F')
      oldest_available_day = (Time.now - 5.days).strftime('%F')
      requested_date >= oldest_available_day
    end
  end
end
