class Url < ApplicationRecord
  include ShortUrl

  validates :long, presence: true, uniqueness: true
  validates :custom, :short, uniqueness: true, allow_blank: true
  validates :long, format: { with: URI::regexp(%w(http https)), message: 'Valid URL required'}
end
