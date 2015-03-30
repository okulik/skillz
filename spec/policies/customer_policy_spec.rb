describe CustomerPolicy do
  subject { CustomerPolicy }

  let (:current_user) { FactoryGirl.build_stubbed(:customer).user }
  let (:worker) { FactoryGirl.build_stubbed(:worker).user }
  let (:other_customer) { FactoryGirl.build_stubbed(:customer).user }

  permissions :edit? do
    it "allows editing to itself" do
      expect(subject).to permit(current_user)
    end

    it "denies editing of some other customer" do
      expect(subject).not_to permit(current_user, other_customer)
    end

    it "denies editing of some worker" do
      expect(subject).not_to permit(current_user, worker)
    end
  end

  permissions :update? do
    it "allows updating to itself" do
      expect(subject).to permit(current_user)
    end

    it "denies updating of some other customer" do
      expect(subject).not_to permit(current_user, other_customer)
    end
    
    it "denies updating of some worker" do
      expect(subject).not_to permit(current_user, worker)
    end
  end

  permissions :destroy? do
    it "allows deleting to itself" do
      expect(subject).to permit(current_user)
    end

    it "denies deleting of some other customer" do
      expect(subject).not_to permit(current_user, other_customer)
    end
    
    it "denies deleting of some worker" do
      expect(subject).not_to permit(current_user, worker)
    end
  end

  permissions :jobs? do
    it "allows listing jobs to itself" do
      expect(subject).to permit(current_user)
    end

    it "denies listing jobs for some other customer" do
      expect(subject).not_to permit(current_user, other_customer)
    end
    
    it "denies listing jobs of some worker" do
      expect(subject).not_to permit(current_user, worker)
    end
  end

  permissions :create_new_job? do
    it "allows creating new jobs to itself" do
      expect(subject).to permit(current_user)
    end

    it "denies creating new jobs for some other customer" do
      expect(subject).not_to permit(current_user, other_customer)
    end
    
    it "denies creating new jobs for some worker" do
      expect(subject).not_to permit(current_user, worker)
    end
  end
end
