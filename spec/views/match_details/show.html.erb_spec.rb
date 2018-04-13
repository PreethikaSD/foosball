require 'rails_helper'

RSpec.describe "match_details/show", type: :view do
  before(:each) do
    @match_detail = assign(:match_detail, MatchDetail.create!(
      :round_no => 2,
      :team1_score => 3,
      :team2_score => 4,
      :match => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(//)
  end
end
