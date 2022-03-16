# frozen_string_literal: true
require 'securerandom'

class GameLoginTokens
  class << self
    def add_login_token(user_id)  # Adds a random login token
      random_string = SecureRandom.hex
      login_tokens = get_login_tokens(user_id)
      login_tokens.append(random_string)
      set_login_tokens(user_id, login_tokens)
      random_string
    end
    
    def valid_login_token?(user_id, login_token)  # returns if a login token is valid
      get_login_tokens(user_id).include?(login_token)
    end
    
    def get_login_tokens(user_id)
      PluginStore.get("game_login", "#{user_id}_login_tokens") || []
    end
    
    def set_login_tokens(user_id, login_tokens)
      PluginStore.set("game_login", "#{user_id}_login_tokens", login_tokens)
    end
    
    def remove_all_login_tokens(user_id)
      set_login_tokens(user_id, [])
    end
    
    def remove_login_token(user_id, login_token)
      # Remove specific token from list if exists.
      
    end
  end
end
