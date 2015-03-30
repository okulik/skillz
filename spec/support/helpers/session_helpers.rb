module Features
  module SessionHelpers
    def sign_up_worker_with(email, password, password_confirmation)
      visit worker_sign_up_path
      fill_in 'user_email', with: email
      fill_in 'user_password', with: password
      fill_in 'user_password_confirmation', with: password_confirmation
      click_button 'Sign up'
    end

    def sign_up_customer_with(email, password, password_confirmation)
      visit customer_sign_up_path
      fill_in 'user_email', with: email
      fill_in 'user_password', with: password
      fill_in 'user_password_confirmation', with: password_confirmation
      click_button 'Sign up'
    end

    def signin(email, password)
      visit new_user_session_path
      fill_in 'user_email', with: email
      fill_in 'user_password', with: password
      click_button 'Sign in'
    end
  end
end
