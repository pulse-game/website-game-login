# frozen_string_literal: true

class GameLoginController < ApplicationController
  skip_before_action :preload_json, :check_xhr

  def create
    params.require(:login)
    params.require(:password)
    params.require(:api_password)
    
    if !SiteSetting.game_login_enabled
      return render json: { error: "Server login disabled by admins on website." }
    end

    if params[:api_password] != SiteSetting.server_api_password  # Require password to call this API.
      return render json: { error: "Invalid server-api-password" }
    end

    return invalid_credentials if params[:password].length > User.max_password_length

    user = User.find_by_username_or_email(normalized_login_param)
    # rate_limit_second_factor!(user)  # no rate limit on this because server calls it

    if user.present?

      # If their password is correct
      unless user.confirm_password?(params[:password])
        invalid_credentials
        return
      end

      # If the site requires user approval and the user is not approved yet
      if login_not_approved_for?(user)
        render json: login_not_approved
        return
      end

      # User signed on with username and password, so let's prevent the invite link
      # from being used to log in (if one exists).
      Invite.invalidate_for_email(user.email)
    else
      invalid_credentials
      return
    end

    if payload = login_error_check(user)
      return render json: payload
    end

    if !authenticate_second_factor(user)
      return render(json: @second_factor_failure_payload)
    end

    render_serialized(user, GameLoginUserSerializer) # UserSerializer
  end

  def login_not_approved_for?(user)
    SiteSetting.must_approve_users? && !user.approved? && !user.admin?
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

  def login_not_approved
    { error: I18n.t("login.not_approved") }
  end

  def login_error_check(user)
    return failed_to_login(user) if user.suspended?

    if ScreenedIpAddress.should_block?(request.remote_ip)
      return not_allowed_from_ip_address(user)
    end

    if ScreenedIpAddress.block_admin_login?(user, request.remote_ip)
      admin_not_allowed_from_ip_address(user)
    end
  end

  def failed_to_login(user)
    {
    error: user.suspended_message,
    reason: 'suspended'
    }
  end
  def not_allowed_from_ip_address(user)
    { error: I18n.t("login.not_allowed_from_ip_address", username: user.username) }
  end

  def admin_not_allowed_from_ip_address(user)
    { error: I18n.t("login.admin_not_allowed_from_ip_address", username: user.username) }
  end

  def authenticate_second_factor(user)
    second_factor_authentication_result = user.authenticate_second_factor(params, secure_session)
    if !second_factor_authentication_result.ok
      failure_payload = second_factor_authentication_result.to_h
      if user.security_keys_enabled?
        Webauthn.stage_challenge(user, secure_session)
        failure_payload.merge!(Webauthn.allowed_credentials(user, secure_session))
      end
      @second_factor_failure_payload = failed_json.merge(failure_payload)
      return false
    end
    true
  end
end
