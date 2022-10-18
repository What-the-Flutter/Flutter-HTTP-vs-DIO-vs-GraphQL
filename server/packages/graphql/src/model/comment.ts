import mongoose from "mongoose";
const Schema = mongoose.Schema;

const comment = new Schema({
  userId: {
    type: String,
    required: "user id required"
  },
  username: {
    type: String,
    required: "name is required"
  },
  description: {
    type: String,
    required: "description is required"
  },
  idArticle: {
    type: String,
    required: "idArticle required"
  },
});

export default mongoose.model("comments", comment);
