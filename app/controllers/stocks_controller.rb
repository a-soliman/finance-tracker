class StocksController < ApplicationController  
  def search
    symbol_param = params[:stock]
    unless symbol_param.present?
      flash[:alert] = 'Please enter a symbol to search'
      redirect_to portfolio_path, status: :bad_request
      return
    end
    @stock = Stock.new_lookup(symbol_param)
    if @stock
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace('results', partial: 'users/result', locals: { stock: @stock }) }
      end
    else
      flash[:alert] = 'Please enter a valid symbol to search'
      redirect_to portfolio_path, status: :bad_request
    end
  end
end
