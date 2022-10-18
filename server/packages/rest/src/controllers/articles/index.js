import Article from "./../../models/article";
import Comment from "./../../models/comment";
/* ARTICLES */

// find articles
export const FindArticles = async ctx => {
    const { limit, skip } = ctx.query;
    const skipInt = Math.max(0, parseInt(skip));
    const limitInt = parseInt(limit);
    const rawArticles = await Article.find({})
      .limit(limitInt)
      .skip(skipInt);

      let posts = [];
  
      for (let i = 0; i < rawArticles.length; i++) {
        const article = { 
          "id": rawArticles[i]._id,
          "userId": rawArticles[i].userId,
          "title":  rawArticles[i].title,
          "text": rawArticles[i].text,
          "date": rawArticles[i].date,
        };
        posts.push(article);
      }

      ctx.body = { posts };
  };
  
  // find an article
  export const FindOneArticles = async ctx => {
    const { id } = ctx.params;
    console.log(id);
    const rawArticle = await Article.findOne({ _id: id });
    console.log(rawArticle);
    return ctx.body = { 
      id: rawArticle._id,
      userId: rawArticle.userId,
      title:  rawArticle.title,
      text: rawArticle.text,
      date: rawArticle.date,
    };
  };
  
  // create an article
  export const CreateOneArticles = async ctx => {
    const { userId, title, text } = ctx.request.body;
    const date = Date.now();
  
    await Article.create({
      userId,
      title,
      text,
      date
    });
    ctx.status = 200;
  };
  
  // delete an article
  export const DeleteOneArticle = async ctx => {
    const { id } = ctx.params;
    const { deletedCount } = await Article.deleteOne({ _id: id });
    
    if (deletedCount != 0) 
    {
      await Comment.deleteMany({ articleId : id });
      return ctx.status = 200
    }
    
    return ctx.status = 500;
  };
  
  // update an article
  export const UpdateOneArticle = async ctx => {
    const { id } = ctx.params;
    const { title, text } = ctx.request.body;
    const date = Date.now();
    await Article.updateOne(
      { _id: id },
      { title, text, date }
    );
    ctx.status = 200;
  };
