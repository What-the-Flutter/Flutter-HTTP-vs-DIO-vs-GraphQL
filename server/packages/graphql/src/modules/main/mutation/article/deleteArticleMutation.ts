import Article from "./../../../../model/article";
import { GraphQLString, GraphQLNonNull, GraphQLList, GraphQLInt } from "graphql";
import { mutationWithClientMutationId } from "graphql-relay";
import ArticleType from "../../ArticleType";
import comment from "../../../../model/comment";

export default mutationWithClientMutationId({
  name: "deleteArticleMutation",
  inputFields: {
    id: {
      type: new GraphQLNonNull(GraphQLString)
    }
  },
  mutateAndGetPayload: async ({ id }, context, options) => {
    const { deletedCount : deletedArticlesCount } = await Article.deleteOne({ _id: id });
    const {  deletedCount : deletedCommentsCount } = await comment.deleteMany({ idArticle : id });

    const ArticleUpdate = await Article.find({});
    if (deletedArticlesCount === 0) {
      return {
        error: "Error to delete post"
      };
    }
    return {
      success: "success",
      deletedComments : deletedCommentsCount
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
