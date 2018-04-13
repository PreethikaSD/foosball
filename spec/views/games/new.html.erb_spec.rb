require 'rails_helper'

RSpec.describe "games/new", type: :view do
  before(:each) do
    assign(:game, Game.new(
      :score => 1,
      :round_no => 1,
      :match => nil,
      :team => nil,
      :player => nil
    ))
  end

  it "renders new game form" do
    render

    assert_select "form[action=?][method=?]", games_path, "post" do

      assert_select "input[name=?]", "game[score]"

      assert_select "input[name=?]", "game[round_no]"

      assert_select "input[name=?]", "game[match_id]"

      assert_select "input[name=?]", "game[team_id]"

      assert_select "input[name=?]", "game[player_id]"
    end
  end
end
