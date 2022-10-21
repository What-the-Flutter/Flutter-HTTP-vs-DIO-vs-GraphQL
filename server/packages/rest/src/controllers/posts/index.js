import Post from "../../models/post";
import Comment from "../../models/comment";
/* POSTS */

// find posts
export const FindPosts = async (ctx) => {
  const { limit, skip } = ctx.query;
  const skipInt = Math.max(0, parseInt(skip));
  const limitInt = parseInt(limit);

  try {
    const rawPosts = await Post.find({})
      .limit(limitInt)
      .skip(skipInt);

    let posts = [];
    for (let i = 0; i < rawPosts.length; i++) {
      const post = {
        id: rawPosts[i]._id,
        userId: rawPosts[i].userId,
        authorName: rawPosts[i].authorName,
        title: rawPosts[i].title,
        text: rawPosts[i].text,
        date: rawPosts[i].date,
      };
      posts.push(post);
    }
    return (ctx.body = posts );
  } catch (error) {
    ctx.status = 500;
    ctx.body = error;
  }
};

// create a post
export const CreateOnePost = async (ctx) => {
  const { userId, authorName, title, text } = ctx.request.body;
  const date = Date.now();

  try {
    const post = await Post.create({
      userId,
      authorName,
      title,
      text,
      date,
    });
    if (!post) return (ctx.status = 500);

    return (ctx.status = 200);
  } catch (error) {
    ctx.status = 500;
    ctx.body = error;
  }
};

// delete a post
export const DeleteOnePost = async (ctx) => {
  const { id } = ctx.params;

  try {
    const { deletedCount } = await Post.deleteOne({ _id: id });

    if (deletedCount === 0) return (ctx.status = 501);
    await Comment.deleteMany({ postId: id });

    return (ctx.status = 200);
  } catch (error) {
    ctx.status = 500;
    ctx.body = error;
  }
};

// update a post
export const UpdateOnePost = async (ctx) => {
  const { id } = ctx.params;
  const { title, text } = ctx.request.body;
  const date = Date.now();

  try {
    const post = await Post.updateOne({ _id: id }, { title, text });
    if (!post) return (ctx.status = 500);

    return (ctx.status = 200);
  } catch (error) {
    ctx.status = 500;
    ctx.body = error;
  }
};
