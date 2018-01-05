class UrlsController < ApplicationController
  before_action :authenticate_user!

  def new
    @url  = Url.new
  end

  def create
    @url = Url.fetch_or_create_by(url_params[:original_url])

    respond_to do |f|
      f.js
    end
  end

  def show
    @url = Url.find_by_short_url params[:short_url]
    redirect_to @url.sanitized_url
  end

  private
  def url_params
    params.require(:url).permit(:original_url)
  end
end
