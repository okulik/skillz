FactoryGirl.define do
  factory :job do
    association :worker, strategy: :build
    association :customer, strategy: :build
    description 'Something to remember'
    start_date Date.parse('2015-03-28')
    end_date Date.parse('2015-04-15')
  end
end
