class ApplicationController < ActionController::Base
  include Pundit::Authorization

  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?

  def default_url_options
    { locale: I18n.locale }
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :role, :level])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :level])
  end

  private

  def set_locale
    locale = params[:locale] || cookies[:beachcamp_locale] || I18n.default_locale
    I18n.locale = locale.to_sym if I18n.available_locales.include?(locale.to_sym)
    cookies[:beachcamp_locale] = { value: I18n.locale.to_s, expires: 1.year.from_now }
  end
end
