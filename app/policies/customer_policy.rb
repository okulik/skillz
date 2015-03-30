class CustomerPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @customer = model
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

  def create_new_job?
    equal
  end

  private
  def equal
    @current_user.rolable_type == 'Customer' && @current_user.rolable == @customer
  end
end