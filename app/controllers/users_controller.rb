class UsersController < ApplicationController
  def portfolio
    @user = current_user
  end

  def show
    if params[:id].to_i == current_user.id
      redirect_to portfolio_path
    end
    @user = User.find(params[:id])
    puts "\n\nfound user = #{@user.inspect}"
    puts " currentUser: #{current_user.inspect}"
  end

  def search
    term = params[:friend]
    unless term.present?
      flash[:alert] = 'Please enter a name or email'
      redirect_to friendships_path, status: :bad_request
      return
    end
    @users = User.search(term, [current_user.id])
    
    unless @users
      flash[:alert] = "No users found for the given term"
      redirect_to friendships_path, status: :not_found
    end

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace('results', partial: 'users/result', locals: { users: @users})}
    end
  end
end
