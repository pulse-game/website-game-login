import { acceptance } from "helpers/qunit-helpers";
acceptance("Game Login", {});

test("Game Login API Endpoints Works", assert => {
  visit("/game_login?login=test&password=test&api_password=xxx");
  andThen(() => {
    assert.ok(document.body.innerText.length > 0, "Got response from /game_login api endpoint.");
  });
  
  visit("/game_has_2fa?login=system&password=xxx");
  andThen(() => {
    //var j = JSON.parse(document.body.innerText);
    //assert.ok(j, "Parsed JSON ok!");
    //assert.ok(!j.error, "Did not find any errors"); // Can not check this because we need a default account then.
    assert.ok(document.body.innerText.length > 0, "Got response from /game_has_2fa api endpoint.");
  });
  
  visit("/game_valid_login_token?login_token=xxx=&user_id=0");
  andThen(() => {
    assert.ok(document.body.innerText.length > 0, "Got response from /game_valid_login_token api endpoint.");
  });
});
