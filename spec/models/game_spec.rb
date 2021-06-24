require 'rails_helper'

RSpec.describe Game, type: :model do
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

  RSpec.shared_examples 'Model create game' do
    it 'with generate_game' do
      expect(subject.class.generate_game(user)).to eq(Game.last)
    end
  end

  RSpec.shared_examples 'Model has true answer' do
    it { should belong_to(:person) }

    it 'has true answer' do
      expect(subject.set_has_guessed).to eq(true)
    end

    it 'has all_authors method' do
      expect(subject.all_authors.length).to eq(3)
    end
  end


  RSpec.shared_examples 'Model has false answer' do
    it { should belong_to(:person) }

    it 'with set_has_guessed' do
      expect(subject.set_has_guessed).to eq(false)
    end
  end

  describe 'with User' do
    let(:user) { create(:user) }

    it_behaves_like 'Model create game' do
      let(:get_author) { create(:game, person: user) }
      let(:game) { create(:game, person: user) }
      subject { game }
      before { user }
    end

    it_behaves_like 'Model has true answer' do
      let(:get_author) { create(:game, person: user) }
      let(:game) { create(:game, person: user, chosen_author: get_author.author) }
      subject { game }
      before { user }
    end

    it_behaves_like 'Model has false answer' do
      let(:get_author) { create(:game, person: user) }
      let(:game) { create(:game, person: user, chosen_author: 'hi') }
      subject { game }
    end
  end

  describe 'with Guest User' do
    let(:user) { create(:guest_user) }

    it_behaves_like 'Model create game' do
      let(:get_author) { create(:game, person: user) }
      let(:game) { create(:game, person: user) }
      subject { game }
      before { user }
    end

    it_behaves_like 'Model has true answer' do
      let(:get_author) { create(:game, person: user) }
      let(:game) { create(:game, person: user, chosen_author: get_author.author) }
      subject { game }
      before { user }
    end

    it_behaves_like 'Model has false answer' do
      let(:get_author) { create(:game, person: user) }
      let(:game) { create(:game, person: user, chosen_author: 'hi') }
      subject { game }
    end
  end
end
