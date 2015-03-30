class CustomersController < ApplicationController
  include WorkersHelper

  helper_method :display_skills
  before_filter :authenticate_user!
  after_action :verify_authorized

  def jobs
    @customer = Customer.find(params[:customer_id])
    authorize @customer
    @jobs = @customer.jobs
    if params[:skills]
      skills = parse_skills(params[:skills])
      @workers = Worker.all_skills(skills)
      @skills = skills
    else
      @workers = []
      @skills = []
    end
  end 
end