import Comment from "./../../../../model/comment";
import { GraphQLString, GraphQLNonNull, GraphQLList } from "graphql";
import { mutationWithClientMutationId } from "graphql-relay";
import CommentType from "../../CommentType";

export default mutationWithClientMutationId({
  name: "deleteMyCommentMutation",
  inputFields: {
    id: {
      type: new GraphQLNonNull(GraphQLString)
    },
  },
  mutateAndGetPayload: async ({ id }) => {
    const { deletedCount } = await Comment.deleteOne({ _id: id });
    if (deletedCount === 0) {
      return {
        error: "Error occured"
      };
    }

    return {
      success: "success"
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
