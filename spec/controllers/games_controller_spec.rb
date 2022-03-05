require 'rails_helper'

RSpec.describe GamesController, type: :controller do

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

  describe 'GET play' do
    let(:user) { create(:user) }
    let(:game) { create(:game, person: user, chosen_author: 'hui') }

    before do
      game
      user
    end
    subject { get :play }
  end
end
