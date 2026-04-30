# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Camps", type: :request do
  describe "GET /:locale/camps" do
    it "returns success and renders the listing" do
      get "/en/camps"

      expect(response).to have_http_status(:ok)
      expect(response.body).to include(I18n.t("camps.index.title"))
    end
  end

  describe "GET /:locale/camps/city_suggestions" do
    it "returns JSON suggestions" do
      allow(Geocoder).to receive(:search).and_return([])

      get "/en/camps/city_suggestions", params: { q: "Par" }

      expect(response).to have_http_status(:ok)
      expect(response.media_type).to eq("application/json")
      expect(JSON.parse(response.body)).to eq([])
    end
  end
end
