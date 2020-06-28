package com.zcj.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.github.pagehelper.PageInfo;
import com.zcj.domain.Article;
import com.zcj.domain.User;
import com.zcj.service.ArticleService;
import com.zcj.service.UserService;

@RequestMapping("admin")
@Controller
public class AdminController {
	
	@Resource
	private ArticleService articleService;
	@Resource
	private UserService userService;
	@RequestMapping(value = {"","/","index"})
	public String index() {
		return "admin/index";
	}
	/**
	 * 查询所有用户
	 * @param model
	 * @param user
	 * @param pageNum
	 * @param pageSize
	 * @return
	 */
	@RequestMapping("users")
	public String users(Model model,User user,@RequestParam(defaultValue = "1")Integer pageNum,@RequestParam(defaultValue = "8")Integer pageSize) {
		PageInfo<User> info = userService.selects(user, pageNum, pageSize);
		model.addAttribute("info", info);
		model.addAttribute("user", user);
		return "admin/users";
	}
	/**
	 * 更新用户
	 * @param user
	 * @return
	 */
	@ResponseBody
	@PostMapping("updateUser")
	public boolean updateUpdate(User user) {
		return userService.update(user)>0;
	}
	/**
	 * 所有的文章
	 * @param model
	 * @param article
	 * @param pageNum
	 * @param pageSize
	 * @return
	 */
	@RequestMapping("articles")
	public String articles(Model model,Article article,@RequestParam(defaultValue = "1")Integer pageNum,@RequestParam(defaultValue = "8")Integer pageSize) {
		if(article.getStatus()==null)
			article.setStatus(0);	
		PageInfo<Article> info = articleService.selects(article, pageNum, pageSize);
		model.addAttribute("info", info);
		model.addAttribute("article", article);
		return "admin/articles";
	}
	/**
	 * 文章详情
	 * @param id
	 * @return
	 */
	@ResponseBody
	@RequestMapping("article")
	public Article article(Integer id) {
		return articleService.select(id);
	}
	/**
	 * 更新文章
	 * @param article
	 * @return
	 */
	@ResponseBody
	@PostMapping("updateArticle")
	public boolean updateArticle(Article article) {
		return articleService.update(article)>0;
	}
}
