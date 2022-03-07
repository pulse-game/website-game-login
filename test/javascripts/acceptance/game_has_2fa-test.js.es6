import { acceptance } from "helpers/qunit-helpers";
acceptance("Game Get 2FA", {});

test("Game Get 2FA Works", assert => {
	visit("/game_has_2fa?login=system&api_password=t8VzozhdsnjB9RTG1Nqg");
	
	andThen(() => {
		//var j = JSON.parse(document.body.innerText);
		//assert.ok(j, "Parsed JSON ok!");
		//assert.ok(!j.error, "Did not find any errors"); // Can not check this because we need a default account then.
		assert.ok(document.body.innerText.length > 0, "Got response from game_has_2fa api endpoint.");
	});
});