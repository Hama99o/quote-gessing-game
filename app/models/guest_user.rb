require 'person'

class GuestUser < ApplicationRecord
  include Person

  has_many :games, as: :person

  def self.generate_guest_user
    GuestUser.create({
      slug: (0...50).map { ('a'..'z').to_a[rand(26)] }.join,
      name: 'guest',
      email: 'guest@game.com'
    })
  end
end
