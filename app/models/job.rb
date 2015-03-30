class Job < ActiveRecord::Base
  belongs_to :customer
  belongs_to :worker

  def self.create(worker:, customer:, description:, start_date:, end_date:)
    Job.new worker: worker, customer: customer, description: description, start_date: start_date, end_date: end_date
  end
end