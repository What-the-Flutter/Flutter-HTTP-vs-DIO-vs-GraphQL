import Article from "./../../../../model/article";
import { GraphQLString, GraphQLNonNull, GraphQLList } from "graphql";
import { mutationWithClientMutationId } from "graphql-relay";
import ArticleType from "../../ArticleType";

export default mutationWithClientMutationId({
  name: "createArticleMutation",
  inputFields: {
    userId: {
      type: new GraphQLNonNull(GraphQLString)
    },
    title: {
      type: new GraphQLNonNull(GraphQLString)
    },
    subtitle: {
      type: new GraphQLNonNull(GraphQLString)
    },
    description: {
      type: new GraphQLNonNull(GraphQLString)
    },
    author: {
      type: new GraphQLNonNull(new GraphQLList(GraphQLString))
    },
  },
  mutateAndGetPayload: async (
    { userId, title, subtitle, description, author },
    context,
    options
  ) => {
    const date = Date.now();

    const article = await Article.create({
      userId,
      title,
      subtitle,
      description,
      author,
      date,
      date_update: null,
    });
    
    const ArticleUpdate = await Article.find({});
    if (article) {
      return {
        success: "success",
        article: ArticleUpdate
      };
    }
    return {
      error: "Error in create an article"
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
