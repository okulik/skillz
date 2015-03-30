describe Job do
  subject { FactoryGirl.build(:job) }

  it { should respond_to(:description) }

  it { should respond_to(:start_date) }

  it { should respond_to(:end_date) }

  its('worker.user') { should respond_to(:email) }

  its('customer.user') { should respond_to(:email) }

  it "#description returns a string" do
    expect(subject.description).to match 'Something to remember'
  end

  it "#start_date returns a date" do
    expect(subject.start_date).to match Date.parse('2015-03-28')
  end

  it "#end_date returns a date" do
    expect(subject.end_date).to match Date.parse('2015-04-15')
  end
end
