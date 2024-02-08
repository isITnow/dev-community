module ApplicationHelper
  def get_connection_status user
    current_user.my_connection(user).last.status
  end

  def is_same_user? user
    current_user == user
  end
  def get_status_btn_class status
    "btn " + if status == "pending"
                "btn-primary"
              elsif status == "accepted"
                "btn-success"
              else
                "btn-danger"
              end
  end
end
