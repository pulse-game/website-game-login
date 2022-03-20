# **Game Login** Plugin

**This is a plugin to enable authentication for your seperate server, example a game login.**
The plugin adds the following API endpoints:


### GET ```/game_has_2fa?login=EMAIL_OR_USERNAME&password=PASSWORD```
First you call this endpoint (on game client) to check if the user has 2fa enabled. (replace CAPS items in url)


### GET ```/game_login```
Last you call this endpoint to authenticate the user.

#### **Required Variables:**
- ```api_password=FOUND_ON_ADMIN_PLUGIN_SETTINGS_PAGE``` (to disable un-authorized persons to call this api endpoint, possible to change in admin/code)
- ```login=EMAIL_OR_USERNAME```
- ```password=PASSWORD```

#### **Optional/if enabled Variables**
- ```second_factor_token=NUMBER_FROM_USERS_PHONE```
- ```second_factor_method=1```

### GET ```/game_valid_login_token?login_token=GET_FROM_GAME_LOGIN=&user_id=USER_ID```
You can call this endpoint with a valid auth-token to verify that the user is logged in, so the player dont need to login every time they connect.

For more information, please see: **https://forum.pulse-game.com/t/authenticate-user-ingame/86**
