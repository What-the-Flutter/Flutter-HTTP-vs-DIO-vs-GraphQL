import Users from "../../models/users";

/* USERS */

// login an user
export const loginUser = async (ctx) => {
  const { name, password } = ctx.request.body;
  let user = await Users.findOne({ name, password });
  
  if (user) {
    const { _id, name } = user;
    ctx.body = { id: _id, name };
  } else {
    ctx.status = 401;
  }
};

// create an user
export const createUser = async (ctx) => {
  const { name, password } = ctx.request.body;
  const user = await Users.findOne({ name, password });

  if (!user) {
    try {
      await Users.create({ name, password });
      return (ctx.status = 200);
    } catch (error) {
      ctx.body = { error };
      return (ctx.status = 500);
    }
  } else {
    return (ctx.status = 409);
  }
};
