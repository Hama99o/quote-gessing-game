require 'rails_helper'

describe 'User', type: :feature do
  let(:user) { create(:user) }
  let(:email) { Faker::Internet.email }
  let(:password) { Faker::Internet.password(min_length: 8) }

  describe 'Sign up' do
    before do
      visit(new_user_registration_path)
    end

    it "has a 'Play Now' button" do
      click_on('Play')
      expect(current_path).to eql(games_path)
    end

    it 'has the right tab title' do
      expect(page).to have_css('h2', text: 'Sign up')
    end

    it 'with valid data' do
      expect do
        within('#new_user') do
          fill_in 'user[name]', with: 'hama99o'
          fill_in 'user[email]', with: email
          fill_in 'user[password]', with: password
          fill_in 'user[password_confirmation]', with: password
          find('#save_user').click
        end
      end.to change { User.count }.by 1
      expect(page).to have_content('Welcome! You have signed up successfully.')
    end

    it 'with not valid data' do
      expect do
        within('#new_user') do
          find('#save_user').click
        end
      end.not_to change { User.count }
      expect(page).to have_content '4 errors prohibited this user from being saved:'
      expect(page).to have_content "Name can't be blank"
      expect(page).to have_content "Email can't be blank"
      expect(page).to have_content 'Email is invalid'
      expect(page).to have_content "Password can't be blank"
    end

    it 'with not valid email' do
      within('#new_user') do
        fill_in 'user[name]', with: 'hama99o'
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: password
        fill_in 'user[password_confirmation]', with: password
        find('#save_user').click
      end
      expect(page).to have_content('1 error prohibited this user from being saved:')
      expect(page).to have_content('Email has already been taken')
    end

    it "has a 'Log in' link" do
      expect(page).to have_selector "a[href='/users/sign_in']", text: 'Log in'
      click_on('Log in')
      expect(current_path).to eql(new_user_session_path)
    end
  end
end
