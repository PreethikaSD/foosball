require "rails_helper"

RSpec.describe MatchDetailsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/match_details").to route_to("match_details#index")
    end

    it "routes to #new" do
      expect(:get => "/match_details/new").to route_to("match_details#new")
    end

    it "routes to #show" do
      expect(:get => "/match_details/1").to route_to("match_details#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/match_details/1/edit").to route_to("match_details#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/match_details").to route_to("match_details#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/match_details/1").to route_to("match_details#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/match_details/1").to route_to("match_details#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/match_details/1").to route_to("match_details#destroy", :id => "1")
    end

  end
end
