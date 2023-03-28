class UserStocksController < ApplicationController
  def create
    stock = Stock.check_db(params[:ticker])
    if !stock
      stock = Stock.new_lookup(params[:ticker])
      stock.save
    end
    
    @user_stock = UserStock.create(user: current_user, stock: stock)

    flash[:notice] = "Stock #{stock.name}, was successfully added to your portfolio"
    redirect_to portfolio_path
  end

  private
  def stock_params
    params.require(:stock).permit(:ticker)
  end
end