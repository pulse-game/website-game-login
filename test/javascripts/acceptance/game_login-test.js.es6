import { acceptance } from "helpers/qunit-helpers";
acceptance("Game Login", {});

test("Game Login Works", assert => {
  visit("/game_login?login=test&password=test&api_password=t8VzozhdsnjB9RTG1Nqg");

  andThen(() => {
    //var j = JSON.parse(document.body.innerText);
    //assert.ok(j, "Parsed JSON ok!");
    // assert.ok(j.error, "Did not find any errors"); // Can not check this because we need a default account then.
    assert.ok(document.body.innerText.length > 0, "Got response from game_login api endpoint.");
  });
});