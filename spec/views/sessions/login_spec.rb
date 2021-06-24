require 'rails_helper'

describe 'User', type: :feature do
  let(:user) { create(:user) }
  let(:email) { Faker::Internet.email }
  let(:password) { Faker::Internet.password(min_length: 8) }

  describe 'Sign in' do
    before do
      visit(new_user_session_path)
    end

    it 'has the right tab title' do
      expect(page).to have_css('h2', text: 'Log in')
    end

    it 'with valid data' do
      expect do
        within('#new_user') do
          fill_in 'user[email]', with: user.email
          fill_in 'user[password]', with: user.password
          check 'user[remember_me]', allow_label_click: true
          find('#save_user').click
        end
      end.to change { User.count }.by 1
      expect(page).to have_content('Signed in successfully.')
    end

    it 'with not valid data' do
      within('#new_user') do
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: password
        find('#save_user').click
      end
      expect(page).to have_no_text 'Welcome back'
      expect(page).to have_content('Invalid Email or password.')
    end

    it "has a 'Register your account' link" do
      expect(page).to have_selector "a[href='#{new_user_registration_path}']", text: 'Register your account'
      click_on('Register your account')
      expect(current_path).to eql(new_user_registration_path)
    end

    it "has a 'Forgot your password?' link" do
      expect(page).to have_selector "a[href='#{new_user_password_path}']", text: 'Forgot your password?'
      click_on('Forgot your password?')
      expect(current_path).to eql(new_user_password_path)
    end
  end
end
