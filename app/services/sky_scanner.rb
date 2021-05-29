require 'uri'
require 'net/http'
require 'openssl'

class SkyScanner
    attr_accessor :response
    def find_airports(params)
        url = URI("https://skyscanner-skyscanner-flight-search-v1.p.rapidapi.com/apiservices/autosuggest/v1.0/#{params["country"]}/#{params["currency"]}/#{params["locale"]}/?query=#{params["query"]}")
        
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        
        request = Net::HTTP::Get.new(url)
        request["x-rapidapi-key"] = ENV["rapid-api-key"]
        request["x-rapidapi-host"] = 'skyscanner-skyscanner-flight-search-v1.p.rapidapi.com'
        
        JSON.parse(http.request(request).response.body)
    end
end