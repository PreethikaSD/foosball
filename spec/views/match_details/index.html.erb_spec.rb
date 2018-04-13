require 'rails_helper'

RSpec.describe "match_details/index", type: :view do
  before(:each) do
    assign(:match_details, [
      MatchDetail.create!(
        :round_no => 2,
        :team1_score => 3,
        :team2_score => 4,
        :match => nil
      ),
      MatchDetail.create!(
        :round_no => 2,
        :team1_score => 3,
        :team2_score => 4,
        :match => nil
      )
    ])
  end

  it "renders a list of match_details" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
