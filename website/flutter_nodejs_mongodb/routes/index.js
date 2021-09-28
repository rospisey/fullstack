const express = require("express");
const admin = require("firebase-admin");
const router = express.Router();

router.get("/", (req, res) => {
  res.render("index.html");
});

module.exports = router;
