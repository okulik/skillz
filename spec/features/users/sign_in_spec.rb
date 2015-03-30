feature 'Sign in', :devise do
  scenario 'user cannot sign in if not registered' do
    signin('test@example.com', 'please123')
    expect(page).to have_content I18n.t 'devise.failure.not_found_in_database', authentication_keys: 'email'
  end

  scenario 'user can sign in with valid credentials' do
    worker = FactoryGirl.create(:worker)
    signin(worker.user.email, worker.user.password)
    expect(page).to have_content I18n.t 'devise.sessions.signed_in'
  end

  scenario 'user cannot sign in with wrong email' do
    worker = FactoryGirl.create(:worker)
    signin('invalid@email.com', worker.user.password)
    expect(page).to have_content I18n.t 'devise.failure.not_found_in_database', authentication_keys: 'email'
  end

  scenario 'user cannot sign in with wrong password' do
    worker = FactoryGirl.create(:worker)
    signin(worker.user.email, 'invalidpass')
    expect(page).to have_content I18n.t 'devise.failure.invalid', authentication_keys: 'email'
  end
end
