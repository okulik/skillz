FactoryGirl.define do
  factory :customer do
    association :user, strategy: :build
    name 'Lud Blueblood'
  end
end
