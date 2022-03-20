# frozen_string_literal: true

class GameLoginUserSerializer < GameTokenLoginUserSerializer
  attributes 	:login_auth_token
  
  def login_auth_token
    last_token = {id:0}
    object.user_auth_tokens.each do |n|
      if n[:id] > last_token[:id]
        last_token = n
      end
    end
    last_token
  end
end
