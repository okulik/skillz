class WorkerPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @worker = model
  end

  def edit?
    equal
  end

  def update?
    equal
  end

  def destroy?
    equal
  end

  def jobs?
    equal
  end

  def show?
    @current_user.rolable_type == 'Customer' &&
      @current_user.rolable.jobs.where(worker_id: @worker.rolable.id).count > 0
  end

  private
  def equal
    @current_user.rolable_type == 'Worker' && @current_user.rolable == @worker
  end

end
