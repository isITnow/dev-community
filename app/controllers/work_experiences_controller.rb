class WorkExperiencesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_work_experience, only: %i[edit update destroy]

  def new
    @work_experience = current_user.work_experiences.new
  end
  
  def edit; end

  def create
    @work_experience = current_user.work_experiences.new(work_experience_params)
    respond_to do |format|
      if @work_experience.save
        format.turbo_stream do
          render turbo_stream: turbo_stream.append('work_experience_items',
          partial: 'work_experiences/work_experience', locals: { work_experience: @work_experience })
        end
      else
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace('remote_modal',
          partial: 'shared/turbo_modal', locals: { form_partial: 'work_experiences/form', modal_title: 'Add new work experience' })
        end
      end
    end
  end

  def update; end

  def destroy; end
  

  private

  def set_work_experience
    @work_experience = current_user.work_experiences.find params[:id]
  end

  def work_experience_params
    params.require(:work_experience)
          .permit(:company, :start_date, :end_date, :user_id,
                  :employment_type, :job_title, :currently_working_here,
                  :location, :location_type, :description)
  end
end
