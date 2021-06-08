require 'rails_helper'

RSpec.describe "games/index", type: :view do
  before(:each) do
    assign(:games, [
      Game.create!(
        user_id: 2,
        quote: "Quote",
        author: "Author",
        fake_author: "Fake Author",
        api_id: 3
      ),
      Game.create!(
        user_id: 2,
        quote: "Quote",
        author: "Author",
        fake_author: "Fake Author",
        api_id: 3
      )
    ])
  end

  it "renders a list of games" do
    render
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: "Quote".to_s, count: 2
    assert_select "tr>td", text: "Author".to_s, count: 2
    assert_select "tr>td", text: "Fake Author".to_s, count: 2
    assert_select "tr>td", text: 3.to_s, count: 2
  end
end
