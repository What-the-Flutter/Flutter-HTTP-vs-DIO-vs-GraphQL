class GraphQLQueryStrings {
  static const String getPosts = r'''
    query {
      posts {
        id
        userId
        title
        text
        date
        authorName
        commentCount
      }
    }
  ''';

  static const String getPost = r'''
    query GetPost($id: ID!) {
      post(id: $id) {
        id
        userId
        title
        text
        date
        authorName
        commentCount
      }
    }
  ''';

  static const String getCommentsByPostId = r'''
    query GetComments($postId: ID!) {
      comments (postId: $postId) {
          id,
          authorName,
          text,
          date,
          userId,
          postId
      }
    }
  ''';

  static const String createUser = r'''
    mutation CreateUserMutation($name: String!, $password: String!) {
      createUserMutation(input: { name: $name, password: $password }) {
        success
        error
      }
    }
  ''';

  static const String loginUser = r'''
    mutation LoginMutation($name: String!, $password: String!) {
      loginMutation(input: { name: $name, password: $password }) {
        id
        name
      }
    }
  ''';

  static const String createPost = r'''
    mutation createPost(
      $userId: String!
      $authorName: String!
      $title: String!
      $text: String!
      $date: String!
      $commentCount: Int!
    ) {
      createPostMutation(
        input: {
          userId: $userId
          authorName: $authorName
          title: $title
          text: $text
          date: $date
          commentCount: $commentCount
        }
      ) {
        success
        error
      }
    }
  ''';

  static const String createComment = r'''
    mutation createComment(
      $postId: String!
      $userId: String!
      $authorName: String!
      $text: String!
      $date: String!
    ) {
      createCommentMutation(
        input: {
          postId: $postId
          userId: $userId
          authorName: $authorName
          text: $text
          date: $date
        }
      ) {
        success
        error
      }
    }
  ''';

  static const String updatePost = r'''
    mutation updatePost($id: String!, $title: String!, $text: String!) {
      updatePostMutation(input: { id: $id, title: $title, text: $text }) {
        success
        error
      }
    }
  ''';

  static const String updateComment = r'''
    mutation updateComment($id: String!, $text: String!) {
      updateCommentMutation(input: { id: $id, text: $text }) {
        success
        error
      }
    }
  ''';

  static const String deletePost = r'''
    mutation deletePost($id: String!) {
      deletePostMutation(input: { id: $id }) {
        success
        error
      }
    }
  ''';

  static const String deleteComment = r'''
    mutation deleteComment($id: String!) {
      deleteCommentMutation(input: { id: $id }) {
        success
        error
      }
    }
  ''';
}
