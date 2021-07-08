require 'rails_helper'

describe 'Games', type: :feature do
  
  before do
    allow_any_instance_of(QuoteApi).to receive(:random_quote_with_fake_authors).and_return({
      :fake_authors=>["Edward Witten", "Henry Moore"],
      :quotes=>{
        "id"=>7119,
        "quote_text"=>"I stood up as best I could to their disgusting stupidity and brutality, but I did not, of course, manage to beat them at their own game. It was a fight to the bitter end, one in which I was not defending ideals or beliefs but simply my own self.",
        "quote_author"=>"George Grosz",
        "quote_genre"=>"best",
        "author_id"=>3626
    }})
  end

  RSpec.shared_examples 'Result show correct answser' do
    it 'has the right text' do
      expect(page).to have_title('Result')
      expect(page).to have_css('p', class: 'h2', text: 'Correct')
    end

    it "has button 'Try another'" do
      expect(page).to have_selector "a[href='/game']", text: 'Try another'
      click_on('Try another')
      expect(current_path).to eql(games_path)
    end
  end

  RSpec.shared_examples 'Result show wrong answser' do
    it 'has the right text' do
      expect(page).to have_title('Result')
      expect(page).to have_css('p', class: 'h2', text: 'No!')
      expect(page).to have_css('p', text: "The real answer was #{game.author}")
    end

    it "has button 'Try another'" do
      expect(page).to have_selector "a[href='/game']", text: 'Try again'
      click_on('Try again')
      expect(current_path).to eql(games_path)
    end
  end

  describe 'with User' do
    let(:user) { create(:user) }
    let(:get_author) { create(:game, person: user) }

    it_behaves_like 'Result show wrong answser' do
      let(:game) { create(:game, person: user, chosen_author: 'Jonny') }
      before { visit game_path(game) }
    end
    it_behaves_like 'Result show correct answser' do
      let(:game) { create(:game, person: user, chosen_author: get_author.author) }
      before { visit game_path(game) }
    end
  end

  describe 'with Guest User' do
    let(:guest_user) { create(:guest_user) }
    let(:get_author) { create(:game, person: guest_user) }

    it_behaves_like 'Result show wrong answser' do
      let(:game) { create(:game, person: guest_user, chosen_author: 'Jonny') }
      before do
        visit(game_path(game))
      end
    end
    it_behaves_like 'Result show correct answser' do
      let(:game) { create(:game, person: guest_user, chosen_author: get_author.author) }
      before do
        visit(game_path(game))
      end
    end
  end
end
