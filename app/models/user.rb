class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  def self.merge_game_record(guest_slug, current_user)
    guest_user = GuestUser.find_by(slug: guest_slug )
    Game.where(person_type: guest_user.class.to_s, person_id: guest_user.id)
      .update_all(person_type: current_user.class.to_s, person_id: current_user.id)
  end

  has_many :games, as: :person
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
