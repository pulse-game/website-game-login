# **Game Login** Plugin

**This is a plugin to enable authentication for your seperate server, example a game login.**
The plugin adds the following API endpoints:


### GET ```/game_has_2fa?login=EMAIL_OR_USERNAME&password=PASSWORD```
First you call this endpoint (on game client) to check if the user has 2fa enabled. (replace CAPS items in url)


### GET ```/game_login```
Last you call this endpoint to authenticate the user.

#### **Required Variables:**
- ```api_password=t8VzozhdsnjB9RTG1Nqg``` (to disable un-authorized persons to call this api endpoint, possible to change in admin/code)
- ```login=EMAIL_OR_USERNAME```
- ```password=PASSWORD```

#### **Optional/if enabled Variables**
- ```second_factor_token=NUMBER_FROM_USERS_PHONE```
- ```second_factor_method=1```



For more information, please see: **https://forum.pulse-game.com/t/authenticate-user-in-game/21**
