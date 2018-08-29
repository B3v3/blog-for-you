RSpec.describe 'like', type: :feature do
  let(:first_user) {create(:user)}
  let(:second_user) {create(:user2)}
  let(:post) {create(:post, user_id: 2)}

  before(:each) do
    visit '/login'
    within '.create_form .login' do
      fill_in 'Email', with: first_user.email
      fill_in 'Password', with: first_user.password
    end
    click_button 'Login'
  end

  scenario 'Liking and disliking post' do
    second_user
    visit "/posts/#{post.slug}"
    expect(page).to have_content '0 likes!'
    click_button 'Like'
    expect(page).to have_content '1 like!'
    expect(page).to have_no_button 'Like'
    expect(page).to have_button 'Dislike'
    click_button 'Dislike'
    expect(page).to have_content '0 likes!'
    expect(page).to have_no_button 'Dislike'
    expect(page).to have_button 'Like'
  end
end
