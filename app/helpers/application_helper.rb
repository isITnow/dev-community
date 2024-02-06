module ApplicationHelper
  def get_connection_status(current_user, user)
    current_user.connections.find_by(connected_user_id: user.id ).status
  end

  def is_same_user?(current_user, user)
    current_user == user
  end
end
