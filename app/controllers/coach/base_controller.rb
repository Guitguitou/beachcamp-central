module Coach
  class BaseController < ApplicationController
    before_action :authenticate_user!
    before_action :require_coach!
    layout "coach"

    private

    def require_coach!
      redirect_to root_path, alert: t("coach.unauthorized", default: "Accès réservé aux coachs.") unless current_user.coach?
    end
  end
end
