package com.zcj.service;

import com.github.pagehelper.PageInfo;
import com.zcj.domain.Article;
public interface ArticleService {
	

	/**
	 * 
	 * @Title: selects 
	 * @Description: 按照评论数量显示文章
	 * @param articles
	 * @return
	 * @return: List<Article>
	 */
	PageInfo<Article> selectsOrderComments(Article articles,Integer pageNum,Integer pageSize);
	/*
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
	 * @Description: 文章列表
	 * @param articles
	 * @param pageNum
	 * @param pageSize
	 * @return
	 * @return: PageInfo<Article>
	 */
	PageInfo<Article> selects(Article articles,Integer pageNum,Integer pageSize);
}
