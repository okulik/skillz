class WorkersController < ApplicationController
  before_filter :authenticate_user!
  after_action :verify_authorized

  def show
    @worker = Worker.find_by_id(params[:id])
    unless @worker
      redirect_to workers_path, alert: "Non-existig user."
    else
      authorize @worker
    end
  end

  def jobs
    worker = Worker.find(params[:worker_id])
    authorize worker
    @jobs = worker.jobs
  end
end
