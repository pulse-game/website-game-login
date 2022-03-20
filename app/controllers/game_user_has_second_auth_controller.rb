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
      
      return render_json_dump({auth_units: serialize_data(user.totps, SecondFactorSerializer)}) # render_serialized(user.totps[0], SecondFactorSerializer)
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
  
  def serialize_data(obj, serializer, opts = nil)
    # If it's an array, apply the serializer as an each_serializer to the elements
    serializer_opts = { scope: guardian }.merge!(opts || {})
    if obj.respond_to?(:to_ary)
      serializer_opts[:each_serializer] = serializer
      ActiveModel::ArraySerializer.new(obj.to_ary, serializer_opts).as_json
    else
      serializer.new(obj, serializer_opts).as_json
    end
  end
  
  def render_json_dump(obj, opts = nil)
    opts ||= {}
    if opts[:rest_serializer]
      obj['__rest_serializer'] = "1"
      opts.each do |k, v|
        obj[k] = v if k.to_s.start_with?("refresh_")
      end

      obj['extras'] = opts[:extras] if opts[:extras]
      obj['meta'] = opts[:meta] if opts[:meta]
    end

    render json: MultiJson.dump(obj), status: opts[:status] || 200
  end
end
