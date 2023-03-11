require 'httparty'

class Polygon
  def self.get_closing_price(ticker_symbol)
    api_key = Rails.application.credentials.polygon[:api_key]
    req_url = "https://api.polygon.io/v2/aggs/ticker/#{ticker_symbol}/prev?adjusted=true&apiKey=#{api_key}"
    
    headers = {
      "Content-Type": "application/json"
    }
    response = HTTParty.get(req_url, headers: headers, format: :plain)
    json = JSON.parse response
    closing_price = json["results"][0]["c"]
    closing_price
  end
end