module SessionHelper
  def log_in(user)
    # let(:user) { create(:user) }
    visit new_user_session_path
    within('#new_user') do
      fill_in "user[email]", with: user.email
      fill_in "user[password]", with: user.password
      find('#save_user').click
    end
  end
end
