import Article from "./../../models/article";
import Comment from "./../../models/comment";
import GetSlug from "./../../helper/GetSlug";
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
          "author": rawArticles[i].author,
          "userId": rawArticles[i].userId,
          "title":  rawArticles[i].title,
          "subtitle": rawArticles[i].subtitle,
          "description": rawArticles[i].description,
          "date": rawArticles[i].date,
          "date_update": rawArticles[i].date_update,
          "slug": rawArticles[i].slug
        };
        console.log(article);
        posts.push(article);
      }

      ctx.body = { posts };
  };
  
  // find an article
  export const FindOneArticles = async ctx => {
    const { id } = ctx.params;
    const rawArticle = await Article.findOne({ _id: id });

    return ctx.body = { 
      id: rawArticle._id,
      author: rawArticle.author,
      userId: rawArticle.userId,
      title:  rawArticle.title,
      subtitle: rawArticle.subtitle,
      description: rawArticle.description,
      date: rawArticle.date,
      date_update:rawArticle.date_update,
      slug: rawArticle.slug
    };
  };
  
  // create an article
  export const CreateOneArticles = async ctx => {
    const { userId, title, subtitle, description, author } = ctx.request.body;
    console.log(userId);
    const slug = GetSlug("articles", title);
    const date = Date.now();
  
    await Article.create({
      userId,
      title,
      subtitle,
      description,
      author,
      date,
      date_update: null,
      slug
    });
    ctx.status = 200;
  };
  
  // delete an article
  export const DeleteOneArticle = async ctx => {
    const { id } = ctx.params;
    const { deletedCount } = await Article.deleteOne({ _id: id });
    await Comment.deleteMany({ idArticle : id });

    if (deletedCount != 0) return ctx.status = 200
    return ctx.status = 500;
  };
  
  // update an article
  export const UpdateOneArticle = async ctx => {
    const { id } = ctx.params;
    const { title, subtitle, description } = ctx.request.body;
    const date = Date.now();
    await Article.updateOne(
      { _id: id },
      { title, subtitle, description, date_update: date }
    );
    ctx.status = 200;
  };
  
  /* PRMALINK */
export const Permalink = async ctx => {
  const { slug } = ctx.query;
  const article = await Article.findOne({ slug });
  return ctx.body = article
};
