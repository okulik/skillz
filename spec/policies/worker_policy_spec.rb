describe WorkerPolicy do
  subject { WorkerPolicy }

  let (:current_user) { FactoryGirl.build_stubbed(:worker).user }
  let (:customer) { FactoryGirl.build_stubbed(:customer).user }
  let (:other_worker) { FactoryGirl.build_stubbed(:worker).user }

  permissions :edit? do
    it "allows editing to itself" do
      expect(subject).to permit(current_user)
    end

    it "denies editing of some other worker" do
      expect(subject).not_to permit(current_user, other_worker)
    end

    it "denies editing of some customer" do
      expect(subject).not_to permit(current_user, customer)
    end
  end

  permissions :update? do
    it "allows updating to itself" do
      expect(subject).to permit(current_user)
    end

    it "denies updating of some other worker" do
      expect(subject).not_to permit(current_user, other_worker)
    end
    
    it "denies updating of some customer" do
      expect(subject).not_to permit(current_user, customer)
    end
  end

  permissions :destroy? do
    it "allows deleting to itself" do
      expect(subject).to permit(current_user)
    end

    it "denies deleting of some other worker" do
      expect(subject).not_to permit(current_user, other_worker)
    end
    
    it "denies deleting of some customer" do
      expect(subject).not_to permit(current_user, customer)
    end
  end

  permissions :jobs? do
    it "allows listing jobs to itself" do
      expect(subject).to permit(current_user)
    end

    it "denies listing jobs of some other worker" do
      expect(subject).not_to permit(current_user, other_worker)
    end
    
    it "denies listing jobs of some customer" do
      expect(subject).not_to permit(current_user, customer)
    end
  end

  permissions :show? do
    let (:job) { FactoryGirl::create(:job) }
    let (:job_worker) { job.worker.user }
    let (:job_customer) { job.customer.user }
    let (:other_worker) { FactoryGirl::create(:worker).user }

    it "allows displaying of worker that was once hired by a customers" do
      expect(subject).to permit(job_customer, job_worker)
    end

    it "denies displaying of worker data to workers" do
      expect(subject).not_to permit(current_user)
    end
    
    it "denies displaying of worker that was never before hired by a customer" do
      expect(subject).not_to permit(job_customer, other_worker)
    end
  end
end
