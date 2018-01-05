class Api::V1::UrlsController < ApplicationController
  respond_to :json
  before_action :require_login!
  before_action :check_params, only: [:create]

  def create
    @url = Url.fetch_or_create_by(params[:original_url])

    if @url.errors.any?
      render json: {status: "error", code: 'validation_error', message: @url.errors.full_messages.first}
    end
  end

  private
  def check_params
    unless params[:original_url].present?
      render json: {status: "error", code: 'validation_error', message: "Please send the origianl url"}
    end
  end
end
