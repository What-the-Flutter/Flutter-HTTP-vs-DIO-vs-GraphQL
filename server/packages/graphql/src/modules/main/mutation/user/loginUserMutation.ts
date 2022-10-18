import Users from "./../../../../model/users";
import { GraphQLString, GraphQLNonNull, GraphQLUnionType, GraphQLObjectType } from "graphql";
import { mutationWithClientMutationId } from "graphql-relay";

export default mutationWithClientMutationId({
  name: "loginUserMutation",
  inputFields: {
    email: {
      type: new GraphQLNonNull(GraphQLString)
    },
    password: {
      type: new GraphQLNonNull(GraphQLString)
    }
  },
  mutateAndGetPayload: async ({ email, password }) => {
    const user = await Users.findOne({ email, password });

    const defaultErrorMessage = "Invalid login or password";
    if (!user) {
      return {
        error: defaultErrorMessage
      };
    }
    const { _id, name } = user;

    return {
      id: _id,
      name: name,
      email: email
    };
  },
  outputFields: {
    error: {
      type: GraphQLString,
      resolve: ({ error }) => error
    },
    id: {
      type: GraphQLString,
      resolve: ({ id }) => id
    },
    name: {
      type: GraphQLString,
      resolve: ({ name }) => name
    },
    email: {
      type: GraphQLString,
      resolve: ({ email }) => email
    }
  }
});
