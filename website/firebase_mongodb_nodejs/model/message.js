const mongoose = require("mongoose");

const mongooseSchema = new mongoose.Schema({
  msg: {
    type: String,
    required: true,
  },
});

const Msg = mongoose.model("msg", mongooseSchema);
module.exports = Msg;
