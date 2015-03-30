describe Worker do
  subject { FactoryGirl.build(:worker) }

  it { should respond_to(:name) }

  it { should respond_to(:skills) }

  its(:user) { should respond_to(:email) }

  its(:user) { should respond_to(:encrypted_password) }

  it "#email returns a string" do
    expect(subject.user.email).to match /person[0-9]+@example.com/
  end

  it "#name returns a string" do
    expect(subject.name).to match 'Polar Bluecollar'
  end

  it "#encrypted_password returns a string" do
    expect(subject.user.encrypted_password).not_to be_empty
  end

  it "#role returns a string" do
    expect(subject.user.rolable_type).to match 'Worker'
  end

  it "#skills return an array" do
    expect(subject.skills).to match(['C++', 'C#', 'Ruby', 'Objective-C', 'JavaScript', 'C', 'Elixir'])
  end

  describe "worker skills" do
    let(:worker) { FactoryGirl.create(:worker) }

    it "should match any skills of the created worker" do
      expect(Worker.any_skills(['Ruby', 'Java']).first).to match @worker
    end

    it "should fail to match any skills" do
      expect(Worker.any_skills(['Go']).count).to be 0
    end

    it "should match all skills of the created user" do
      expect(Worker.all_skills(['Ruby', 'C++']).first).to match @worker
    end

    it "should fail to match all skills" do
      expect(Worker.all_skills(['Ruby', 'Java']).count).to be 0
    end
  end
end
