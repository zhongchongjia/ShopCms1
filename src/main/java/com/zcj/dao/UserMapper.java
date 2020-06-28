package com.zcj.dao;

import java.util.List;

import com.zcj.domain.User;

/**
 * 用户
 * @author zhongchongjia
 *
 */
public interface UserMapper {
	/**
	 * 根据用户名称查询用户
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
	 * @return
	 */
	List<User> selects(User user);
	/**
	 * 修改用户
	 * @param user
	 * @return
	 */
	int update(User user);
}
