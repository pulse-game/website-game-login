# frozen_string_literal: true

# name: game-login
# about: Plugin to authenticate a user by providing username+password to a API endpoint. (to login to the game)
# version: 1.0.0
# authors: Pulse team
# url: https://github.com/pulse-game/website-game-login
# required_version: 2.7.0
# transpile_js: true

enabled_site_setting :game_login_enabled

load File.expand_path('../app/game_login_keys.rb', __FILE__)

after_initialize do
  load File.expand_path('../app/controllers/game_login_controller.rb', __FILE__)
  load File.expand_path('../app/serializers/game_login_user_serializer.rb', __FILE__)
  load File.expand_path('../app/controllers/game_user_has_second_auth_controller.rb', __FILE__)
  load File.expand_path('../app/serializers/second_factor_serializer.rb', __FILE__)
  load File.expand_path('../app/controllers/game_login_key_controller.rb', __FILE__)

  Discourse::Application.routes.append do
    # Map the path `/notebook` to `GameLoginController`’s `create` method
    get '/game_login' => 'game_login#create'
    get '/game_has_2fa' => 'game_user_has_second_auth#index'
    get '/game_valid_login_key' => 'game_login_key#valid'
    get '/game_login_keys' => 'game_login_key#list'
    get '/game_remove_all_login_keys' => 'game_login_key#remove_all'
  end
end
