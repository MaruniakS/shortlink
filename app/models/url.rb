class Url < ApplicationRecord
  include ShortUrl

  validates_uniqueness_of :short
  validates :custom, uniqueness: true, length: { minimum: INITIAL_URL_LENGTH }, allow_nil: true
  validates :long, presence: true, uniqueness: true,
            format: { with: URI::regexp(%w(http https)), message: 'has to start with http or https'}

  HUMANIZED_ATTRIBUTES = {
      long: 'Long url',
      short: 'Shortened url',
      custom: 'Custom url'
  }

  def self.human_attribute_name(attr, options = {})
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end
end
