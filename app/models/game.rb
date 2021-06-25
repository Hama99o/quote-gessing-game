class Game < ApplicationRecord
  include Hashid::Rails
  before_save :set_has_guessed
  # belongs_to :person, polymorphic: true

  # validates_uniqueness_of :api_id
  def set_has_guessed
    self.has_guessed = author == chosen_author if chosen_author.present?
  end

  def self.generate_game(user_id, user_type)
    quote_api = QuoteApi.new
    random_quote = quote_api.random_quote
    author = random_quote['quoteAuthor']
    fake_authors = quote_api.random_authors
    quote = random_quote['quoteText']
    quote_id = random_quote['_id']

    Game.create({
      quote: quote,
      author: author,
      fake_authors: fake_authors,
      api_id: quote_id,
      person_id: user_id,
      person_type: user_type
    })
  end

  def get_all_authors
    fake_authors = self.fake_authors
    @all_authors = fake_authors.push(self.author).shuffle
  end
end
