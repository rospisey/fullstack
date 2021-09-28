const { Router } = require("express");
const app = Router();
app.get("/users", async (request, respond, nextPageToken) => {
  try {
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
    const user = await firebase.auth().getUser(claims.sub);
    // const currentCustomClaims = user.customClaims;
    if (
      typeof user.customClaims["admin"] !== undefined &&
      user.customClaims["admin"]
    ) {
      await listAllUsers();
    } else {
      respond.send("Error");
    }
  } catch (error) {
    console.log("ErrorType:", error.message);
  }
});

// const listAllUsers = async (nextPageToken) => {
//   const res = await firebase.auth().listUsers(1000, nextPageToken);
//   allUsers.push(...res.users);
//   if (res.pageToken) {
//     await listAllUsers(res.pageToken);
//   }
// };

const listAllUsers = (nextPageToken) => {
  // List batch of users, 1000 at a time.
  firebase
    .auth()
    .listUsers(1000, nextPageToken)
    .then((listUsersResult) => {
      listUsersResult.users.forEach((userRecord) => {
        console.log("user", userRecord.toJSON());
        return userRecord.toJSON();
      });
      if (listUsersResult.pageToken) {
        // List next batch of users.
        listAllUsers(listUsersResult.pageToken);
      }
    })
    .catch((error) => {
      console.log("Error listing users:", error);
    });
};
module.exports = app;
