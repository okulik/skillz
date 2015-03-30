feature 'Sign out', :devise do
  scenario 'user signs out successfully' do
    worker = FactoryGirl.create(:worker)
    signin(worker.user.email, worker.user.password)
    expect(page).to have_content I18n.t 'devise.sessions.signed_in'
    click_link 'Sign out'
    expect(page).to have_content I18n.t 'devise.sessions.signed_out'
  end
end
