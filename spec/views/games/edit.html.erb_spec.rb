require 'rails_helper'

RSpec.describe "games/edit", type: :view do
  before(:each) do
    @game = assign(:game, Game.create!(
      user_id: 1,
      quote: "MyString",
      author: "MyString",
      fake_author: "MyString",
      api_id: 1
    ))
  end

  it "renders the edit game form" do
    render

    assert_select "form[action=?][method=?]", game_path(@game), "post" do

      assert_select "input[name=?]", "game[user_id]"

      assert_select "input[name=?]", "game[quote]"

      assert_select "input[name=?]", "game[author]"

      assert_select "input[name=?]", "game[fake_author]"

      assert_select "input[name=?]", "game[api_id]"
    end
  end
end
