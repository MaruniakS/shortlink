module ShortUrl
  extend ActiveSupport::Concern

  included do
    after_save :set_short_url
    validate :custom_uniqueness
  end

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

  # Set this value for initial url length (default = 3)
  INITIAL_URL_LENGTH = 3

  INCREMENT_VALUE = SET_SIZE ** (INITIAL_URL_LENGTH - 1)

  def set_short_url
    n = self.id + INCREMENT_VALUE
    shortened_url = ''
    while n > 0 do
      shortened_url = BASE_SET[n % SET_SIZE, 1] + shortened_url
      n = (n / SET_SIZE).floor
    end
    self.update_column(:short, shortened_url)
  end

  def get_id
    id = 0
    i = short.length
    while i > 0 do
      id += BASE_SET.index(short[-1 * (i - short.length), 1]) * (SET_SIZE ** (i - 1))
      i-=1
    end
    id -= INCREMENT_VALUE
  end

  def custom_uniqueness
    if self.class.where('short = :custom', {custom: custom}).exists?
      errors.add(:custom, :taken)
    end
  end
end
