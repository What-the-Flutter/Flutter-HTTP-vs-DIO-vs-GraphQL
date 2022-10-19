import Comment from "./../../models/comment";
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
    ctx.body = error;
  }
};

// create a comment
export const CreateOneComment = async (ctx) => {
  const { userId, postId, authorName, text } = ctx.request.body;
  const date = Date.now();

  try {
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
    ctx.body = error;
  }
};

// create a update
export const UpdateOneComment = async (ctx) => {
  const { id, text } = ctx.request.body;
  const date = Date.now();

  try {
    const comment = await Comment.updateOne({ _id: id }, { text, date });
    if (!comment) return (ctx.status = 500);

    return (ctx.status = 200);
  } catch (error) {
    ctx.status = 500;
    ctx.body = error;
  }
};

// create a delete
export const DeleteOneComment = async (ctx) => {
  const { id } = ctx.params;

  try {
    const { deletedCount } = await Comment.deleteOne({ _id: id });
    if (deletedCount === 0) {
      return (ctx.status = 500);
    }
    return (ctx.status = 200);
  } catch (error) {
    ctx.status = 500;
    ctx.body = error;
  }
};
