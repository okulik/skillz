feature 'Sign Up', :devise do
  scenario 'visitor can sign up as a worker with valid email address and password' do
    sign_up_worker_with('test@example.com', 'please123', 'please123')
    expect(page).to have_content I18n.t 'devise.registrations.signed_up'
  end

  scenario 'visitor can sign up as a customer with valid email address and password' do
    sign_up_customer_with('test@example.com', 'please123', 'please123')
    expect(page).to have_content I18n.t 'devise.registrations.signed_up'
  end

  scenario 'visitor cannot sign up as a worker with invalid email address' do
    sign_up_worker_with('bogus', 'please123', 'please123')
    expect(page).to have_content 'Email is invalid'
  end

  scenario 'visitor cannot sign up as a customer with invalid email address' do
    sign_up_customer_with('bogus', 'please123', 'please123')
    expect(page).to have_content 'Email is invalid'
  end

  scenario 'visitor cannot sign up as a worker without password' do
    sign_up_worker_with('test@example.com', '', '')
    expect(page).to have_content "Password can't be blank"
  end

  scenario 'visitor cannot sign up as a customer without password' do
    sign_up_customer_with('test@example.com', '', '')
    expect(page).to have_content "Password can't be blank"
  end

  scenario 'visitor cannot sign up as a worker with a short password' do
    sign_up_worker_with('test@example.com', 'please', 'please')
    expect(page).to have_content "Password is too short"
  end

  scenario 'visitor cannot sign up as a customer with a short password' do
    sign_up_customer_with('test@example.com', 'please', 'please')
    expect(page).to have_content "Password is too short"
  end

  scenario 'visitor cannot sign up as a worker without password confirmation' do
    sign_up_worker_with('test@example.com', 'please123', '')
    expect(page).to have_content "Password confirmation doesn't match"
  end

  scenario 'visitor cannot sign up as a customer without password confirmation' do
    sign_up_customer_with('test@example.com', 'please123', '')
    expect(page).to have_content "Password confirmation doesn't match"
  end

  scenario 'visitor cannot sign up as a worker with mismatched password and confirmation' do
    sign_up_worker_with('test@example.com', 'please123', 'mismatch')
    expect(page).to have_content "Password confirmation doesn't match"
  end

  scenario 'visitor cannot sign up as a customer with mismatched password and confirmation' do
    sign_up_customer_with('test@example.com', 'please123', 'mismatch')
    expect(page).to have_content "Password confirmation doesn't match"
  end
end
