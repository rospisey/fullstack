/*
    auth-middleware.js
*/
const firebase = require("./firebase/firebaseAdmin");

function authMiddleware(request, response, next) {
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
    .verifyIdToken(token, true /** checkRevoked */)
    .then(() => next())
    .catch((e) => response.send({ message: e.message }).status(403));
}
async function verify(token) {
  try {
    let decodedToken = await firebase.auth().verifyIdToken(token, true);
    return decodedToken;
  } catch (e) {
    console.log(e);
    throw new Error(e);
  }
}
module.exports = { authMiddleware, verify };
