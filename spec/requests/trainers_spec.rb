require "rails_helper"

RSpec.describe "Trainers", type: :request do
  describe "GET /:locale/trainers/:slug" do
    it "renders the public coach page" do
      coach = create(:user, :organizer, slug: "coach-#{SecureRandom.hex(4)}", coach_bio: "Hello")

      get "/en/trainers/#{coach.slug}"

      expect(response).to have_http_status(:success)
      expect(response.body).to include(coach.first_name)
    end
  end
end
