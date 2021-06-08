require 'rails_helper'

RSpec.describe "games/show", type: :view do
  before(:each) do
    @game = assign(:game, Game.create!(
      user_id: 2,
      quote: "Quote",
      author: "Author",
      fake_author: "Fake Author",
      api_id: 3
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Quote/)
    expect(rendered).to match(/Author/)
    expect(rendered).to match(/Fake Author/)
    expect(rendered).to match(/3/)
  end
end
