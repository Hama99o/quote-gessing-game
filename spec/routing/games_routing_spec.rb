require "rails_helper"

RSpec.describe GamesController, type: :routing do
  describe "routing" do
    it "routes to #home" do
      expect(get: "/").to route_to("games#home")
    end

    it "routes to #play" do
      expect(get: "/game").to route_to("games#play")
    end

    it "routes to #result" do
      expect(get: "game/1/result").to route_to("games#result", id: "1")
    end

    it "routes to #update" do
      expect(patch: "game/1/result").to route_to("games#update", id: "1")
    end


    it "routes to #profile" do
      expect(get: "/profile").to route_to("games#profile")
    end
  end
end
