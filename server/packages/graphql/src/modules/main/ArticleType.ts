import {
    GraphQLObjectType,
    GraphQLString,
    GraphQLID,
} from 'graphql'

export default new GraphQLObjectType({
    name: 'Articles',
    fields: () => ({
        id: {
            type: GraphQLID
        },
        userId: {
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

