class Stock < ApplicationRecord
  has_many :user_stocks
  has_many :users, through: :user_stocks
  
  def self.new_lookup(ticker_symbol)
    begin
      price = Polygon.get_closing_price(ticker_symbol)
      name = Polygon.get_company_name(ticker_symbol)
      new(ticker: ticker_symbol, name: name, price: price)
    rescue => exception
      puts "exception: #{exception}"
      return nil
    end
  end
end
