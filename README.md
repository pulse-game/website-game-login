# **Game Login** Plugin

**This is a plugin to enable authentication for your seperate server, example a game login.**
The plugin adds the following API endpoints:

First you call this endpoint to check if the user has 2fa enabled.
****get /game_has_2fa****
**Required Variables:**
api_password=t8VzozhdsnjB9RTG1Nqg (to disable un-authorized persons to call this api endpoint, possible to change in admin/code)
login=system&

Last you call this endpoint to authenticate the user.
****get /game_login****
**Required Variables:**
api_password=t8VzozhdsnjB9RTG1Nqg (to disable un-authorized persons to call this api endpoint, possible to change in admin/code)
login=EMAIL_OR_USERNAME
password=PASSWORD
**Optional/if enabled Variables**
second_factor_token=NUMBER_IF_ADDED
second_factor_method=1 (if normal like authy/google)



For more information, please see: **forum.pulse-game.com**
