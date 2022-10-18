import Users from "../../models/users";

/* USERS */

// login an user
export const loginUser = async ctx => {
    const { email, password } = ctx.request.body;
    let user = await Users.findOne({ email, password });
    if (user) {
      const { _id, name} = user;
      ctx.body = { id: _id, name, email };
    } else {
      ctx.status = 401;
    }
  };
  
  // create an user
  export const createUser = async ctx => {
    const { name, email, password } = ctx.request.body;
    const user = await Users.findOne({ email });
    if (!user) {
      await Users.create({ name, email, password });
      return (ctx.status = 200);
    } else {
      ctx.status = 501;
    }
  };