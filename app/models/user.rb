require 'person'

class User < ApplicationRecord
  include Person
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  has_many :games, as: :person

  def self.merge_game_record(guest_slug, current_user)
    guest_user = GuestUser.find_by(slug: guest_slug )
    Game.where(person_type: guest_user.class.to_s, person_id: guest_user.id)
      .update_all(person_type: current_user.class.to_s, person_id: current_user.id)
  end

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
