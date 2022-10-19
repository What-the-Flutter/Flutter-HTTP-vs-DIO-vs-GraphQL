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
    const createUserSuccess = "success";
    const error = "Error creating a new user. User migh already exist";
    if (!user) {
      await Users.create({ name, password });
      return {
        success: createUserSuccess
      };
    }
    return {
      error: error
    };
  },
  outputFields: {
    success: {
      type: GraphQLString,
      resolve: ({ success }) => success
    },
    error: {
      type: GraphQLString,
      resolve: ({ error }) => error
    }
  }
});
