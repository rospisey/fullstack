/*
    auth-middleware.js
*/
const firebase = require("./firebase/admin");

function authMiddleware(request, response, next) {
  const sessionCookie = request.cookies.session || "";
  firebase
    .auth()
    .verifySessionCookie(sessionCookie, true /** checkRevoked */)
    .then(() => next())
    .catch(() => response.send({ message: "Could not authorize" }).status(403));
}

module.exports = authMiddleware;
