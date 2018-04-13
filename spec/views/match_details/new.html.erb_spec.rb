require 'rails_helper'

RSpec.describe "match_details/new", type: :view do
  before(:each) do
    assign(:match_detail, MatchDetail.new(
      :round_no => 1,
      :team1_score => 1,
      :team2_score => 1,
      :match => nil
    ))
  end

  it "renders new match_detail form" do
    render

    assert_select "form[action=?][method=?]", match_details_path, "post" do

      assert_select "input[name=?]", "match_detail[round_no]"

      assert_select "input[name=?]", "match_detail[team1_score]"

      assert_select "input[name=?]", "match_detail[team2_score]"

      assert_select "input[name=?]", "match_detail[match_id]"
    end
  end
end
