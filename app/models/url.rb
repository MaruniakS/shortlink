class Url < ApplicationRecord
  include ShortUrl

  validates :long, presence: true, uniqueness: true
  validates :custom, :short, uniqueness: true, allow_blank: true
end
