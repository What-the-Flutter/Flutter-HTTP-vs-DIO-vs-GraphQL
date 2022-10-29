import Post from "../../../../model/post";
import { GraphQLString, GraphQLNonNull, GraphQLInt } from "graphql";
import { mutationWithClientMutationId } from "graphql-relay";
import Comment from "../../../../model/comment";

export default mutationWithClientMutationId({
  name: "deletePostMutation",
  inputFields: {
    id: {
      type: new GraphQLNonNull(GraphQLString)
    }
  },
  mutateAndGetPayload: async ({ id }) => {
    const { deletedCount: deletedPostsCount } = await Post.deleteOne({ _id: id });
    const { deletedCount: deletedCommentsCount } = await Comment.deleteMany({ postId: id });

    if (deletedPostsCount === 0) {
      return {
        error: "Error deleting a post"
      };
    }
    return {
      success: "success",
      deletedComments: deletedCommentsCount
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
    deletedComments: {
      type: GraphQLInt,
      resolve: ({ deletedComments }) => deletedComments
    }
  }
});
