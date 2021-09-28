const express = require("express");
const connectDB = require("./config/db");
const morgan = require("morgan");
const cors = require("cors");
const bodyparser = require("body-parser");
const csrf = require("csurf");
const admin = require("firebase-admin");
const cookieParser = require("cookie-parser");
const authMiddleware = require("./auth-middleware");
// const routes = require("./routes/index");

const app = express();
const csrfMiddleware = csrf({ cookie: true });

connectDB();
if (process.env.NODE_ENV === "development") {
  app.use(morgan("dev"));
}
app.engine("html", require("ejs").renderFile);
app.use(express.static("static"));

// var serviceAccount = require("./serviceAccountKey.json");

// admin.initializeApp({
//   credential: admin.credential.cert(serviceAccount),
// });

app.use(cors());
app.use(bodyparser.urlencoded({ extended: false }));
app.use(bodyparser.json());
app.use(cookieParser());
app.use(csrfMiddleware);
// app.use(routes);

app.all("*", (req, res, next) => {
  res.cookie("XSRF-TOKEN", req.csrfToken());
  next();
});
app.get("/profile", function (req, res) {
  const sessionCookie = req.cookies.session || "";

  admin
    .auth()
    .verifySessionCookie(sessionCookie, true /** checkRevoked */)
    .then(() => {
      res.render("profile.html");
    })
    .catch((error) => {
      res.redirect("/login");
    });
});

app.use("/", authMiddleware);
app.get("/", function (req, res) {
  res.render("index.html");
});

app.get("/login", function (req, res) {
  res.render("login.html");
});

app.get("/signup", function (req, res) {
  res.render("signup.html");
});

app.post("/sessionLogin", (req, res) => {
  const idToken = req.body.idToken.toString();
  console.log(`idToken : ${idToken}`);

  const expiresIn = 60 * 60 * 24 * 5 * 1000;

  admin
    .auth()
    .createSessionCookie(idToken, { expiresIn })
    .then(
      (sessionCookie) => {
        const options = { maxAge: expiresIn, httpOnly: true };
        res.cookie("session", sessionCookie, options);
        res.end(JSON.stringify({ status: "success" }));
      },
      (error) => {
        res.status(401).send("UNAUTHORIZED REQUEST!");
      }
    );
});

app.get("/sessionLogout", (req, res) => {
  res.clearCookie("session");
  res.redirect("/login");
});
const PORT = process.env.PORT || 3000;

app.listen(
  PORT,
  console.log(`Server running in ${process.env.NODE_ENV} mode on port ${PORT}`)
);
