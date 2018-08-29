RSpec.describe 'login', type: :feature do
  let(:first_user) {create(:user)}
  scenario 'valid params' do
    visit '/login'
    within '.create_form .login' do
      fill_in 'Email', with: first_user.email
      fill_in 'Password', with: first_user.password
    end
    click_button 'Login'
    expect(page).to have_content('D3v3')
    expect(page).to have_content('Feed')
    expect(page).to have_content('Logout')
  end

  scenario 'invalid params' do
    visit '/login'
    within '.create_form .login' do
      fill_in 'Email', with: ''
      fill_in 'Password', with: first_user.password
    end
    click_button 'Login'
    expect(page).to have_content('Email')
    expect(page).to have_content('Password')
    expect(page).to have_button('Login')
  end

  scenario 'Log out' do
    visit '/login'
    within '.create_form .login' do
      fill_in 'Email', with: first_user.email
      fill_in 'Password', with: first_user.password
    end
    click_button 'Login'
    click_link 'Logout'
    expect(page).to have_content('Email')
    expect(page).to have_content('Password')
    expect(page).to have_button('Login')
  end
end
