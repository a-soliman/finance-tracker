class UsersController < ApplicationController
  def portfolio
    @user = current_user
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
