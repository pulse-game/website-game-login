import { acceptance } from "helpers/qunit-helpers";
acceptance("Game Login", {});

test("Game Login Works", assert => {
  visit("/game_login?login=test&password=test&api_password=t8VzozhdsnjB9RTG1Nqg");

  andThen(() => {
    assert.ok(document.body.innerText.length > 0, "Got response from /game_login api endpoint.");
  });
});