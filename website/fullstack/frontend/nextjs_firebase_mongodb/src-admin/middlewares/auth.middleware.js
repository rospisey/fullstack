// import firebase from "../config/firebase.initialize";

import admin from "firebase-admin";
import nextConnect from "next-connect";
import nookie from "nookies";
const serviceAccount = require("../../src/config/serviceAccountKey.json");
const app = nextConnect();

export async function authMiddleware(req, res, next) {
  const headerToken = req.headers.authorization;
  if (!headerToken) {
    return res.status(401).send({ message: "No token provided" });
  }

  if (headerToken && headerToken.split(" ")[0] !== "Bearer") {
    return res.status(401).send({ message: "Invalid token" });
  }

  const token = headerToken.split(" ")[1];

  await admin
    .auth()
    .verifyIdToken(token, true /** checkRevoked */)
    .then(() => next())
    .catch((e) => res.send({ message: e.message }).status(403));
}

function parseCookies(request) {
  var list = {},
    rc = request.headers.cookie;

  rc &&
    rc.split(";").forEach(function (cookie) {
      var parts = cookie.split("=");
      list[parts.shift().trim()] = decodeURI(parts.join("="));
    });

  return list;
}
const verifyByHeaderCookies = () => async (req, res, next) => {
  if (!admin.apps.length) {
    admin.initializeApp({
      credential: admin.credential.cert(serviceAccount),
      //   databaseURL:
    });
    // firebase();
  }
  const headerCookie = req.headers.cookie;
  if (!headerCookie) {
    return res.status(401).send({ message: "No token provided" });
  }
  const token = parseCookies(req);
  //   console.log(token["token"]);

  await admin
    .auth()
    .verifyIdToken(token["token"], true /** checkRevoked */)
    .then(() => next())
    .catch((e) => next(e));
  //   next();
};

export default verifyByHeaderCookies;
