import {
    GraphQLObjectType,
    GraphQLString,
    GraphQLID,
} from 'graphql'

export default new GraphQLObjectType({
    name: 'Comments',
    fields: () => ({
        id: {
            type: GraphQLID
        },
        userId: {
            type: GraphQLString,
        },
        articleId: {
            type: GraphQLString
        },
        authorName: {
            type: GraphQLString
        },
        text: {
            type: GraphQLString
        },
        date: {
            type: GraphQLString
        },
    })
})

