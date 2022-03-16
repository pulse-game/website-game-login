# frozen_string_literal: true

class GameLoginKeyController < ApplicationController
  skip_before_action :preload_json, :check_xhr
  before_action :ensure_logged_in, only: [:list, :destroy, :destroy_all]
  
  def valid
    params.require(:login_key)
    params.require(:user_id)
    
    if !GameLoginKeys.valid_login_key?(params[:user_id], params[:login_key])
      return render json: {error: "Invalid login key!"}
    end
    
    return render json: {success: true, message: "Valid login key!"}
  end
  
  def list  # List all active login keys for user
    return render json: GameLoginKeys.get_login_keys(current_user.id)
  end
  
  def destroy  # Remove 1 specific login_key
    params.require(:login_key)
    return render json: {success: GameLoginKeys.remove_login_key(current_user.id, )}
  end
  
  def destroy_all  # Removes all login keys from user
    return render json: {success: GameLoginKeys.remove_all_login_keys(current_user.id)}
  end
end
