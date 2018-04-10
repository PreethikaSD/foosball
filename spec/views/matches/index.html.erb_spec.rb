require 'rails_helper'

RSpec.describe "matches/index", type: :view do
  before(:each) do
    assign(:matches, [
      Match.create!(
        :code => "Code",
        :winner => "Winner"
      ),
      Match.create!(
        :code => "Code",
        :winner => "Winner"
      )
    ])
  end

  it "renders a list of matches" do
    render
    assert_select "tr>td", :text => "Code".to_s, :count => 2
    assert_select "tr>td", :text => "Winner".to_s, :count => 2
  end
end
