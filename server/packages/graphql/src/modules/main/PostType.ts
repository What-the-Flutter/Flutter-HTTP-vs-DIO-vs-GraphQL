import {
    GraphQLObjectType,
    GraphQLString,
    GraphQLID,
} from 'graphql'

export default new GraphQLObjectType({
    name: 'Posts',
    fields: () => ({
        id: {
            type: GraphQLID
        },
        userId: {
            type: GraphQLString
        },
        authorName: {
            type: GraphQLString
        },
        title: {
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

