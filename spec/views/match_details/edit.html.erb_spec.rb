require 'rails_helper'

RSpec.describe "match_details/edit", type: :view do
  before(:each) do
    @match_detail = assign(:match_detail, MatchDetail.create!(
      :round_no => 1,
      :team1_score => 1,
      :team2_score => 1,
      :match => nil
    ))
  end

  it "renders the edit match_detail form" do
    render

    assert_select "form[action=?][method=?]", match_detail_path(@match_detail), "post" do

      assert_select "input[name=?]", "match_detail[round_no]"

      assert_select "input[name=?]", "match_detail[team1_score]"

      assert_select "input[name=?]", "match_detail[team2_score]"

      assert_select "input[name=?]", "match_detail[match_id]"
    end
  end
end
