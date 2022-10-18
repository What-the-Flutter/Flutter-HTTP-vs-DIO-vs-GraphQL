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
    articleId: {
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
    { articleId, authorName, text, userId }
  ) => {
    const date = Date.now();

    const comment = await Comment.create({
      articleId,
      authorName,
      text,
      userId,
      date
    });

    const CommentUpdate = await Comment.find({ articleId });
    if (comment) {
      return {
        success: "success",
        comment: CommentUpdate
      };
    }
    return {
      error: "Error in create an comment"
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
    comment: {
      type: new GraphQLList(CommentType),
      resolve: ({ comment }) => comment
    }
  }
});
