module ShortUrl
  extend ActiveSupport::Concern

  # Used set of symbols
  SYMBOLS_SET = [*'a'..'z', *'A'..'Z',*'0'..'9',]
  # Add chars you want to remove from link
  AMBIGUOUS_CHARACTERS = %w(0 1 O I l)

  # Final string of chars
  BASE_SET = (SYMBOLS_SET - AMBIGUOUS_CHARACTERS).join('')

  # You can also use SHUFFLE method before join for more security. In this way, save generated string, because it will
  # be changed after server restart
  # BASE_SET = (SYMBOLS_SET - AMBIGUOUS_CHARACTERS).shuffle.join('')

  # Length of final string
  SET_SIZE = BASE_SET.length

  INCREMENT_VALUE = SET_SIZE * SET_SIZE

  def set_short_url(id)
    n = id + INCREMENT_VALUE
    shortened_url = ''
    while n > 0 do
      shortened_url = BASE_SET[n % SET_SIZE, 1] + shortened_url
      n = (n / SET_SIZE).floor
    end
    shortened_url
  end

  def get_id(url)
    id = 0
    i = url.length
    while i > 0 do
      id += BASE_SET.index(url[-1 * (i - url.length), 1]) * (SET_SIZE ** (i - 1))
      i-=1
    end
    id -= INCREMENT_VALUE
  end
end



