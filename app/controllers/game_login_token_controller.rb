# frozen_string_literal: true

class GameLoginTokenController < ApplicationController
  skip_before_action :preload_json, :check_xhr
  before_action :ensure_logged_in, only: [:list, :destroy, :destroy_all]
  
  def valid
    params.require(:login_token)
    params.require(:user_id)
    
    if !GameLoginTokens.valid_login_token?(params[:user_id], params[:login_token])
      return render json: {error: "Invalid login token!"}
    end
    
    return render json: {success: true}
  end
  
  def list  # List all active login tokens for user
    return render json: GameLoginTokens.get_login_tokens(current_user.id)
  end
  
  def destroy  # Remove 1 specific login_token
    params.require(:login_token)
    return render json: {success: GameLoginTokens.remove_login_token(current_user.id, params[:login_token])}
  end
  
  def destroy_all  # Removes all login tokens from user
    return render json: {success: GameLoginTokens.remove_all_login_tokens(current_user.id)}
  end
end
