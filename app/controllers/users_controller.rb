class UsersController < ApplicationController
  def portfolio
    @user = current_user
    puts @user.stocks.inspect
  end
end
