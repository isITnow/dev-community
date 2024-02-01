class MembersController < ApplicationController
  before_action :set_user!

  def show
  end

  def edit_description
  end
  
  def update_description
    respond_to do |format|
      if @user.update(user_params)
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace('member-description',
                                            partial: 'members/member_description',
                                            locals: { user: @user })
        end
      end
    end
  end

  private

  def set_user!
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:about)
  end
end
