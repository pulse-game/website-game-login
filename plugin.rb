# frozen_string_literal: true

# name: game-login
# about: Plugin to authenticate a user by providing username+password to a API endpoint. (to login to the game)
# version: 1.0.0
# authors: Pulse team
# url: https://github.com/pulse-game/website-game-login
# required_version: 2.7.0
# transpile_js: true

enabled_site_setting :game_login_enabled

after_initialize do
  load File.expand_path('../app/controllers/game_login_controller.rb', __FILE__)
  load File.expand_path('../app/controllers/game_user_has_second_auth_controller.rb', __FILE__)
  load File.expand_path('../app/serializers/second_factor_serializer.rb', __FILE__)

  Discourse::Application.routes.append do
    # Map the path `/notebook` to `GameLoginController`’s `create` method
    get '/game_login' => 'game_login#create'
    get '/game_has_2fa' => 'game_user_has_second_auth#index'
  end
end
