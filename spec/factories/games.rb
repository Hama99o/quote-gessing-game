FactoryBot.define do
  factory :game do
    user_id { 1 }
    quote { "MyString" }
    author { "MyString" }
    fake_author { "MyString" }
    api_id { 1 }
  end
end
