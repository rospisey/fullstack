const { Router } = require("express");
const app = Router();
const { authMiddleware, verify } = require("../auth-middleware");
app.get("/:uid", (request, respond) => {
  if (
    !request.headers.authorization ||
    !request.headers.authorization.startsWith("Bearer ")
  ) {
    console.error(
      "No Firebase ID token was passed as a Bearer token in the Authorization header.",
      "Make sure you authorize your request by providing the following HTTP header:",
      "Authorization: Bearer <Firebase ID Token>"
    );
    res.status(403).json({ error: "Unauthorized" });
    return;
  }
  const token = request.headers.authorization.split("Bearer ")[1];
  verify(token)
    .then((decodedToken) => {
      if (request.params.uid === decodedToken.uid) {
        return firebase
          .auth()
          .getUser(decodedToken.uid)
          .then((user) => {
            return respond.send(` ${JSON.stringify(user.toJSON())}`);
          })
          .catch((error) =>
            respond.send({ message: error.message }).status(403)
          );
      } else {
        return respond.end(
          JSON.stringify({
            status: "Unsuccess",
          })
        );
      }
      // return respond.send(`${decodedToken.uid}`);
    })
    .catch((error) => respond.send({ message: error.message }).status(403));
});

app.post("/role/:uid", async (request, response) => {
  if (
    !request.headers.authorization ||
    !request.headers.authorization.startsWith("Bearer ")
  ) {
    console.error(
      "No Firebase ID token was passed as a Bearer token in the Authorization header.",
      "Make sure you authorize your request by providing the following HTTP header:",
      "Authorization: Bearer <Firebase ID Token>"
    );
    response.status(403).json({ error: "Unauthorized" });
    return;
  }
  const token = request.headers.authorization.split("Bearer ")[1];

  // Verify the ID token and decode its payload.
  const claims = await verify(token);

  // Verify user is eligible for additional privileges.
  if (
    typeof claims.email !== "undefined" &&
    typeof claims.email_verified !== "undefined" &&
    claims.email_verified &&
    // claims.email.endsWith("@admin.example.com") &&
    claims.email.startsWith("piseykonkhmer123") &&
    request.params.uid === claims.sub
  ) {
    // Add custom claims for additional privileges.
    await firebase.auth().setCustomUserClaims(claims.sub, {
      admin: true,
      accessLevel: 10,
    });

    // Tell client to refresh token on user.
    response.end(
      JSON.stringify({
        status: "success",
      })
    );
  } else {
    // Return nothing.
    response.end(JSON.stringify({ status: "ineligible" }));
  }
});

app.get("/revoke/:uid", (request, respond) => {
  // ពិនិត្យ header {authorization:}. ប្រសិនបើមិនមាន header{authorization: }
  // បង្ហាញសារ No token provided
  const headerToken = request.headers.authorization;
  if (!headerToken) {
    return response.status(401).send({ message: "No token provided" });
  }

  //ពិនិត្យ header {authorization: Bearer ...} ប្រសិនបើមិនមាន header{authorization: }
  // បង្ហាញសារ Invalid token
  if (headerToken && headerToken.split(" ")[0] !== "Bearer") {
    return response.status(401).send({ message: "Invalid token" });
  }

  //កាត់យកតែ​ token ចេញពី header {authorization: Bearer {token}}
  //រួចធ្វើការ verify
  const token = headerToken.split(" ")[1];
  firebase
    .auth()
    .verifyIdToken(token, true)
    .then((decodedToken) => {
      if (request.params.uid === decodedToken.uid) {
        // return respond.send(`success`);
        return firebase
          .auth()
          .revokeRefreshTokens(decodedToken.uid)
          .then(() => {
            return firebase.auth().getUser(decodedToken.uid);
          })
          .then((userRecord) => {
            return new Date(userRecord.tokensValidAfterTime).getTime() / 1000;
          })
          .then((timestamp) => {
            return respond.send(`Tokens revoked at: ${timestamp}`);
          })
          .catch((error) =>
            respond.send({ message: error.message }).status(403)
          );
      } else {
        return respond.send(`Unsuccess`);
      }
    })
    .catch((error) => respond.send({ message: error.message }).status(403));
});
module.exports = app;
