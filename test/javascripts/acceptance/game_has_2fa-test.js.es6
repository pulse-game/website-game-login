import { acceptance } from "helpers/qunit-helpers";
acceptance("Purple Tentacle", {});

test("Game Get 2FA Works", assert => {
	visit("/game_has_2fa?login=system&api_password=" + this.siteSettings.server_api_password);
	
	andThen(() => {
		var j = JSON.parse(document.body.innerText);
		assert.ok(j, "Parsed JSON ok!");
		assert.ok(!j.error, "Did not find any errors"); // Can not check this because we need a default account then.
	});
});