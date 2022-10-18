import Article from "./../../../../model/article";
import { GraphQLString, GraphQLNonNull, GraphQLList } from "graphql";
import { mutationWithClientMutationId } from "graphql-relay";
import ArticleType from "../../ArticleType";

export default mutationWithClientMutationId({
  name: "updateArticleMutation",
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
    const {nModified: numModifiedFields} = await Article.updateOne(
      { _id: id },
      { title, text, date }
    );
    console.log(numModifiedFields);
    const ArticleUpdate = await Article.find({});
    if (numModifiedFields > 0) {
      return {
        success: "success",
        article: ArticleUpdate
      };
    }
    return {
      error: "Error to update the article"
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
    article: {
      type: new GraphQLList(ArticleType),
      resolve: ({ article }) => article
    }
  }
});
