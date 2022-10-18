import Router from "koa-router";
import {
  loginUser,
  createUser,
} from "../controllers/users";
import {
  CreateOneComment,
  GetComments,
  DeleteOneComment,
  UpdateOneComment
} from "../controllers/comments";
import {
  CreateOneArticles,
  DeleteOneArticle,
  FindArticles,
  FindOneArticles,
  UpdateOneArticle,
  Permalink
} from "../controllers/articles";

const router = new Router();

// create user and login
router.post("/api/login", loginUser);
router.post("/api/createUser", createUser);
// articles
router.get("/api/articles", FindArticles);
router.get("/api/article/:id", FindOneArticles);
router.post("/api/article", CreateOneArticles);
router.delete("/api/article/:id", DeleteOneArticle);
router.put("/api/article/:id", UpdateOneArticle);
// comments
router.get("/api/comment/:articleId", GetComments);
router.post("/api/comment", CreateOneComment);
router.put("/api/comment", UpdateOneComment);
router.delete("/api/comment/:id", DeleteOneComment);

export default router.routes();
