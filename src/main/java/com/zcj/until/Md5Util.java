package com.zcj.until;

import org.apache.commons.codec.digest.DigestUtils;
/**
 * 加密工具类
 * @author zhongchongjia
 *
 */
public class Md5Util {

	/**
	 * 
	 * @Title: endcode 
	 * @Description: 对密码进行加密处理
	 * @param password
	 * @return
	 * @return: String
	 */
	/**
	 * 直接对密码进行散列，那么黑客可以对通过获得这个密码散列值，
	 * 然后通过查散列值字典（例如MD5密码破解网站），得到某用户的密码。
	 * 加Salt可以一定程度上解决这个问题
	 */
	private static String salt="qazwsx123";
	public  static String endcode(String password) {
		
		return DigestUtils.md5Hex(password + salt);
	}
	//测试
//	public static void main(String[] args) {
//		System.out.println(Md5Util.endcode("123456"));
//		System.out.println(Md5Util.endcode("123456"));
//		System.out.println(Md5Util.endcode("1"));
//		System.out.println(Md5Util.endcode("1"));
//	}
}
