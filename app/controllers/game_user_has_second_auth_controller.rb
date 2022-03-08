# frozen_string_literal: true

class GameUserHasSecondAuthController < ApplicationController
  skip_before_action :preload_json, :check_xhr

  def index
    params.require(:login)
    params.require(:password)

    if !SiteSetting.game_login_enabled
      return render json: { error: "Server login disabled by admins on website." }
    end

    user = User.find_by_username_or_email(normalized_login_param)
    rate_limit_second_factor!(user)  # Un-comment this if we call this from client.

    if user.present?
      # If their password is correct
      unless user.confirm_password?(params[:password])
        invalid_credentials
        return
      end
      
      render_serialized(user.totps, SecondFactorSerializer)
    else
      invalid_credentials
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
  
  def invalid_credentials
    render json: { error: I18n.t("login.incorrect_username_email_or_password") }
  end
end
