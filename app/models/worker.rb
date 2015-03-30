class Worker < ActiveRecord::Base
  has_one :user, as: :rolable, dependent: :destroy
  has_many :jobs
  has_many :customers, through: :jobs

  scope :any_skills, -> (skills){where('skills && ARRAY[?]', skills)}
  scope :all_skills, -> (skills){where('skills @> ARRAY[?]', skills)}

  def self.create(name:, email:, password:, skills:)
    Worker.new(name: name, skills: skills, user: User.new(email: email, password: password))
  end
end