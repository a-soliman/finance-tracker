module UsersHelper
  def full_name(user = current_user)
    return "#{user.first_name} #{user.last_name}" if user.first_name || user.last_name
    "Anonymous"
  end
end
