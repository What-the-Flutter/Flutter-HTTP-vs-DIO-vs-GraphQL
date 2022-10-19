import mongoose from "mongoose";
const Schema = mongoose.Schema;

const users = new Schema({
  name: {
    type: String,
    required: "name is required",
  },
  password: {
    type: String,
    required: "password is required",
  },
});

export default mongoose.model("users", users);
