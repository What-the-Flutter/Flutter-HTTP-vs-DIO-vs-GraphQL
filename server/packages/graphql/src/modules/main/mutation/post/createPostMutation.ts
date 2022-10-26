import Post from "../../../../model/post";
import { GraphQLString, GraphQLNonNull, GraphQLList, GraphQLSchema, GraphQLInt } from "graphql";
import { mutationWithClientMutationId } from "graphql-relay";
import PostType from "../../PostType";

export default mutationWithClientMutationId({
  name: "createPostMutation",
  inputFields: {
    userId: {
      type: new GraphQLNonNull(GraphQLString)
    },
    authorName: {
      type: new GraphQLNonNull(GraphQLString)
    },
    title: {
      type: new GraphQLNonNull(GraphQLString)
    },
    text: {
      type: new GraphQLNonNull(GraphQLString)
    },
    date: {
      type: new GraphQLNonNull(GraphQLString)
    },
  },
  mutateAndGetPayload: async (
    { userId, authorName, title, text, date}
  ) => {
    const post = await Post.create({
      userId,
      authorName,
      title,
      text,
      date,
    });

    if (post) {
      return {
        success: "success",
      };
    }
    return {
      error: "Error creating a post"
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
