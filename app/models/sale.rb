class Sale < ApplicationRecord
  validates :title, presence: true
  validates :url, format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]), message: "must be a valid HTTP(S) URL" }, allow_blank: true
end
