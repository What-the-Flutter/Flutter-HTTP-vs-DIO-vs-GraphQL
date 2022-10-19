import Comment from "./../../../../model/comment";
import { GraphQLString, GraphQLNonNull, GraphQLList } from "graphql";
import { mutationWithClientMutationId } from "graphql-relay";
import CommentType from "../../CommentType";

export default mutationWithClientMutationId({
  name: "createCommentMutation",
  inputFields: {
    userId: {
      type: new GraphQLNonNull(GraphQLString)
    },
    postId: {
      type: new GraphQLNonNull(GraphQLString)
    },
    authorName: {
      type: new GraphQLNonNull(GraphQLString)
    },
    text: {
      type: new GraphQLNonNull(GraphQLString)
    }
  },
  mutateAndGetPayload: async (
    { postId, authorName, text, userId }
  ) => {
    const date = Date.now();

    const comment = await Comment.create({
      postId,
      authorName,
      text,
      userId,
      date
    });

    if (comment) {
      return {
        success: "success"
      };
    }
    return {
      error: "Error creating a comment"
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
