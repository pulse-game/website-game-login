# frozen_string_literal: true

class GameValidLoginKeyController < ApplicationController
  skip_before_action :preload_json, :check_xhr

  def index
    params.require(:login_key)
    
    if !GameLoginKeys.valid_login_key?(params[:login_key])
      return render json: {error: "Invalid login key!"}
    end
    
    return render json: {success: true, message: "Valid login key!"}
    
  end
end
