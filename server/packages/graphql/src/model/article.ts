import mongoose from "mongoose";
const Schema = mongoose.Schema;

const article = new Schema({
  userId: {
    type: String,
    required: "user id is required"
  },
  title: {
    type: String,
    required: "title is required"
  },
  text: {
    type: String,
    required: "text is required"
  },
  date: {
    type: Date,
    default: Date.now,
  },
});

export default mongoose.model("articles", article);
