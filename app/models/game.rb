class Game < ApplicationRecord
  include Hashid::Rails
  before_save :set_default_val

  # validates_uniqueness_of :api_id
  def set_default_val
    self.score = author == chosen_author
  end

  def self.generate_game
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
                  api_id: quote_id
                })
  end
end
