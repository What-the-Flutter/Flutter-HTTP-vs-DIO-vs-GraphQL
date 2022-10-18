import Post from "../../../../model/post";
import { GraphQLString, GraphQLNonNull, GraphQLList } from "graphql";
import { mutationWithClientMutationId } from "graphql-relay";
import PostType from "../../PostType";

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
    console.log(numModifiedFields);
    const PostUpdate = await Post.find({});
    if (numModifiedFields > 0) {
      return {
        success: "success",
        post: PostUpdate
      };
    }
    return {
      error: "Error to update a post"
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
