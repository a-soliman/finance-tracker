class Stock < ApplicationRecord
  has_many :user_stocks
  has_many :users, through: :user_stocks

  validates :name, :ticker, presence: true

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

  def self.check_db(ticker_symbol)
    Stock.where("ticker", ticker_symbol).first
  end
end
