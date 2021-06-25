class ApplicationController < ActionController::Base
  # before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_guest_cookies
  before_action :check_user

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password) }
  end

  def set_guest_cookies
    if !cookies[:guest_slug]
      guest_user ||= GuestUser.generate_guest_user
      cookies[:guest_slug] = {
        value: guest_user.slug
      }
    end
  end

  def check_user
    if user_signed_in?
      @person = current_user
      @person_type = 'registered user'
    else
      @person = GuestUser.find_by(slug: cookies[:guest_slug] )
      @person_type = 'guest user'
    end
  end
end
