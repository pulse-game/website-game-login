# frozen_string_literal: true

class GameUserHasSecondAuthController < ApplicationController
  skip_before_action :preload_json, :check_xhr

  def index
    params.require(:login)
    params.require(:api_password)

    if !SiteSetting.game_login_enabled
      return render json: { error: "Server login disabled by admins on website." }
    end

    if params[:api_password] != SiteSetting.server_api_password  # Require password to call this API.
      return render json: { error: "Invalid server-api-password." }
    end

    user = User.find_by_username_or_email(normalized_login_param)
    # rate_limit_second_factor!(user)  # Un-comment this if we call this from client.

    if user.present?
      # render json: {success: true, method: user.totps.method}
      render_serialized(user.totps, SecondFactorSerializer)
    else
      render json: { error: "Can not find user with that email/username" }
    end
  end

  def normalized_login_param
    login = params[:login].to_s
    if login.present?
      login = login[1..-1] if login[0] == "@"
      User.normalize_username(login.strip)[0..100]
    else
      nil
    end
  end
end
