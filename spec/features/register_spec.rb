RSpec.describe 'register', type: :feature do
  scenario 'valid params' do
    visit '/register'
    within '.create_form .register' do
      fill_in 'Nickname', with: 'D3v3'
      fill_in 'Email', with: 'D3v3@mymail.ru'
      fill_in 'Password', with: 'helloworld'
      fill_in 'Password confirmation', with: 'helloworld'
    end
    click_button 'Register'
    expect(page).to have_content('D3v3')
  end

  scenario 'invalid params' do
    visit '/register'
    within '.create_form .register' do
      fill_in 'Nickname', with: 'D3v3'
      fill_in 'Email', with: ''
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'helloworld'
    end
    click_button 'Register'
    expect(page).to have_content('Email')
    expect(page).to have_content('Password')
    expect(page).to have_button('Register')
  end
end
