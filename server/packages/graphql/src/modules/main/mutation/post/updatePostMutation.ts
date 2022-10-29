import Post from "../../../../model/post";
import { GraphQLString, GraphQLNonNull } from "graphql";
import { mutationWithClientMutationId } from "graphql-relay";

export default mutationWithClientMutationId({
  name: "updatePostMutation",
  inputFields: {
    id: {
      type: new GraphQLNonNull(GraphQLString)
    },
    title: {
      type: GraphQLString
    },
    text: {
      type: GraphQLString
    }
  },
  mutateAndGetPayload: async (
    { id, title, text },
  ) => {
    const date = Date.now();
    const { nModified: numModifiedFields } = await Post.updateOne(
      { _id: id },
      { title, text, date }
    );
    if (numModifiedFields > 0) {
      return {
        success: "success"
      };
    }
    return {
      error: "Error updating a post"
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
