class Url < ApplicationRecord
  validates :original_url,
            :short_url, :sanitized_url,
            presence: true

  validates :original_url, url: true

  # fetch or create Url by sanitizing the original url
  # if not found then it will create in Url table
  def self.fetch_or_create_by(original_url)
    _sanitize_url = sanitize_url(original_url)
    if Url.exists?(sanitized_url: _sanitize_url)
      Url.find_by_sanitized_url(_sanitize_url)
    else
      Url.create(original_url: original_url, sanitized_url: _sanitize_url, short_url: create_short_url)
    end
  end

  protected

  # creating short url in a simple way
  # we can use MD5 or other if we want it more hard
  def self.create_short_url
    chars = ['0'..'9', 'A'..'Z', 'a'..'z'].map { |range| range.to_a }.flatten
    6.times.map { chars.sample }.join
  end

  # creates a sanitized_url by removing all trailing slashes and white spaces as well as
  # replacing “www.”, “https://” and “http://” with “http://”.
  def self.sanitize_url(original_url)
    original_url.strip!
    _sanitized_url = original_url.downcase.gsub(/(https?:\/\/)|(www\.)/, "")
    _sanitized_url.slice!(-1) if _sanitized_url[-1] == "/"
    _sanitized_url = "http://#{_sanitized_url}"
  end
end
