# frozen_string_literal: true

# name: game-login
# about: Plugin to authenticate a user by providing username+password to a API endpoint. (to login to the game)
# version: 0.0.1
# authors: Pulse team
# url: https://github.com/pulse-game/website-plugin
# required_version: 2.7.0
# transpile_js: true

enabled_site_setting :game_login_enabled

after_initialize do
	load File.expand_path('../app/controllers/game_login_controller.rb', __FILE__)
	
	Discourse::Application.routes.append do
		# Map the path `/notebook` to `GameLoginController`’s `index` method
		get '/game_login' => 'game_login#create'
	end
end
