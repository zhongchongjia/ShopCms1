package com.zcj.service.lmpl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zcj.dao.UserMapper;
import com.zcj.domain.User;
import com.zcj.service.UserService;
import com.zcj.until.CMSException;
import com.zcj.until.Md5Util;
import com.zhongchongjia.common.utils.StringUtil;

@Service
public class UserServiceImpl implements UserService {

	@Resource
	private UserMapper userMapper;

	@Override
	public PageInfo<User> selects(User user, Integer pageNum, Integer pageSize) {
		PageHelper.startPage(pageNum, pageSize);
		List<User> list = userMapper.selects(user);

		return new PageInfo<User>(list);
	}

	@Override
	public int update(User user) {
		// TODO Auto-generated method stub
		return userMapper.update(user);
	}

	@Override
	public int insert(User user) {

		// 进行注册的规则校验
		// 1.用户名不能为空
		if (!StringUtil.hasText(user.getUsername()))
			throw new CMSException("用户名不能为空");
		// 2..用户名的长度在5-10之间
		if (!(user.getUsername().length() >= 5 && user.getUsername().length() <= 10))
			throw new CMSException("用户名的长度必须在5-10之间");
		// 3.密码不能为空
		if (!StringUtil.hasText(user.getPassword()))
			throw new CMSException("密码不能为空");
		// 4密码范围
		if (!(user.getPassword().length() >= 6 && user.getPassword().length() <= 10))
			throw new CMSException("密码的长度必须在6-10之间");
		// 5.两次密码输入是否一致
		if (!user.getPassword().equals(user.getRepassword()))
			throw new CMSException("两次密码输入不一致");
		
		//6.对密码进行加密
		user.setPassword(Md5Util.endcode(user.getPassword()));

		return userMapper.insert(user);
	}

	@Override
	public User selectByName(String username) {
		return userMapper.selectByName(username);
	}

	@Override
	public User login(User user) {
		// 进行登录规则校验
		// 1.用户名不能为空
		if (!StringUtil.hasText(user.getUsername()))
			throw new CMSException("用户名不能为空");
		//2 检查用户是否存在
		User u = selectByName(user.getUsername());
		if(null==u)
			throw new CMSException("无此用户");
        //3 检查密码是否正确
		   //3.1
		if (!StringUtil.hasText(user.getPassword()))
			throw new CMSException("密码不能为空");
		  //3.2 对登录的密码再进行加密和数据库的进行比较
		if(!Md5Util.endcode(user.getPassword()).equals(u.getPassword()))
			throw new CMSException("密码不正确");
			//4.如果用户状态没禁用，则不能登录
		if(u.getLocked()==1)
			throw new CMSException("该账户被禁用，如有疑问请联系管理员");
		return u;
	}

}
