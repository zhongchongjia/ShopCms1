package com.zcj.dao;

import java.util.List;

import com.zcj.domain.Comments;

/**
 * 评论
 * @author zhongchongjia
 *
 */
public interface CommentsMapper {
	/**
	 * 
	 * @Title: insert 
	 * @Description: 增加评论
	 * @param comments
	 * @return
	 * @return: int
	 */
	int insert(Comments comments);
	/**
	 * 
	 * @Title: selects 
	 * @Description: 查询某一个文章的评论
	 * @param articleId
	 * @return
	 * @return: List<Comments>
	 */
	List<Comments> selects(Integer articleId);
	/**
	 * 
	 * @Title: updateArticle 
	 * @Description: 更新文章表的 评论数量
	 * @param articleId
	 * @return
	 * @return: int
	 */
	int updateArticle(Integer articleId);

}
