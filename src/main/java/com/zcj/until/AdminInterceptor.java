package com.zcj.until;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
/**
 * 管理员中心拦截器
 * @author zhongchongjia
 *
 */
public class AdminInterceptor extends HandlerInterceptorAdapter {
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		//如果用户已经登录则不拦截
		HttpSession session = request.getSession();
		Object object = session.getAttribute("admin");
		if(null!=object) {
			return true;//用户已经登录。则不拦截
		}
		
		//用户没有登录。则进行拦截，把用户请求转发到登录页面
		
		request.setAttribute("msg", "请登录后再试");
		request.getRequestDispatcher("/WEB-INF/view/passport/login.jsp").forward(request, response);
		
		return false;
	}
	
}
