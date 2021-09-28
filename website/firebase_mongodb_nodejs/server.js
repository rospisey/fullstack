/**
 * index.js
 */
const express = require("express");
const cors = require("cors");
const Msg = require("./model/message");
const userRoute = require("./api/users");
const adminRoute = require("./api/admin");
const { authMiddleware } = require("./auth-middleware");

const app = express();

const mongoose = require("mongoose");
const uri =
  "mongodb+srv://psUser:khmer4ever@cluster0.kr9vq.mongodb.net/message?retryWrites=true&w=majority";

mongoose
  .connect(uri, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
  })
  .then(() => {
    console.log("connected");
  })
  .catch((e) => {
    console.log(e);
  });

const server = require("http").createServer(app);
const { Server } = require("socket.io");
const io = new Server(server, {
  cors: {
    origin: "*",
  },
});
app.use(cors());
app.use("/user", userRoute);
app.use("/admin", adminRoute);
app.get("/home", (req, res) => {
  res.sendFile(__dirname + "/view/home.html");
});

// const books = [
//   {
//     id: 1,
//     name: "Harry Potter",
//     image:
//       "https://pmpub-catalogue.s3-eu-west-1.amazonaws.com/covers/web/9781781100240.jpg",
//   },
//   {
//     id: 2,
//     name: "Clean Code",
//     image:
//       "https://images-na.ssl-images-amazon.com/images/I/41jEbK-jG+L._SX374_BO1,204,203,200_.jpg",
//   },
//   {
//     id: 3,
//     name: "Javascript: The good parts",
//     image: "https://images-na.ssl-images-amazon.com/images/I/81kqrwS1nNL.jpg",
//   },
// ];

app.use("/", authMiddleware);

// app.get("/books", (request, response) => {
//   return response.send({ books });
// });

server.listen(4000, () => console.log("The server is running at PORT 4000"));
