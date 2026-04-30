module Admin
  class CampsController < BaseController
    before_action :set_camp, only: [:show, :edit, :update, :destroy, :publish, :cancel, :set_draft]

    def index
      @camps = Camp.includes(:organizer, :coach).order(created_at: :desc)
      @camps = @camps.where(status: params[:status]) if params[:status].present? && Camp.statuses.key?(params[:status])
      @camps = @camps.where("title ILIKE :q OR location ILIKE :q OR country ILIKE :q", q: "%#{params[:q]}%") if params[:q].present?
    end

    def show
      @registrations = @camp.registrations.includes(:user).order(created_at: :desc)
    end

    def new
      @camp = Camp.new(status: :draft, currency: "EUR", min_participants: 4, max_participants: 16)
    end

    def create
      @camp = Camp.new(camp_params)
      if @camp.save
        redirect_to admin_camp_path(@camp), notice: "Camp créé avec succès."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit; end

    def update
      if @camp.update(camp_params)
        redirect_to admin_camp_path(@camp), notice: "Camp mis à jour."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @camp.destroy
      redirect_to admin_camps_path, notice: "Camp supprimé."
    end

    def publish
      result = Camps::PublishCamp.new(camp: @camp).call
      if result.success?
        redirect_to admin_camp_path(@camp), notice: "Camp publié."
      else
        redirect_to admin_camp_path(@camp), alert: result.error
      end
    end

    def cancel
      result = Camps::CancelCamp.new(camp: @camp).call
      if result.success?
        redirect_to admin_camp_path(@camp), notice: "Camp annulé."
      else
        redirect_to admin_camp_path(@camp), alert: result.error
      end
    end

    def set_draft
      @camp.update!(status: :draft)
      redirect_to admin_camp_path(@camp), notice: "Camp repassé en brouillon."
    end

    private

    def set_camp
      @camp = Camp.find(params[:id])
    end

    def camp_params
      params.require(:camp).permit(
        :title, :description, :location, :country,
        :start_date, :end_date, :level,
        :price_cents, :currency,
        :min_participants, :max_participants,
        :featured, :poster, :coach_id, :organizer_id
      )
    end
  end
end
