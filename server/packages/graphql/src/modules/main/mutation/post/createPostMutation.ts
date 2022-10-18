import Post from "../../../../model/post";
import { GraphQLString, GraphQLNonNull, GraphQLList, GraphQLSchema } from "graphql";
import { mutationWithClientMutationId } from "graphql-relay";
import PostType from "../../PostType";

export default mutationWithClientMutationId({
  name: "createPostMutation",
  inputFields: {
    userId: {
      type: new GraphQLNonNull(GraphQLString)
    },
    title: {
      type: new GraphQLNonNull(GraphQLString)
    },
    text: {
      type: new GraphQLNonNull(GraphQLString)
    },
  },
  mutateAndGetPayload: async (
    { userId, title, text }
  ) => {
    const date = Date.now();

    const post = await Post.create({
      userId,
      title,
      text,
      date,
    });

    const PostUpdate = await Post.find({});
    if (post) {
      return {
        success: "success",
        post: PostUpdate
      };
    }
    return {
      error: "Error in creating a post"
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
    post: {
      type: new GraphQLList(PostType),
      resolve: ({ post }) => post
    }
  }
});
