require 'rails_helper'

RSpec.describe "matches/edit", type: :view do
  before(:each) do
    @match = assign(:match, Match.create!(
      :code => "MyString",
      :team1 => 1,
      :team2 => 1,
      :winner => 1
    ))
  end

  it "renders the edit match form" do
    render

    assert_select "form[action=?][method=?]", match_path(@match), "post" do

      assert_select "input[name=?]", "match[code]"

      assert_select "input[name=?]", "match[team1]"

      assert_select "input[name=?]", "match[team2]"

      assert_select "input[name=?]", "match[winner]"
    end
  end
end
