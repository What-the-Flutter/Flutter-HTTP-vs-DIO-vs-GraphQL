import Users from "./../../../../model/users";
import { GraphQLString, GraphQLNonNull } from "graphql";
import { mutationWithClientMutationId } from "graphql-relay";

export default mutationWithClientMutationId({
  name: "loginUserMutation",
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

    const defaultErrorMessage = "Invalid login or password";
    if (!user) {
      return {
        error: defaultErrorMessage
      };
    }
    const { _id } = user;

    return {
      success: "success",
      id: _id,
      name: name,
    };
  },
  outputFields: {
    error: {
      type: GraphQLString,
      resolve: ({ error }) => error
    },
    success: {
      type: GraphQLString,
      resolve: ({ success }) => success
    },
    id: {
      type: GraphQLString,
      resolve: ({ id }) => id
    },
    name: {
      type: GraphQLString,
      resolve: ({ name }) => name
    }
  }
});
