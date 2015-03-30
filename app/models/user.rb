class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :rememberable, :validatable
  belongs_to :rolable, polymorphic: true
end
