class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    @page_title = 'Sign Up'
    super
  end

  # POST /resource
  def create
    super
    User.new.merge_game_record(session[:guest_slug]['value'], current_user) if session[:guest_slug] && current_user
  end

  # GET /resource/edit

  # PUT /resource

  # DELETE /resource

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation) }
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password) }
  end

  # The path used after sign up.

  # The path used after sign up for inactive accounts.

  def after_update_path_for(_resource)
    profile_path
  end
end
