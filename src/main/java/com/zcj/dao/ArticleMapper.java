package com.zcj.dao;

import java.util.List;

import com.zcj.domain.Article;


/**
 * 文章mapper
 * @author zhongchongjia
 *
 */
public interface ArticleMapper { 
	/**
	 * 
	 * @Title: update 
	 * @Description: 更新文章
	 * @param article
	 * @return
	 * @return: int
	 */
	int update(Article article);
	/**
	 * 
	 * @Title: insert 
	 * @Description: 增加文章
	 * @param article
	 * @return
	 * @return: int
	 */
	int insert(Article article);
	
	/**
	 * 
	 * @Title: select 
	 * @Description: 文章详情
	 * @param id
	 * @return
	 * @return: Article
	 */
	Article select(Integer id);
	
	
	/**
	 * 
	 * @Title: selects 
	 * @Description: 文章的列表查询
	 * @param articles
	 * @return
	 * @return: List<Article>
	 */
	List<Article> selects(Article articles);
	
	/**
	 * 
	 * @Title: selects 
	 * @Description: 按照评论数量显示文章
	 * @param articles
	 * @return
	 * @return: List<Article>
	 */
	List<Article> selectsOrderComments(Article articles);
	/**
	 * 高亮查询
	 * @param article
	 * @return
	 */
	List<Article> findAll ();
}
