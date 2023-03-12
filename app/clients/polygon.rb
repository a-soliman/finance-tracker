require 'httparty'

API_KEY = Rails.application.credentials.polygon[:api_key]

# Polygon, an interface that works with the Polygon platform
class Polygon
  def self.get_company_name(ticker_symbol)
    req_url = "https://api.polygon.io/v3/reference/tickers/#{ticker_symbol}?apiKey=#{API_KEY}"
    headers = {
      'Content-Type': 'application/json'
    }
    response = HTTParty.get(req_url, headers: headers, format: :plain)
    json = JSON.parse response

    json['results']['name']
  end

  def self.get_closing_price(ticker_symbol)
    req_url = "https://api.polygon.io/v2/aggs/ticker/#{ticker_symbol}/prev?adjusted=true&apiKey=#{API_KEY}"
    headers = {
      'Content-Type': 'application/json'
    }
    response = HTTParty.get(req_url, headers: headers, format: :plain)
    json = JSON.parse response
    json['results'][0]['c'] # closing price
  end
end
