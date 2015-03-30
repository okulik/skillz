class Customer < ActiveRecord::Base
  has_one :user, as: :rolable, dependent: :destroy
  has_many :jobs
  has_many :workers, through: :jobs

  def self.create(name:, email:, password:)
    Customer.new(name: name, user: User.new(email: email, password: password))
  end
end