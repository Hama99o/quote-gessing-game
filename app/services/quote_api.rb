class QuoteApi
  RANDOM_QUOTE = 'https://quote-garden.herokuapp.com/api/v3/quotes/random'.freeze
  AUTHORS = 'https://quote-garden.herokuapp.com/api/v3/authors'.freeze

  def api_server
    @response = Faraday.get(RANDOM_QUOTE)
    @quote_data = JSON.parse(@response.body)['data'][0]
  end

  def ren_authors
    @response = Faraday.get(AUTHORS)
    @authors ||= JSON.parse(@response.body)['data']
    @authors.sample(2)
  end

  # def all_mix_authors
  #   get_author = api_server['quoteAuthor']
  #   ren_authors.push(get_author).shuffle
  # end

  # def quote
  #   api_server['quoteAuthor']
  # end
end
