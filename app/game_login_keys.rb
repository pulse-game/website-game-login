# frozen_string_literal: true
require 'securerandom'

class GameLoginKeys
  class << self
    def add_login_key()  # Adds a random login key
      random_string = SecureRandom.hex
      login_keys = get_login_keys()
      login_keys.append(random_string)
      PluginStore.set("game_login", "login_keys", login_keys)
      random_string
    end
    
    def valid_login_key?(login_key)  # returns if a login key is valid
      get_login_keys().include?(login_key)
    end
    
    def get_login_keys()
      PluginStore.get("game_login", "login_keys") || []
    end
  end
end