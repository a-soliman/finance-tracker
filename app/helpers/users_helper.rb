module UsersHelper
  def full_name
    return "#{current_user.first_name} #{current_user.last_name}" if current_user.first_name || current_user.last_name
    "Anonymous"
  end
end
