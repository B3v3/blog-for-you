RSpec.describe 'post creating', type: :feature do
  let(:first_user) {create(:user)}
  let(:second_user) {create(:user2)}

  before(:each) do
    visit '/login'
    within '.create_form .login' do
      fill_in 'Email', with: first_user.email
      fill_in 'Password', with: first_user.password
    end
    click_button 'Login'
  end

  scenario 'creating post with valid params' do
    visit '/posts/new'
    within '.create_form .post_create .new_post' do
      fill_in 'Title', with: 'Hello Test'
      fill_in 'Content', with: 'Giv me job plz'
    end
    click_button 'submit'
    expect(page).to have_content('Hello Test')
    expect(page).to have_content("by #{first_user.nickname}")
  end

  scenario 'creating post with invalid params' do
    visit '/posts/new'
    within '.create_form .post_create .new_post' do
      fill_in 'Title', with: 'Hello Test'
      fill_in 'Content', with: ''
    end
    click_button 'submit'
    expect(page).to have_content('Title')
    expect(page).to have_content('Content')
    expect(page).to have_button('submit')
  end
end
