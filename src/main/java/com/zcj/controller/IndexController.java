package com.zcj.controller;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.data.elasticsearch.core.ElasticsearchTemplate;
import org.springframework.data.elasticsearch.core.aggregation.AggregatedPage;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageInfo;
import com.zcj.domain.Article;
import com.zcj.domain.Category;
import com.zcj.domain.Channel;
import com.zcj.domain.Comments;
import com.zcj.domain.Slide;
import com.zcj.domain.User;
import com.zcj.service.ArticleService;
import com.zcj.service.ChannelService;
import com.zcj.service.CommentsService;
import com.zcj.service.SlideService;
import com.zcj.until.EsUtils;
import com.zhongchongjia.common.utils.DateUtil;

@Controller
public class IndexController {
	@Resource
	private ChannelService channelService;
	@Resource
	private ArticleService articleService;
	@Resource
	private SlideService slideService;
	@Resource
	private CommentsService commentsService;
	@Resource
	private ElasticsearchTemplate elasticsearchTemplate;
	/**
	 * 
	 * @Title: index 
	 * @Description: 进入系统首页
	 * @return
	 * @return: String
	 */
	@RequestMapping(value = {"","/","index"})
	public String index(Model model,Article article,@RequestParam(defaultValue = "1")Integer pageNum,@RequestParam(defaultValue = "5")Integer pageSize) {
		
		model.addAttribute("article", article);//封装查询条件
		article.setStatus(1);//只显示审核过的文章
		//1.查询所有的栏目
		List<Channel> channels = channelService.selects();
		model.addAttribute("channels", channels);
		//2.根据栏目id查询所有分类
		List<Category> categorys = channelService.selectCategorysByChannelId(article.getChannelId());
		model.addAttribute("categorys", categorys);
		//3.查询栏目下的文章
		if(article.getChannelId()!=null) {
			PageInfo<Article> info = articleService.selects(article, pageNum, pageSize);
			model.addAttribute("info", info);
		}
		//4.显示热点文章 和广告
		if(article.getChannelId()==null) {
			//1热点文章
			article.setHot(1);//热点文章
			PageInfo<Article> info = articleService.selects(article, pageNum, pageSize);
			model.addAttribute("info", info);
			//2 广告
			List<Slide> slides = slideService.selects();
			model.addAttribute("slides", slides);
		}
		
		//5 右侧边栏显示24小内容的热点文章
		 Article article2 = new Article();
		 article2.setStatus(1);//只显示审核过的文章
		 article2.setHot(1);//热点文章
		 article2.setCreated(DateUtil.SubDate(new Date(), 24));//把当前系统时间减去24 个小时
		 
		PageInfo<Article> hot24Articles = articleService.selects(article2, 1, 5);
		model.addAttribute("hot24Articles", hot24Articles);
		
		return "index/index";
		
	}
	/**
	 * 高亮搜索
	 * @param id
	 * @param model
	 * @param pageNum
	 * @param pageSize
	 * @return
	 */
	@GetMapping("search")
	public String search(String value,Integer id,Article article,Model model,@RequestParam(defaultValue = "1")Integer pageNum,@RequestParam(defaultValue = "5")Integer pageSize) {
		article.setStatus(1);//只显示审核过的文章
		//查询所有栏目
		List<Channel> channels = channelService.selects();
		//根据栏目ID查询所有分类
		//2.根据栏目id查询所有分类
		List<Category> categorys = channelService.selectCategorysByChannelId(article.getChannelId());
		model.addAttribute("channels", channels);
		model.addAttribute("categorys", categorys);
		model.addAttribute("article", article);
		AggregatedPage<?> info = EsUtils.selectObjects(elasticsearchTemplate,
		Article.class, pageNum, pageSize, new String[] {"title"}, value, "id");
		model.addAttribute("info", info);
		//显示热点文章和广告
		if(article.getChannelId()==null){
		//广告
		List<Slide> slides = slideService.selects();
		model.addAttribute("slides", slides);
		}
		//右侧边栏显示24小时的热门文章
		 Article article2 = new Article();
		 article2.setStatus(1);//只显示审核过的文章
		 article2.setHot(1);//热点文章
		 article2.setCreated(DateUtil.SubDate(new Date(), 24));//把当前系统时间减去24 个小时
		PageInfo<Article> hot24Articles = articleService.selects(article2, 1, 5);
		model.addAttribute("hot24Articles", hot24Articles);
		return "index/index_search";

	}
	

	/**
	 * 
	 * @Title: articleDetail 
	 * @Description: 文章详情
	 * @param id
	 * @return
	 * @return: String
	 */
	@GetMapping("articleDetail")
	public String articleDetail(Integer id,Model model,@RequestParam(defaultValue = "1")Integer pageNum,@RequestParam(defaultValue = "5")Integer pageSize) {
		Article article = articleService.select(id);
		model.addAttribute("article",article);
		//查询出当前文章的所有评论
		PageInfo<Comments> info = commentsService.selects(id, pageNum, pageSize);
		article.setMydate(DateUtil.getDisplayTime(article.getCreated()));
		model.addAttribute("info",info);
		//查询评论数量较高的5篇文章
		PageInfo<Article> info2 = articleService.selectsOrderComments(null, 1, 5);
		model.addAttribute("info2",info2);
		
		
		return "index/articleDetail";
	}
	/**
	 * 
	 * @Title: addComments 
	 * @Description: 增加评论
	 * @param comments
	 * @return
	 * @return: boolean
	 */
	@ResponseBody
	@RequestMapping("addComments")
	public boolean addComments(Comments comments,HttpSession session) {
	
		//封装评论人
		User user = (User) session.getAttribute("user");
		comments.setUserId(user.getId());
		//封装评时间
		comments.setCreated(new Date());
		return commentsService.insert(comments);
	}
}
