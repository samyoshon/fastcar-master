class CarsApi

	require 'HTTParty'

	api_response = HTTParty.get("https://www.carqueryapi.com/api/0.3/?callback=?&cmd=getMakes&year=2016&sold_in_us=1")

	puts api_response.body
end
