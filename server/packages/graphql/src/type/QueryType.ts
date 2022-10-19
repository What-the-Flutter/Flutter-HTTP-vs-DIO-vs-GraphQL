import {
  GraphQLObjectType,
  GraphQLList,
  GraphQLNonNull,
  GraphQLID,
  GraphQLString,
  GraphQLInt
} from "graphql";
import CommentType from "./../modules/main/CommentType";
import commentModel from "../model/comment";
import postModel from "../model/post";
import PostType from "../modules/main/PostType";

export default new GraphQLObjectType({
  name: "QueryType",
  description: "Get entities[]",
  fields: () => ({
    posts: {
      type: new GraphQLList(PostType),
      args: {
        skip: {
          type: GraphQLInt
        },
        limit: {
          type: GraphQLInt
        }
      },
      resolve: (parentValue, args, ctx) => {
        const limit = args.limit;
        const skip = Math.max(0, args.skip);
        return postModel
          .find({})
          .limit(limit)
          .skip(skip);
      }
    },
    comments: {
      type: new GraphQLList(CommentType),
      args: {
        postId: {
          type: new GraphQLNonNull(GraphQLID)
        },
        skip: {
          type: GraphQLInt
        },
        limit: {
          type: GraphQLInt
        }
      },
      resolve: (parentValue, args, ctx) => {
        const limit = args.limit;
        const skip = Math.max(0, args.skip);
        const postId = args.postId;
        return commentModel
          .find({ postId })
          .limit(limit)
          .skip(skip);
      }
    }
  })
});
