class User < ApplicationRecord
  include Person
  EMAIL_REGEX       = /([^@\s]+@(?:[^@\s]+\.)+[^@\s]+)/.freeze
  ONLY_EMAIL_REGEX  = /\A#{EMAIL_REGEX}\z/.freeze

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  def merge_game_record(guest_slug, current_user)
    guest_user = GuestUser.find_by(slug: guest_slug)
    guest_user.games.update_all(person_type: current_user.class.to_s, person_id: current_user.id)
  end

  validates_presence_of :name,
                        :email

  validates_uniqueness_of :email

  validates_format_of :email,
                      with: ONLY_EMAIL_REGEX

  has_many :games, as: :person
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
