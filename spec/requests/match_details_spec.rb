require 'rails_helper'

RSpec.describe "MatchDetails", type: :request do
  describe "GET /match_details" do
    it "works! (now write some real specs)" do
      get match_details_path
      expect(response).to have_http_status(200)
    end
  end
end
