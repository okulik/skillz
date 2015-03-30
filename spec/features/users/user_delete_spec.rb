include Warden::Test::Helpers
Warden.test_mode!

feature 'User delete', :devise, js: true do
  after(:each) do
    Warden.test_reset!
  end

  scenario 'worker can delete own account' do
    skip 'skip a slow test'
    worker = FactoryGirl.create(:worker)
    login_as(worker.user, :scope => :user)
    visit worker_edit_path
    click_button 'Cancel my account'
    expect(page).to have_content I18n.t 'devise.registrations.destroyed'
  end

  scenario 'customer can delete own account' do
    skip 'skip a slow test'
    customer = FactoryGirl.create(:customer)
    login_as(customer.user, :scope => :user)
    visit customer_edit_path
    click_button 'Cancel my account'
    expect(page).to have_content I18n.t 'devise.registrations.destroyed'
  end
end
