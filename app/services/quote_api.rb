class QuoteApi
  RANDOM_QUOTE = 'https://quote-garden.herokuapp.com/api/v3/quotes/random'.freeze
  AUTHORS = 'https://quote-garden.herokuapp.com/api/v3/authors'.freeze

  def random_quote
    @response = Faraday.get(RANDOM_QUOTE)
    @quote_data = JSON.parse(@response.body)['data'][0]
  end

  def random_authors
    @response = Faraday.get(AUTHORS)
    @authors ||= JSON.parse(@response.body)['data']
    @authors.sample(2)
  end
end
