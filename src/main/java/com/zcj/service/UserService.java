package com.zcj.service;

import com.github.pagehelper.PageInfo;
import com.zcj.domain.User;

public interface UserService {
	/**
	 *  根据用户名称查询用户
	 * @param username
	 * @return
	 */
	User selectByName(String username);
	/**
	 * 注册
	 * @param user
	 * @return
	 */
	int insert(User user);
	/**
	 * 用户列表
	 * @param user
	 * @param pageNum
	 * @param pageSize
	 * @return
	 */
	PageInfo<User> selects(User user,Integer pageNum,Integer pageSize);
	/**
	 * 修改用户
	 * @param user
	 * @return
	 */
	int update(User user);
	/**
	 * 登陆
	 * @param user
	 * @return
	 */
	User  login(User user);
}
