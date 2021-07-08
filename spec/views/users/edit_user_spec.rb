require 'rails_helper'

describe 'Edit', type: :feature do
  let(:email) { Faker::Internet.email }
  let(:password) { Faker::Internet.password(min_length: 8) }
  let(:user) { create(:user) }

  before do
    log_in(user)
  end

  describe 'user ' do
    before do
      visit(edit_user_registration_path)
    end

    it 'has the right tab title' do
      expect(page).to have_css('h2', text: 'Edit')
    end

    it "has a 'Back' button" do
      expect(page).to have_selector "a[href='#{profile_path}']", text: 'Back'
      click_on('Back')
      expect(current_path).to eql(profile_path)
    end

    it "has a 'Delete My account' button" do
      expect(page).to have_selector "a[href='/users']", text: 'Delete My account'

      expect do
        click_on('Delete My account')
      end.to change { User.count }.by(-1)
    end

    it 'should change name' do
      expect do
        within('#edit_user') do
          fill_in 'user[name]', with: 'peter'
          fill_in 'user[current_password]', with: user.password
          find('#save_user').click
        end
      end.to change { user.reload.name }.to 'peter'
      expect(current_path).to eql(profile_path)
      expect(page).to have_content 'Your account has been updated successfully.'
    end

    it 'should change email' do
      expect do
        within('#edit_user') do
          fill_in 'user[email]', with: email
          fill_in 'user[current_password]', with: user.password
          find('#save_user').click
        end
      end.to change { user.reload.email }.to email
      expect(current_path).to eql(profile_path)
      expect(page).to have_content 'Your account has been updated successfully.'
    end

    it 'should change password' do
      within('#edit_user') do
        fill_in 'user[password]', with: password
        fill_in 'user[password_confirmation]', with: password
        fill_in 'user[current_password]', with: user.password
        find('#save_user').click
      end
      expect(current_path).to eql(profile_path)
      expect(page).to have_content 'Your account has been updated successfully.'
    end

    it 'should not change with incurrent password' do
      within('#edit_user') do
        fill_in 'user[name]', with: 'peter'
        fill_in 'user[current_password]', with: password
        find('#save_user').click
      end
      expect(page).to have_content '1 error prohibited this user from being saved:'
      expect(page).to have_content 'Current password is invalid'
    end

    it 'should not change name without password' do
      within('#edit_user') do
        fill_in 'user[name]', with: 'peter'
        find('#save_user').click
      end
      expect(page).to have_content '1 error prohibited this user from being saved:'
      expect(page).to have_content "Current password can't be blank"
    end
  end
end
