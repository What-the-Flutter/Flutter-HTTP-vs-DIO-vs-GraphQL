import { GraphQLBoolean, GraphQLObjectType } from 'graphql';

export default new GraphQLObjectType({
    name: 'SubscriptionType',
    fields: () => ({
        shouldUpdate: {
            type: GraphQLBoolean,
            subscribe({ pubsub }) {
                return pubsub.asyncIterator('shouldUpdate');
            }
        }
    }),
});