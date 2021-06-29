class GuestUser < Person
  def self.generate_guest_user
    GuestUser.create({
      slug: (0...50).map { ('a'..'z').to_a[rand(26)] }.join,
      name: 'guest',
      email: 'guest@game.com'
    })
  end
end
