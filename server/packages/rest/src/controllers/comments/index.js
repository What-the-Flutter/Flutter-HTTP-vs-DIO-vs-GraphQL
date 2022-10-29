import Comment from "./../../models/comment";
import Post from "./../../models/post";
/* COMMENTS */

// get a comment
export const GetComments = async (ctx) => {
  const { postId } = ctx.params;
  const { limit, skip } = ctx.query;
  const skipInt = Math.max(0, parseInt(skip));
  const limitInt = parseInt(limit);

  try {
    const rawComments = await Comment.find({ postId })
      .limit(limitInt)
      .skip(skipInt);

    let comments = [];
    for (let i = 0; i < rawComments.length; i++) {
      const comment = {
        id: rawComments[i]._id,
        userId: rawComments[i].userId,
        postId: rawComments[i].postId,
        authorName: rawComments[i].authorName,
        text: rawComments[i].text,
        date: rawComments[i].date,
      };
      comments.push(comment);
    }

    return (ctx.body = comments);
  } catch (error) {
    ctx.status = 500;
    ctx.body = error.message;
  }
};

// create a comment
export const CreateOneComment = async (ctx) => {
  const { userId, postId, authorName, text } = ctx.request.body;
  const date = Date.now();

  try {
    let { commentCount } = await Post.findOne({ _id: postId });
    await Post.updateOne({ _id: postId }, { commentCount: ++commentCount });
    const comment = await Comment.create({
      userId,
      postId,
      authorName,
      text,
      date,
    });
    if (!comment) return (ctx.status = 500);

    return (ctx.status = 200);
  } catch (error) {
    ctx.status = 500;
    ctx.body = error.message;
  }
};

// create a update
export const UpdateOneComment = async (ctx) => {
  const { id } = ctx.params;
  const { text } = ctx.request.body;
  const date = Date.now();

  try {
    const comment = await Comment.updateOne({ _id: id }, { text });
    if (!comment) return (ctx.status = 500);

    return (ctx.status = 200);
  } catch (error) {
    ctx.status = 500;
    ctx.body = error.message;
  }
};

// create a delete
export const DeleteOneComment = async (ctx) => {
  const { id } = ctx.params;

  try {
    let { postId } = await Comment.findOne({ _id: id });
    let { commentCount } = await Post.findOne({ _id: postId });
    await Post.updateOne({ _id: postId }, { commentCount: --commentCount });
    const { deletedCount } = await Comment.deleteOne({ _id: id });
    if (deletedCount === 0) {
      return (ctx.status = 500);
    }
    return (ctx.status = 200);
  } catch (error) {
    ctx.status = 500;
    ctx.body = error.message;
  }
};
