package com.zcj.service;

import java.util.List;

import com.zcj.domain.Category;
import com.zcj.domain.Channel;

public interface ChannelService {
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
