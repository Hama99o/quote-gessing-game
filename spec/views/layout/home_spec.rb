require 'rails_helper'

describe 'Games', type: :feature do
  RSpec.shared_examples 'Home page' do
    before do
      visit(home_path)
    end

    it 'has the wellcome text' do
      expect(page).to have_css('h3', class: 'wellcome-text',
                                     text: 'Thank you for coming to our site. Enjoy your quote guessing game.')
    end

    it "has a 'Play Now' button" do
      click_on('Play Now')
      expect(current_path).to eql(games_path)
    end

    it 'has the right tab title' do
      expect(page).to have_title('Home')
    end

    it "has a 'hama99O' link" do
      href = 'https://github.com/Hama99o'
      expect(page).to have_content('hama99O')
      expect(page).to have_selector("a[href='#{href}']", text: 'hama99O')
    end

    it "has a 'Play' button" do
      expect(page).to have_selector "a[href='/game']", text: 'Play'
      click_on('Play')
      expect(current_path).to eql(games_path)
    end

    it "has a 'Profile' button" do
      expect(page).to have_selector "a[href='/profile']", text: 'Profile'
      click_on('Profile')
      expect(current_path).to eql(profile_path)
    end
  end

  describe 'Guest User' do
    before do
      visit(home_path)
    end

    it_behaves_like 'Home page'

    it "has a 'Sign In' button" do
      expect(page).to have_selector "a[href='/users/sign_in']", text: 'Sign In'
      click_on('Sign In')
      expect(current_path).to eql(new_user_session_path)
    end

    it "has a 'Sign Up' button" do
      expect(page).to have_selector "a[href='/users/sign_up']", text: 'Sign Up'
      click_on('Sign Up')
      expect(current_path).to eql(new_user_registration_path)
    end

    it "show 'Hello, world!' tab title" do
      expect(page).to have_css('h1', text: 'Hello, world!')
    end

    it "show 'Don't forget to sign up'" do
      expect(page).to have_css('p', text: "Don't forget to sign up")
    end
  end

  describe 'User' do
    let(:user) { create(:user) }
    before do
      log_in(user)
    end
    it_behaves_like 'Home page'

    it "show 'hello,' with user name" do
      expect(page).to have_css('h1', text: "Hello, #{user.name}")
    end

    it "show 'Hello, world!' tab title" do
      expect(page).not_to have_css('p', text: "Don't forget to sign up")
    end

    it "has a 'Sign Out' button" do
      expect(page).to have_selector "a[href='#{destroy_user_session_path}']", text: 'Sign Out'
      click_on('Sign Out')
      expect(current_path).to eql(home_path)
      expect(page).to have_content 'Signed out successfully.'
    end
  end
end
