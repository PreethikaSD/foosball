require 'rails_helper'

RSpec.describe "players/index", type: :view do
  before(:each) do
    assign(:players, [
      Player.create!(
        :team_id => 1
      ),
      Player.create!(
        :team_id => 2
      )
    ])

  it "renders a list of players" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end

