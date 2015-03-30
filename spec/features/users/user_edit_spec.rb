include Warden::Test::Helpers
Warden.test_mode!

feature 'Worker edit', :devise do
  after(:each) do
    Warden.test_reset!
  end

  scenario 'worker adds skill' do
    worker = FactoryGirl.create(:worker)
    login_as(worker.user, :scope => :user)
    visit worker_edit_path
    fill_in 'Skills', :with => 'Whitespace'
    fill_in 'Current password', :with => worker.user.password
    click_button 'Update'
    txt = I18n.t( 'devise.registrations.updated')
    expect(page).to have_content I18n.t 'devise.registrations.updated'
  end

  scenario "worker cannot edit another worker's profile", :me do
    me = FactoryGirl.create(:worker)
    other = FactoryGirl.create(:worker) { |worker| worker.user.email = 'other@example.com' }
    login_as(me.user, :scope => :user)
    visit worker_edit_path(other)
    expect(page).to have_content 'Edit User'
    expect(page).to have_field('Email', with: me.user.email)
  end

  scenario 'customer changes email' do
    customer = FactoryGirl.create(:customer)
    login_as(customer.user, :scope => :user)
    visit customer_edit_path
    fill_in 'Email', :with => 'somebody.else@example.com'
    fill_in 'Current password', :with => customer.user.password
    click_button 'Update'
    txt = I18n.t( 'devise.registrations.updated')
    expect(page).to have_content I18n.t 'devise.registrations.updated'
  end  
end
