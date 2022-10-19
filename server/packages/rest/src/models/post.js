import mongoose from "mongoose";
const Schema = mongoose.Schema;

const post = new Schema({
  userId: {
    type: String,
    required: "user id is required",
  },
  authorName: {
    type: String,
    required: "author name is required",
  },
  title: {
    type: String,
    required: "title is required",
  },
  text: {
    type: String,
    required: "text is required",
  },
  date: {
    type: Date,
    default: Date.now,
  },
});

export default mongoose.model("posts", post);
