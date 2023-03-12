class StocksController < ApplicationController  
  def search
    symbol_param = params[:stock]
    unless symbol_param.present?
      flash.now[:alert] = 'Please enter a symbol to search'
      render 'users/portfolio', status: :bad_request
      return
    end
    @stock = Stock.new_lookup(symbol_param)
    if @stock
      render 'users/portfolio'
    else
      flash.now[:alert] = 'Please enter a valid symbol to search'
      render 'users/portfolio', status: :bad_request
    end
  end
end
