RSpec.describe 'comment', type: :feature do
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

  scenario 'creating comment with valid params' do
    second_user
    visit "/posts/#{post.slug}"
     within '.create_comment .new_comment' do
       fill_in 'comment[content]', with: 'najs post'
     end
     click_button 'Submit'
     expect(page).to have_content("#{first_user.nickname} wrote: najs post")
     expect(page).to have_button("Delete")
  end

  scenario 'creating comment with invalid params' do
    second_user
    visit "/posts/#{post.slug}"
     within '.create_comment .new_comment' do
       fill_in 'comment[content]', with: ''
     end
     click_button 'Submit'
     expect(page).to have_no_content("#{first_user.nickname} wrote: najs post")
     expect(page).to have_content("You cant submit a post shorter than 2 characters or longer than 256 characters!")
  end

  scenario 'deleting comment' do
    second_user
    next_post = create(:first_post)
    create(:comment2)
    visit "/posts/#{next_post.slug}"
    expect(page).to have_content("#{second_user.nickname} wrote: lol")
      within '.comment #edit_comment_1' do
        click_button 'Delete'
      end
    expect(page).to have_no_content("#{second_user.nickname} wrote: lol")
    expect(page).to have_content("#{second_user .nickname} wrote: Deleted by #{first_user.nickname}")
  end
end
