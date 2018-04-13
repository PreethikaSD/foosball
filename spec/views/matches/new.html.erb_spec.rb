require 'rails_helper'

RSpec.describe "matches/new", type: :view do
  before(:each) do
    assign(:match, Match.new(
      :code => "MyString",
      :team1 => 1,
      :team2 => 1,
      :winner => 1
    ))
  end

  it "renders new match form" do
    render

    assert_select "form[action=?][method=?]", matches_path, "post" do

      assert_select "input[name=?]", "match[code]"

      assert_select "input[name=?]", "match[team1]"

      assert_select "input[name=?]", "match[team2]"

      assert_select "input[name=?]", "match[winner]"
    end
  end
end
