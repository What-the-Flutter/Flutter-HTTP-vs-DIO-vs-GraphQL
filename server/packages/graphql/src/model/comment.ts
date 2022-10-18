import mongoose from "mongoose";
const Schema = mongoose.Schema;

const comment = new Schema({
  userId: {
    type: String,
    required: "user id required"
  },
  postId: {
    type: String,
    required: "article id required"
  },
  authorName: {
    type: String,
    required: "author name is required"
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

export default mongoose.model("comments", comment);
