import Router from "koa-router";
import { loginUser, createUser } from "../controllers/users";
import {
  CreateOneComment,
  GetComments,
  DeleteOneComment,
  UpdateOneComment,
} from "../controllers/comments";
import {
  CreateOnePost,
  DeleteOnePost,
  FindPosts,
  UpdateOnePost,
} from "../controllers/posts";

const router = new Router();

// create user and login
router.post("/api/login", loginUser);
router.post("/api/createUser", createUser);
// posts
router.get("/api/posts", FindPosts);
router.post("/api/post", CreateOnePost);
router.delete("/api/post/:id", DeleteOnePost);
router.put("/api/post/:id", UpdateOnePost);
// comments
router.get("/api/comment/:postId", GetComments);
router.post("/api/comment", CreateOneComment);
router.put("/api/comment/:id", UpdateOneComment);
router.delete("/api/comment/:id", DeleteOneComment);

export default router.routes();
