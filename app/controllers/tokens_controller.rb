class TokensController < ApplicationController
  before_action :authenticate_user!

  def generate
    current_user.generate_auth_token

    respond_to do |f|
      f.js
    end
  end
end