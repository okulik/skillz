class JobsController < ApplicationController
  before_filter :authenticate_user!
  after_action :verify_authorized

  def new
    customer = current_user.rolable
    authorize customer, :create_new_job?

    @job = Job.new
    @worker = Worker.find(params[:wid])
  end

  def create
    customer = current_user.rolable
    authorize customer, :create_new_job?

    job = Job.new(secure_params)
    job.customer_id = current_user.rolable_id
    if job.save
      redirect_to customer_jobs_path(current_user.rolable_id), notice: 'Job created.'
    else
      redirect_to customer_jobs_path(current_user.rolable_id), alert: 'Unable to create job.'
    end
  end

  def secure_params
    params.require(:job).permit(:description, :start_date, :end_date, :worker_id)
  end
end
