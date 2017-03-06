class Url < ApplicationRecord
  include ShortUrl

  validates :long, presence: true, uniqueness: true
  validates :custom, :short, uniqueness: true, allow_blank: true
  validates :long, format: { with: URI::regexp(%w(http https)), message: 'has to start with http or https'}

  HUMANIZED_ATTRIBUTES = {
      long: 'Long url',
      short: 'Shortened url',
      custom: 'Custom url'
  }

  def self.human_attribute_name(attr, options = {})
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end
end
