import Comment from "./../../../../model/comment";
import { GraphQLString, GraphQLNonNull, GraphQLList } from "graphql";
import { mutationWithClientMutationId } from "graphql-relay";
import CommentType from "../../CommentType";

export default mutationWithClientMutationId({
  name: "updateCommentMutation",
  inputFields: {
    id: {
      type: new GraphQLNonNull(GraphQLString)
    },
    text: {
      type: GraphQLString
    },
  },
  mutateAndGetPayload: async (
    { id, text }
  ) => {
    const comment = await Comment.updateOne(
      { _id: id },
      { text }
    );

    if (comment) {
      return {
        success: "success",
      };
    }
    return {
      error: "Error  updating a comment"
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
    },
  }
});
