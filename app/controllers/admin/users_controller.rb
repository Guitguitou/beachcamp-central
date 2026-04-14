module Admin
  class UsersController < BaseController
    before_action :set_user, only: [:edit, :update]

    def index
      @users = User.order(created_at: :desc)
      if params[:role].present? && %w[organizer coach admin].include?(params[:role])
        @users = @users.where("#{params[:role]}": true)
      end
      @users = @users.where("first_name ILIKE :q OR last_name ILIKE :q OR email ILIKE :q", q: "%#{params[:q]}%") if params[:q].present?
    end

    def edit
      authorize @user
    end

    def update
      authorize @user
      if params[:user][:password].blank?
        params[:user].delete(:password)
        params[:user].delete(:password_confirmation)
      end
      if @user.update(user_params)
        redirect_to admin_users_path, notice: t("admin.users.update.success", default: "Utilisateur mis à jour.")
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(
        :first_name, :last_name, :email, :level,
        :organizer, :coach, :admin,
        :date_of_birth, :phone, :bio, :avatar,
        :password, :password_confirmation
      )
    end
  end
end
