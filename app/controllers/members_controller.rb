class MembersController < ApplicationController
  before_action :authenticate_user!, only: %i[edit_description update_description edit_personal_details update_personal_details]
  before_action :set_user!, only: %i[show]

  def show
    @connections = Connection.where('user_id = ? OR connected_user_id = ?',
                                    @user.id, @user.id).where(status: 'accepted')
  end

  def edit_description; end
  
  def update_description
    respond_to do |format|
      if current_user.update(user_description_params)
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace('member-description',
                                            partial: 'members/member_description',
                                            locals: { user: current_user })
        end
      end
    end
  end

  def edit_personal_details; end

  def update_personal_details
    respond_to do |format|
      if current_user.update(user_personal_details_params)
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace('member-personal-details',
                                            partial: 'members/member_personal_details',
                                            locals: { user: current_user })
        end
      end
    end
  end

  def connections
    @requested_connections = Connection.requested_connections(params[:id])
                                        .where(status: 'accepted')
    @received_connections = Connection.received_connections(params[:id])
                                        .where(status: 'accepted')
    @total_connections = @requested_connections.count + @received_connections.count
  end
  
  private

  def set_user!
    @user = User.find(params[:id])
  end

  def user_description_params
    params.require(:user).permit(:about)
  end

  def user_personal_details_params
    params.require(:user).permit(:first_name, :last_name, :city, :state, :country, :pincode, :profile_title)
  end
end
