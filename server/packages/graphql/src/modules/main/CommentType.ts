import {
    GraphQLObjectType,
    GraphQLString,
    GraphQLID,
} from 'graphql'

const GraphQLDate = require('graphql-date')

export default new GraphQLObjectType({
    name: 'Comments',
    fields: () => ({
        id: {
            type: GraphQLID
        },
        userId: {
            type: GraphQLString,
        },
        postId: {
            type: GraphQLString
        },
        authorName: {
            type: GraphQLString
        },
        text: {
            type: GraphQLString
        },
        date: {
            type: GraphQLDate
        },
    })
})

