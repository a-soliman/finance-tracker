class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  def self.find_by_members(follower, followee)
    where(["user_id = ? and friend_id = ?", follower, followee]).first
  end
end