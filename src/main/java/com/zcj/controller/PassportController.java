package com.zcj.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zcj.domain.User;
import com.zcj.service.UserService;
import com.zcj.until.CMSException;
import com.zcj.until.CMSResult;

@Controller
@RequestMapping("passport")
public class PassportController {
	@Resource
	private UserService userService;
	/**
	 * 
	 * @Title: reg
	 * @Description: 去注册
	 * @return
	 * @return: String
	 */
	@GetMapping("reg")
	public String reg() {

		return "passport/reg";

	}
	/**
	 * 
	 * @Title: reg 
	 * @Description: 执行注册
	 * @param user
	 * @return
	 * @return: boolean
	 */
	@ResponseBody
	@PostMapping("reg")
	public CMSResult<User> reg(User user) {
		CMSResult<User> result =new CMSResult<User>();
		//捕获异常，并封装消息
		try {
		     userService.insert(user);
		     result.setCode(200);
		     result.setMsg("恭喜注册成功,请登录");
			
		} catch (CMSException e) {
			e.printStackTrace();
			result.setCode(300);
			result.setMsg(e.getMessage());
		}catch (Exception e) {
			e.printStackTrace();
			result.setCode(500);
			result.setMsg("系统崩溃，请联系管理员。");
		}
		return result;
	}
	/**
	 * 
	 * @Title: login 
	 * @Description: 普通用户登录
	 * @return
	 * @return: String
	 */
	@GetMapping("login")
	public String login() {
		return "passport/login";
	}
	/**
	 * 
	 * @Title: login 
	 * @Description: 普通用户登录
	 * @param user
	 * @return
	 * @return: CMSResult<User>
	 */
	@ResponseBody
	@PostMapping("login")
	public CMSResult<User> login(User user,HttpSession session) {
		CMSResult<User> result =new CMSResult<User>();
		//捕获异常，并封装消息
		try {
		     User u = userService.login(user);
		     if(u.getRole()==1)//是管理员
		      session.setAttribute("admin", u);//存入session
		     session.setAttribute("user", u);//普通用户，存入session
		     result.setCode(200);
		     result.setMsg("恭喜登录成功");
			
		} catch (CMSException e) {
			e.printStackTrace();
			result.setCode(300);
			result.setMsg(e.getMessage());
		}catch (Exception e) {
			e.printStackTrace();
			result.setCode(500);
			result.setMsg("系统崩溃，请联系管理员。");
		}
		return result;
	}
	
	
	/**
	 * 
	 * @Title: logout 
	 * @Description: 注销当前用户
	 * @return
	 * @return: String
	 */
	@RequestMapping("logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";//注销后重定向到系统首页
		
	}
}
