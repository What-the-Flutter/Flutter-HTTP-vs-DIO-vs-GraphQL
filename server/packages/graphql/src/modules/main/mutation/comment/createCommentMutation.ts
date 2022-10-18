import Comment from "./../../../../model/comment";
import { GraphQLString, GraphQLNonNull, GraphQLList } from "graphql";
import { mutationWithClientMutationId } from "graphql-relay";
import CommentType from "../../CommentType";

export default mutationWithClientMutationId({
  name: "createCommentMutation",
  inputFields: {
    idArticle: {
      type: new GraphQLNonNull(GraphQLString)
    },
    username: {
      type: new GraphQLNonNull(GraphQLString)
    },
    description: {
      type: new GraphQLNonNull(GraphQLString)
    },
    userId: {
      type: new GraphQLNonNull(GraphQLString)
    }
  },
  mutateAndGetPayload: async (
    { idArticle, username, description, userId },
    context,
    options
  ) => {
    // const idUser = context.user.id; <- o certo seria usar o id do user logado, mas estou colocando direto
    const comment = await Comment.create({
      idArticle,
      username,
      description,
      userId
    });

    const CommentUpdate = await Comment.find({ idArticle });
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
