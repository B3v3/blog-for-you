RSpec.describe 'follow', type: :feature do
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

  scenario 'Following and unfollowing' do
    visit "/users/#{second_user.nickname}"
    expect(page).to have_content("#{second_user.nickname}")
    click_button 'Follow'
    expect(first_user.following.count).to eq(1)
    expect(second_user.followers.count).to eq(1)
    click_button 'Unfollow'
    expect(first_user.following.count).to eq(0)
    expect(second_user.followers.count).to eq(0)
  end

  it "should change follow button to unfollow button" do
    visit "/users/#{second_user.nickname}"
    click_button 'Follow'
    expect(page).to have_no_button('Follow')
    expect(page).to have_button('Unfollow')
    click_button 'Unfollow'
    expect(page).to have_no_button('Unfollow')
    expect(page).to have_button('Follow')
  end
  it "should change the count of displayed user followers" do
    visit "/users/#{second_user.nickname}"
    click_button 'Follow'
    expect(page).to have_content('1 followers!')
    visit "/users/#{second_user.nickname}"
    click_button 'Unfollow'
    expect(page).to have_content('0 followers!')
  end
end
