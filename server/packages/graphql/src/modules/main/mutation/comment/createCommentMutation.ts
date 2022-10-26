import Comment from "./../../../../model/comment";
import Post from "./../../../../model/post";
import { GraphQLString, GraphQLNonNull, GraphQLList } from "graphql";
import { mutationWithClientMutationId } from "graphql-relay";

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
    },
    date: {
      type: new GraphQLNonNull(GraphQLString)
    }
  },
  mutateAndGetPayload: async (
    { postId, authorName, text, userId, date }
  ) => {

    const comment = await Comment.create({
      postId,
      authorName,
      text,
      userId,
      date
    });
    let { commentCount } = await Post.findOne({ _id: postId });
    await Post.updateOne({ _id: postId }, { commentCount: ++commentCount });

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
