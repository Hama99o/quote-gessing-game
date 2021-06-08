require 'rails_helper'

RSpec.describe "games/new", type: :view do
  before(:each) do
    assign(:game, Game.new(
      user_id: 1,
      quote: "MyString",
      author: "MyString",
      fake_author: "MyString",
      api_id: 1
    ))
  end

  it "renders new game form" do
    render

    assert_select "form[action=?][method=?]", games_path, "post" do

      assert_select "input[name=?]", "game[user_id]"

      assert_select "input[name=?]", "game[quote]"

      assert_select "input[name=?]", "game[author]"

      assert_select "input[name=?]", "game[fake_author]"

      assert_select "input[name=?]", "game[api_id]"
    end
  end
end
