module Admin
  class UsersController < BaseController
    before_action :set_user, only: [:edit, :update, :destroy]

    def index
      @users = User.order(created_at: :desc)
      if params[:role].present? && %w[organizer coach admin].include?(params[:role])
        @users = @users.where("#{params[:role]}": true)
      end
      @users = @users.where("first_name ILIKE :q OR last_name ILIKE :q OR email ILIKE :q", q: "%#{params[:q]}%") if params[:q].present?
    end

    def new
      @user = User.new
    end

    def create
      @user = User.new(user_params_create)
      if @user.save
        redirect_to admin_users_path, notice: "Utilisateur créé avec succès."
      else
        render :new, status: :unprocessable_entity
      end
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
        redirect_to admin_users_path, notice: "Utilisateur mis à jour."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      authorize @user
      @user.destroy
      redirect_to admin_users_path, notice: "Utilisateur supprimé."
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

    def user_params_create
      params.require(:user).permit(
        :first_name, :last_name, :email, :level,
        :organizer, :coach, :admin,
        :date_of_birth, :phone, :bio, :avatar,
        :password, :password_confirmation
      )
    end
  end
end
