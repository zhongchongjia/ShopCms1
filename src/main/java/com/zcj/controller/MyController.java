package com.zcj.controller;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.github.pagehelper.PageInfo;
import com.zcj.domain.Article;
import com.zcj.domain.Category;
import com.zcj.domain.Channel;
import com.zcj.domain.User;
import com.zcj.service.ArticleService;
import com.zcj.service.ChannelService;

@RequestMapping("my")
@Controller
public class MyController {
	@Resource
	private ArticleService articleService;
	@Resource
	private ChannelService channelService;

	/**
	 * 
	 * @Title: index
	 * @Description: 进入个人中心首页
	 * @return
	 * @return: String 地址栏可以输如 my my/ my/index都能进入首页
	 */
	@RequestMapping(value = { "", "/", "index" })
	public String index() {

		return "my/index";
	}

	/**
	 * 
	 * @Title: articles
	 * @Description: 我的文章
	 * @param model
	 * @param article
	 * @param pageNum
	 * @param pageSize
	 * @return
	 * @return: String
	 */
	@RequestMapping("articles")
	public String articles(Model model,HttpSession session, Article article, @RequestParam(defaultValue = "1") Integer pageNum,
			@RequestParam(defaultValue = "6") Integer pageSize) {
       //从session获取当前登录的人信息
		User user = (User) session.getAttribute("user");
		article.setUserId(user.getId());//只显示登录人的文章
		
		PageInfo<Article> info = articleService.selects(article, pageNum, pageSize);
		model.addAttribute("info", info);
		return "my/articles";

	}

	/**
	 * 
	 * @Title: publish
	 * @Description: 去发布文章页面
	 * @return
	 * @return: String
	 */
	@GetMapping("publish")
	public String publish() {

		return "my/publish";

	}

	/**
	 * 
	 * @Title: publish
	 * @Description: 执行发布文章
	 * @return
	 * @return: boolean
	 */
	@ResponseBody
	@PostMapping("publish")
	public boolean publish(MultipartFile file, Article article,HttpSession session) {
		//判断是否选中文件
		if(null!=file && !file.isEmpty()) {
		  String  path ="d:/pic/";//文件上传地址
		 //为了防止文件名重名，需要进行处理  如 a.jpg
		  String fileName = file.getOriginalFilename();//原始名称
		  String newFilename=UUID.randomUUID()+fileName.substring(fileName.lastIndexOf("."));//新的文件名
			File f = new File(path, newFilename);//根据地址构建新的文件
			try {
				file.transferTo(f);//文件写入硬盘
				article.setPicture(newFilename);
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			
		}
		
		//初始化发布文件的属性信息
		  //从session获取当前登录的人信息
	    User user = (User) session.getAttribute("user");
		article.setUserId(user.getId());//发布人
		article.setStatus(0);//0:待审核
		article.setCreated(new Date());//发布时间
		article.setUpdated(new Date());//修改时间
		article.setDeleted(0);//正常
		article.setHot(0);//0：非热门 1：热门
		article.setContentType("0");//0:html 1:json
		return articleService.insert(article) >0;
	}

	/**
	 * 
	 * @Title: article
	 * @Description: 文章详情
	 * @param id
	 * @return
	 * @return: Article
	 */
	@ResponseBody
	@RequestMapping("article")
	public Article article(Integer id) {
		return articleService.select(id);

	}

	/**
	 * 
	 * @Title: channels
	 * @Description: 查询所有的分类
	 * @return
	 * @return: List<Channel>
	 */
	@ResponseBody
	@RequestMapping("channels")
	public List<Channel> channels() {

		return channelService.selects();

	}

	/**
	 * 
	 * @Title: categorys
	 * @Description: 根据栏目查询分类
	 * @param channelId
	 * @return
	 * @return: List<Category>
	 */
	@ResponseBody
	@RequestMapping("selectCategorysByChannelId")
	public List<Category> categorys(Integer channelId) {
		return channelService.selectCategorysByChannelId(channelId);
	}

}
