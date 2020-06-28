package com.zcj.service.lmpl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.zcj.dao.SlideMapper;
import com.zcj.domain.Slide;
import com.zcj.service.SlideService;

@Service
public class SlideServiceImpl implements SlideService {

	@Resource
	private SlideMapper slideMapper;
	@Override
	public List<Slide> selects() {
		return slideMapper.selects();
	}

}
