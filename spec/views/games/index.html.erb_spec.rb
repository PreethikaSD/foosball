require 'rails_helper'

RSpec.describe "games/index", type: :view do
  before(:each) do
    assign(:games, [
      Game.create!(
        :score => 2,
        :round_no => 3,
        :match => nil,
        :team => nil,
        :player => nil
      ),
      Game.create!(
        :score => 2,
        :round_no => 3,
        :match => nil,
        :team => nil,
        :player => nil
      )
    ])
  end

  it "renders a list of games" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
