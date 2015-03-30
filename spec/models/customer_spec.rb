describe Customer do
  subject { FactoryGirl.build(:customer) }

  it { should respond_to(:name) }

  its(:user) { should respond_to(:email) }

  its(:user) { should respond_to(:encrypted_password) }

  it "#email returns a string" do
    expect(subject.user.email).to match /person[0-9]+@example.com/
  end

  it "#name returns a string" do
    expect(subject.name).to match 'Lud Blueblood'
  end

  it "#encrypted_password returns a string" do
    expect(subject.user.encrypted_password).not_to be_empty
  end

  it "#role returns a string" do
    expect(subject.user.rolable_type).to match 'Customer'
  end
end
