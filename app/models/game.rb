class Game < ApplicationRecord
  include Hashid::Rails
  before_save :set_has_guessed
  belongs_to :person, polymorphic: true

  paginates_per 4
  # validates_uniqueness_of :api_id
  def set_has_guessed
    self.has_guessed = author == chosen_author if chosen_author.present?
  end

  def self.generate_game(person)
    quote_api = QuoteApi.new
    random_quote = quote_api.random_quote_with_fake_authors
    author = random_quote[:quotes]['quote_author']
    fake_authors = random_quote[:fake_authors]
    quote = random_quote[:quotes]['quote_text']
    quote_id = random_quote[:quotes]['id']

    Game.create({
      quote: quote,
      author: author,
      fake_authors: fake_authors,
      api_id: quote_id,
      person: person
    })
  end

  def all_authors
    fake_authors = self.fake_authors
    @all_authors = fake_authors.push(author).shuffle
  end
end
