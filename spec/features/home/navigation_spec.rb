feature 'Navigation links', :devise do
  scenario 'view navigation links' do
    visit root_path
    expect(page).to have_content 'Skillz'
    expect(page).to have_content 'Sign in'
    expect(page).to have_content 'Worker sign up'
    expect(page).to have_content 'Customer sign up'
  end
end
