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

  RSpec.shared_examples 'Play' do
    it "has the right text and it has title 'Play'" do
      expect(page).to have_css('p', class: 'h2', text: 'Who said that ...?')
      expect(page).to have_css('blockquote', class: 'h3', text: 'Choose the correct author')
      expect(page).to have_css('blockquote', class: 'h3', text: 'Reply Fast!!')
      expect(page).to have_title('Play')
    end

    it 'has the correct quote' do
      expect(page).to have_css('blockquote', class: 'h1', text: game.quote)
    end

    it 'has a all authors' do
      all_athor = game.fake_authors.push(game.author).shuffle
      all_athor.each do |author|
        expect(page).to have_css('label', class: 'responsive-text', text: author)
      end
    end

    it 'will click on right author and redirect to result page' do
      expect(page).to have_css('label', class: 'responsive-text', text: game.author)
      choose(game.author, allow_label_click: true)
      page.submit find('.submit-form')
      expect(current_path).to eql(game_path(game))
      expect(page).to have_css('p', class: 'h2', text: 'Correct')
    end

    it 'will click on wrong author and redirect to result page' do
      expect(page).to have_css('label', class: 'responsive-text', text: game.author)
      choose(game.fake_authors[1], allow_label_click: true)
      page.submit find('.submit-form')
      expect(current_path).to eql(game_path(game))
      expect(page).to have_css('p', class: 'h2', text: 'No!')
    end
  end

  describe 'with User' do
    let(:user) { create(:user) }

    it_behaves_like 'Play' do
      let(:game) { Game.last }

      before do
        log_in(user)
        visit(games_path)
        game
      end
    end
  end

  describe 'with Guest User' do
    it_behaves_like 'Play' do
      let(:game) { Game.last }

      before do
        visit(home_path)
        visit(games_path)
        game
      end
    end
  end
end
