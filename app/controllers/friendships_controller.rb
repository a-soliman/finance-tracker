class FriendshipsController < ApplicationController
  def index
    @user = current_user
  end

  def create
    user_to_follow = User.find(params[:id])
    unless user_to_follow
      flash[:alert] = "Invalid request"
      redirect_to friendships_path, status: :bad_request
      return
    end

    if current_user.following?(user_to_follow)
      flash[:alert] = "Yout are already following #{user_to_follow.first_name}"
      redirect_to friendships_path, status: :bad_request
    else
      @friendship = Friendship.create(user_id: current_user.id, friend_id: user_to_follow.id)
      flash[:notice] = "Yout are now following #{user_to_follow.first_name}"
      redirect_to friendships_path
    end
  end

  def destroy
    user_to_unfollow = User.find(params[:id])
    unless user_to_unfollow
      flash[:alert] = "Invalid request"
      redirect_to friendships_path, status: :bad_request
      return
    end

    unless current_user.following?(user_to_unfollow)
      flash[:alert] = "Yout are already not following #{user_to_follow.first_name}"
      redirect_to friendships_path, status: :bad_request
    end
    friendship = Friendship.find_by_members(current_user.id, user_to_unfollow.id)

    unless friendship
      flash[:alert] = "Something went wrong, please try again later"
      redirect_to friendships_path, status: :bad_request
    end

    friendship.destroy
    flash[:notice] = "Unfollowd successfully"
    redirect_to friendships_path
  end
end