# frozen_string_literal: true

class GameLoginTokenController < ApplicationController
  skip_before_action :preload_json, :check_xhr
  before_action :ensure_logged_in, only: [:list, :destroy, :destroy_all]
  
  def valid
    params.require(:login_token)
    params.require(:user_id)
    
    # Check if find user with that user_id
    user = User.find_by_id(params[:user_id])
    if not user
      return render json: {error: "Invalid user_id: #{params[:user_id]}"}
    end
    # Check if that user have user_auth_tokens
    user.user_auth_tokens.each do |n|
      if n[:auth_token] == params[:login_token]
        return render_serialized(user, GameTokenLoginUserSerializer)
        # return render json: {success: true}
      end
    end
    return render json: {error: "Invalid login_token: #{params[:login_token]}"}
  end
end
