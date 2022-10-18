import Comment from "./../../models/comment";
/* COMMENTS */

// get a comment
export const GetComments = async ctx => {
    const { articleId } = ctx.params;
    const { limit, skip } = ctx.query;
    const skipInt = Math.max(0, parseInt(skip));
    const limitInt = parseInt(limit);
    
    const rawComments = await Comment.find({ articleId })
      .limit(limitInt)
      .skip(skipInt);
      
      let comments = [];
  
      for (let i = 0; i < rawComments.length; i++) {
        const comment = { 
          "id": rawComments[i]._id,
          "articleId": rawComments[i].articleId,
          "authorName":  rawComments[i].authorName,
          "text": rawComments[i].text,
          "date": rawComments[i].date,
        };
        comments.push(comment);
      }
  
    return (ctx.body = comments);
  };
  
  // create a comment
  export const CreateOneComment = async ctx => {
    const { userId, articleId, authorName, text } = ctx.request.body;
    const date = Date.now();

    await Comment.create({
      userId,
      articleId,
      authorName,
      text,
      date
    });
    return (ctx.status = 200);
  };
  
  // create a update
  export const UpdateOneComment = async ctx => {
    const { id, text } = ctx.request.body;
    const date = Date.now();

    await Comment.updateOne({ _id: id }, { text, date });
    return (ctx.status = 200);
  };
  
  // create a delete
  export const DeleteOneComment = async ctx => {
    const { id } = ctx.params;
    await Comment.deleteOne({ _id: id });
    return (ctx.status = 200);
  };