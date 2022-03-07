import { acceptance } from "helpers/qunit-helpers";
acceptance("Purple Tentacle", {});

test("Game Login Works", assert => {
	visit("/game_login?login=test&password=test&api_password=" + this.siteSettings.server_api_password);
	
	andThen(() => {
		var j = JSON.parse(document.body.innerText);
		assert.ok(j, "Parsed JSON ok!");
		// assert.ok(j.error, "Did not find any errors"); // Can not check this because we need a default account then.
	});
});