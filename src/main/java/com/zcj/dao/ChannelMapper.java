package com.zcj.dao;

import java.util.List;

import com.zcj.domain.Category;
import com.zcj.domain.Channel;

/**
 * 栏目
 * @author zhongchongjia
 *
 */
public interface ChannelMapper {
	/**
	 * 所有栏目
	 * @return
	 */
	List<Channel> selects();
	/**
	 * 根据栏目查询分类
	 * @param channelId
	 * @return
	 */
	List<Category> selectCategorysByChannelId(Integer channelId);

}
