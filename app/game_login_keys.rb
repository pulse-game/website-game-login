# frozen_string_literal: true
require 'securerandom'

class GameLoginKeys
  class << self
    def add_login_key(user_id)  # Adds a random login key
      random_string = SecureRandom.hex
      login_keys = get_login_keys(user_id)
      login_keys.append(random_string)
      set_login_keys(user_id, login_keys)
      random_string
    end
    
    def valid_login_key?(user_id, login_key)  # returns if a login key is valid
      get_login_keys(user_id).include?(login_key)
    end
    
    def get_login_keys(user_id)
      PluginStore.get("game_login", "#{user_id}_login_keys") || []
    end
    
    def set_login_keys(user_id, login_keys)
      PluginStore.set("game_login", "#{user_id}_login_keys", login_keys)
    end
    
    def remove_all_login_keys(user_id)
      set_login_keys(user_id, [])
    end
    
    def remove_login_key(user_id, login_key)
      # Remove specific key from list if exists.
      
    end
  end
end
