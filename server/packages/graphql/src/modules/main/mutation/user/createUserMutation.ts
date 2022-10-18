import Users from "./../../../../model/users";
import { GraphQLString, GraphQLNonNull } from "graphql";
import { mutationWithClientMutationId } from "graphql-relay";

export default mutationWithClientMutationId({
  name: "createUserMutation",
  inputFields: {
    name: {
      type: new GraphQLNonNull(GraphQLString)
    },
    password: {
      type: new GraphQLNonNull(GraphQLString)
    }
  },

  mutateAndGetPayload: async ({ name, password }) => {
    const user = await Users.findOne({ name, password });
    // msg's
    const createUserSuccess = "User created successfully";
    const userExist = "User exist";
    if (!user) {
      await Users.create({ name, password });
      return {
        msg: createUserSuccess
      };
    }
    return {
      userExist: userExist
    };
  },
  outputFields: {
    msg: {
      type: GraphQLString,
      resolve: ({ msg }) => msg
    },
    userExist: {
      type: GraphQLString,
      resolve: ({ userExist }) => userExist
    }
  }
});
