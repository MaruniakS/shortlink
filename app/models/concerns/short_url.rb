module ShortUrl
  extend ActiveSupport::Concern
  extend Shuffle

  included do
    after_save :set_short_url
    validate :custom_uniqueness, :no_ambiguous_chars
  end

  # Used set of symbols
  SYMBOLS_SET = [*'a'..'z', *'A'..'Z',*'0'..'9',]
  # Add chars you want to remove from link
  AMBIGUOUS_CHARACTERS = %w(0 1 O I l)

  # Final string of chars
  # BASE_SET = (SYMBOLS_SET - AMBIGUOUS_CHARACTERS).join('')
  # I'm using own shuffle method, which always returns the same string
  BASE_SET = pseudo_random((SYMBOLS_SET - AMBIGUOUS_CHARACTERS).join(''))


  # You can also use SHUFFLE method before join for more security. In this way, save generated string, because it will
  # be changed after server restart
  # BASE_SET = (SYMBOLS_SET - AMBIGUOUS_CHARACTERS).shuffle.join('')

  # Length of final string
  SET_SIZE = BASE_SET.length

  # Set this value for initial url length (default = 4)
  INITIAL_URL_LENGTH = 4

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

  def custom_uniqueness
    errors.add(:custom, :taken) if self.class.where('short = :custom', {custom: custom}).exists?
  end

  def no_ambiguous_chars
    if custom
      errors.add(:custom, 'can contain only numbers and digits') unless custom =~ /^[0-9a-zA-Z]*$/
    end
  end

  module ClassMethods
    def get_id(short)
      id = 0
      i = short.length
      while i > 0 do
        id += BASE_SET.index(short[-1 * (i - short.length), 1]) * (SET_SIZE ** (i - 1))
        i-=1
      end
      id -= INCREMENT_VALUE
    end
  end
end


