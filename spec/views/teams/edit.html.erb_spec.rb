require 'rails_helper'

RSpec.describe "teams/edit", type: :view do
  before(:each) do
    @team = assign(:team, Team.create!(
      :match => :match
    ))
  end

  it "renders the edit team form" do
    team = build(:team, team_id: 2)

    render

    assert_select "form[action=?][method=?]", team_path(@team), "post" do

      assert_select "input[name=?]", "team[match_id]"
    end
  end
end
