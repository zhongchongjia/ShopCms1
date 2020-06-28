package com.zcj.service;

import com.github.pagehelper.PageInfo;
import com.zcj.domain.Comments;

public interface CommentsService {
	/**
	 * 
	 * @Title: insert 
	 * @Description: 增加评论
	 * @param comments
	 * @return
	 * @return: int
	 */
	boolean insert(Comments comments);
	/**
	 * 
	 * @Title: selects 
	 * @Description: 查询某一个文章的评论
	 * @param articleId
	 * @return
	 * @return: List<Comments>
	 */
	PageInfo<Comments> selects(Integer articleId,Integer pageNum,Integer pageSize);

}
