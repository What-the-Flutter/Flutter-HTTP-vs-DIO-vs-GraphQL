import Koa from "koa";
import Router from "koa-router";
import Logger from "koa-logger";
import Cors from "kcors";
import BodyParser from "koa-bodyparser";
import routes from "./routes/blog";

const app = new Koa();
const router = Router();

app.use(BodyParser());
app.use(Logger());
app.use(Cors());

// API Route
app.use(routes).use(router.allowedMethods());

export default app;
