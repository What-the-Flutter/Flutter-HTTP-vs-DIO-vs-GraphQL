import Comment from "./../../../../model/comment";
import Post from "./../../../../model/post";
import { GraphQLString, GraphQLNonNull } from "graphql";
import { mutationWithClientMutationId } from "graphql-relay";

export default mutationWithClientMutationId({
  name: "deleteMyCommentMutation",
  inputFields: {
    id: {
      type: new GraphQLNonNull(GraphQLString)
    },
  },
  mutateAndGetPayload: async ({ id }) => {
    let { postId } = await Comment.findOne({ _id: id });
    let { commentCount } = await Post.findOne({ _id: postId });
    await Post.updateOne({ _id: postId }, { commentCount: --commentCount });
    const { deletedCount } = await Comment.deleteOne({ _id: id });
    if (deletedCount === 0) {
      return {
        error: "Error deleting a comment"
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
