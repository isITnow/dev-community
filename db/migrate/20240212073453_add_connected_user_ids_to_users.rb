class AddConnectedUserIdsToUsers < ActiveRecord::Migration[7.1]
  def up
    add_column :users, :connected_user_ids, :integer, array: true, default: []
    
    ActiveRecord::Base.transaction do
      User.find_each do |user|
        requested_connections = Connection.requested_connections(user.id).where(status: 'accepted')
        received_connections = Connection.received_connections(user.id).where(status: 'accepted')
        connected_user_ids = requested_connections.pluck(:connected_user_id) + received_connections.pluck(:user_id)

        User.where(id: user.id).update_all(connected_user_ids: connected_user_ids)
      end
    end
  end

  def down
    remove_column :users, :connected_user_ids, :integer
  end
end
