FactoryBot.define do
  # sequence(:email) { |n| "email#{n}@guessinggame.com" }
  factory(:user) do
    name { "Hama9o" }
    email { "user@gmail.com" }
    password { "SecretPassword123" }
  end
end
