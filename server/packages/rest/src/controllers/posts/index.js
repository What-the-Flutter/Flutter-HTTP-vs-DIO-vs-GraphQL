import Post from "../../models/post";
import Comment from "../../models/comment";
/* POSTS */

// find posts
export const FindPosts = async (ctx) => {
  const { limit, skip } = ctx.query;
  const skipInt = Math.max(0, parseInt(skip));
  const limitInt = parseInt(limit);
  const rawPosts = await Post.find({})
    .limit(limitInt)
    .skip(skipInt);

  let posts = [];

  for (let i = 0; i < rawPosts.length; i++) {
    const post = {
      id: rawPosts[i]._id,
      userId: rawPosts[i].userId,
      title: rawPosts[i].title,
      text: rawPosts[i].text,
      date: rawPosts[i].date,
    };
    posts.push(post);
  }

  ctx.body = { posts };
};

// find a post
export const FindOnePost = async (ctx) => {
  const { id } = ctx.params;
  const rawPost = await Post.findOne({ _id: id });

  return (ctx.body = {
    id: rawPost._id,
    userId: rawPost.userId,
    title: rawPost.title,
    text: rawPost.text,
    date: rawPost.date,
  });
};

// create a post
export const CreateOnePost = async (ctx) => {
  const { userId, title, text } = ctx.request.body;
  const date = Date.now();

  await Post.create({
    userId,
    title,
    text,
    date,
  });
  ctx.status = 200;
};

// delete a post
export const DeleteOnePost = async (ctx) => {
  const { id } = ctx.params;
  const { deletedCount } = await Post.deleteOne({ _id: id });

  if (deletedCount != 0) {
    await Comment.deleteMany({ postId: id });
    return (ctx.status = 200);
  }

  return (ctx.status = 500);
};

// update a post
export const UpdateOnePost = async (ctx) => {
  const { id } = ctx.params;
  const { title, text } = ctx.request.body;
  const date = Date.now();
  
  await Post.updateOne({ _id: id }, { title, text, date });
  ctx.status = 200;
};
