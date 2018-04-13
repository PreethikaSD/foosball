require 'rails_helper'

RSpec.describe "matches/index", type: :view do
  before(:each) do
    assign(:matches, [
      Match.create!(
        :code => "Code",
        :team1 => 2,
        :team2 => 3,
        :winner => 4
      ),
      Match.create!(
        :code => "Code",
        :team1 => 2,
        :team2 => 3,
        :winner => 4
      )
    ])
  end

  it "renders a list of matches" do
    render
    assert_select "tr>td", :text => "Code".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
  end
end
