require 'rails_helper'

describe 'User', type: :feature do
  let(:user) { create(:user) }
  let(:email) { Faker::Internet.email }
  let(:password) { Faker::Internet.password(min_length: 8) }

  describe 'forget password' do
    before do
      visit(new_user_password_path)
    end

    it 'has the right tab title' do
      expect(page).to have_css('h2', text: 'Forgot your password?')
    end

    it 'will send email' do
      within('#new_user') do
        fill_in 'user[email]', with: user.email
        find('#send_email').click
      end
      expect(page).to have_text('You will receive an email with instructions on how to reset your password in a few minutes.')
      expect(current_path).to eql(new_user_session_path)
    end

    it 'will not send email' do
      within('#new_user') do
        fill_in 'user[email]', with: email
        find('#send_email').click
      end
      expect(page).to have_content('1 error prohibited this user from being saved:')
      expect(page).to have_content('Email not found')
    end

    it "has a 'Register your account' link" do
      expect(page).to have_selector "a[href='#{new_user_registration_path}']", text: 'Register your account'
      click_on('Register your account')
      expect(current_path).to eql(new_user_registration_path)
    end

    it "has a 'Log in' link" do
      expect(page).to have_selector "a[href='/users/sign_in']", text: 'Log in'
      click_on('Log in')
      expect(current_path).to eql(new_user_session_path)
    end
  end
end
