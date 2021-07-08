class ApplicationController < ActionController::Base
  # before_action :authenticate_user!
  before_action :set_guest_sessions
  before_action :check_user

  protected

  def set_guest_sessions
    return if session[:guest_slug]

    guest_user ||= GuestUser.generate_guest_user
    session[:guest_slug] = {
      value: guest_user.slug
    }
  end

  def check_user
    @person = if user_signed_in?
                current_user
              else
                GuestUser.find_by(slug: session[:guest_slug]['value'])
              end
  end
end
