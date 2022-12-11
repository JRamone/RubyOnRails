class WeatherApi
  def self.weather_in(city)
    city = city.downcase.capitalize
    Rails.cache.fetch("#{city}_weather", expires_in: 7.days) { get_weather_in(city) }
  end

  def self.get_weather_in(city)
    url = "http://api.weatherstack.com/current?access_key=#{key}&query=#{ERB::Util.url_encode(city)}"

    response = HTTParty.get url
    weather = Weather.new response.parsed_response['current']
    weather.city = city
    weather
  end

  def self.key
    return nil if Rails.env.test?
    raise 'WEATHERSTACK_APIKEY env variable not defined' if ENV['WEATHERSTACK_APIKEY'].nil?

    ENV.fetch('WEATHERSTACK_APIKEY')
  end
end
