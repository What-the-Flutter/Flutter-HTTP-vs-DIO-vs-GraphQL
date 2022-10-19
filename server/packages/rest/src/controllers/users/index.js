import Users from "../../models/users";

/* USERS */

// login an user
export const loginUser = async (ctx) => {
  const { name, password } = ctx.request.body;

  try {
    let user = await Users.findOne({ name, password });
    if (user) {
      const { _id, name } = user;
      ctx.status = 200;
      ctx.body = { id: _id, name };
    } else {
      ctx.status = 401;
    }
  } catch (error) {
    ctx.status = 500;
    ctx.body = error;
  }
};

// create an user
export const createUser = async (ctx) => {
  const { name, password } = ctx.request.body;

  try {
    const user = await Users.findOne({ name, password });
    if (!user) {
      await Users.create({ name, password });
      return (ctx.status = 200);
    } else return (ctx.body = { error: "User already exist" });
  } catch (error) {
    ctx.body = { error };
    ctx.status = 500;
  }
};
