FactoryGirl.define do
  factory :worker do
    association :user, strategy: :build
    name 'Polar Bluecollar'
    skills ['C++', 'C#', 'Ruby', 'Objective-C', 'JavaScript', 'C', 'Elixir']
  end
end
