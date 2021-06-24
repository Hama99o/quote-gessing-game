require 'rails_helper'

describe 'Profile', type: :feature do
  describe 'with login User ' do
    let(:game) { create(:game, person: user) }
    let(:user) { create(:user) }
    let(:correct_answers) { create_list(:game, 3, person: user, chosen_author: game.author) }
    let(:wrong_answers) { create_list(:game, 4, person: user, chosen_author: 'ali baba') }
    let(:resolved_games) { correct_answers + wrong_answers }

    before do
      log_in(user)
      correct_answers
      wrong_answers
      resolved_games
      visit(profile_path)
    end

    it 'has the right tab title' do
      expect(page).to have_css('h1', text: 'My Profile')
    end

    it "has a 'Back' button" do
      expect(page).to have_selector "a[href='#{games_path}']", text: 'Back'
      click_on('Back')
      expect(current_path).to eql(games_path)
    end

    it 'has user email and name present' do
      score_percent = ((correct_answers.count / resolved_games.count.to_f) * 100).round(2)

      expect(page).to have_selector 'span', text: user.name
      expect(page).to have_selector 'span', text: user.email
      expect(page).to have_selector 'span', text: correct_answers.count
      expect(page).to have_selector 'span', text: wrong_answers.count
      expect(page).to have_selector 'span', text: score_percent
    end

    it 'with pagination it displays 2 record in the 2nd page' do
      expect(page).to have_selector('tr.user_row', count: 4)
      within first 'ul.pagination' do
        click_link '2'
      end
      expect(page).to have_current_path('/profile?page=2')
      expect(page).to have_selector('tr.user_row', count: 3)
    end

    it 'has all game detail' do
      resolved_games.each do |game|
        expect(page).to have_selector 'td', text: game.quote
        expect(page).to have_selector 'td', text: game.chosen_author
        expect(page).to have_selector 'td', text: game.fake_authors.to_sentence
        expect(page).to have_selector 'td', text: game.author
      end
    end
  end

  describe 'with Guest User ' do
    let(:game) { create(:game, person: guest_user) }
    let(:guest_user) { GuestUser.last }
    let(:correct_answers) { create_list(:game, 2, person: guest_user, chosen_author: game.author) }
    let(:wrong_answers) { create_list(:game, 2, person: guest_user, chosen_author: 'ali baba') }
    let(:resolved_games) { correct_answers + wrong_answers }

    before do
      visit(home_path)
      resolved_games
      correct_answers
      wrong_answers
      visit(profile_path)
    end

    it 'has the right tab title' do
      expect(page).to have_title('Profile')
      expect(page).to have_css('h1', text: 'My Profile')
      expect(page).to have_css('p', text: 'When you sign up, your record will automatically send to your new account.')
    end

    it "has a 'Back' button" do
      expect(page).to have_selector "a[href='#{games_path}']", text: 'Back'
      click_on('Back')
      expect(current_path).to eql(games_path)
    end

    it "has a 'Register your account' button" do
      expect(page).to have_selector "a[href='#{new_user_registration_path}']", text: 'Register your account'
      click_on('Register your account')
      expect(current_path).to eql(new_user_registration_path)
    end

    it 'has correct answers, wrong answer and score_percent' do
      score_percent = ((correct_answers.count / resolved_games.count.to_f) * 100).round(2)
      expect(page).to have_selector 'span', text: correct_answers.count
      expect(page).to have_selector 'span', text: wrong_answers.count
      expect(page).to have_selector 'span', text: score_percent
    end

    it 'has not pagination and displays 4 record' do
      expect(page).to have_selector('tr.user_row', count: 4)
      expect(page).to have_no_selector('ul.pagination')
    end

    it 'has all game detail' do
      resolved_games.each do |game|
        expect(page).to have_selector 'td', text: game.quote
        expect(page).to have_selector 'td', text: game.chosen_author
        expect(page).to have_selector 'td', text: game.fake_authors.to_sentence
        expect(page).to have_selector 'td', text: game.author
      end
    end
  end
end
