module ApplicationHelper
  def root_short_url(short_url)
    "#{root_url}" + @url.short_url
  end
end
