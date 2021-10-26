const serviceAccount = require("../config/serviceAccountKey.json");
const admin = require("firebase-admin");
// const firebase = require("../../src-admin/config/firebase.initialize");
// export const authMiddleware = (request, response, next) => {
//   const headerToken = request.headers.authorization;
//   if (!headerToken) {
//     return response.status(401).send({ message: "No token provided" });
//   }
//   if (headerToken && headerToken.split(" ")[0] !== "Bearer") {
//     return response.status(401).send({ message: "Invalid token" });
//   }
//   const token = headerToken.split(" ")[1];

//   admin
//     .auth()
//     .verifyIdToken(token, true /** checkRevoked */)
//     .then(() => next())
//     .catch((e) => response.send({ message: e.message }).status(403));
// };
export const verifyIdToken = (token) => {
  if (!admin.apps.length) {
    admin.initializeApp({
      credential: admin.credential.cert(serviceAccount),
      //   databaseURL:
    });
    // firebase();
  }
  return admin
    .auth()
    .verifyIdToken(token)
    .catch((error) => {
      throw error;
    });
};
