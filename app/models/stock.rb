class Stock < ApplicationRecord
  def self.new_lookup(ticker_symbol)
    Polygon.get_closing_price(ticker_symbol)
  end
end
