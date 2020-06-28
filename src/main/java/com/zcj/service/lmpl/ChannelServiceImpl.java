package com.zcj.service.lmpl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.zcj.dao.ChannelMapper;
import com.zcj.domain.Category;
import com.zcj.domain.Channel;
import com.zcj.service.ChannelService;


@Service
public class ChannelServiceImpl implements ChannelService {
	@Resource
	ChannelMapper channelMapper;

	@Override
	public List<Channel> selects() {
		// TODO Auto-generated method stub
		return channelMapper.selects();
	}

	@Override
	public List<Category> selectCategorysByChannelId(Integer channelId) {
		// TODO Auto-generated method stub
		return channelMapper.selectCategorysByChannelId(channelId);
	}

}
