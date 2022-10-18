import json from "koa-json";
import dotenv from "dotenv-safe";
const koa = require("koa");
const route = require("koa-router");
const logger = require("koa-logger");
const bodyparser = require("koa-bodyparser");
const cors = require("kcors");
const graphqlHTTP = require("koa-graphql");

import schema from "./schema";
import multer from "koa-multer";

// init router and koa
const app = new koa();
const router = new route();
//init doenv
dotenv.load();

// middlewares
app.use(logger());
app.use(cors());
app.use(json());
app.use(bodyparser());
app.use(router.routes());
app.use(router.allowedMethods());

const graphqlSettingsPerReq = async (ctx: { req: any; res: any; }) => {
  const { request } = ctx.req;

  return {
    graphiql: true,
    schema,
    rootValue: {
      request: ctx.req
    },
    context: {
      request,
    }
  };
};

const graphqlServer = graphqlHTTP(graphqlSettingsPerReq);

const storage = multer.memoryStorage();
const limits = {
  // Increasing max upload size to 30 mb, since busboy default is only 1 mb
  fieldSize: 30 * 1024 * 1024
};

router.all("/graphql", multer({ storage, limits }).any(), graphqlServer);

export default app;
