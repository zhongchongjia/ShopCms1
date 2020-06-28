package com.zcj.test;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.elasticsearch.core.ElasticsearchTemplate;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.zcj.dao.ArticleMapper;
import com.zcj.domain.Article;
import com.zcj.until.EsUtils;
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({ "classpath:spring-beans.xml" })
public class EsTest {
	@Autowired
	ElasticsearchTemplate elasticsearchTemplate;
	@Autowired
	private ArticleMapper mapper;
	//保存同步
	@Test
	public void test() {
		List<Article> list=mapper.findAll();
		for (Article article : list) {
			EsUtils.saveObject(elasticsearchTemplate, article.getId()+"", article);
			System.out.println(article);
		}
		
	}

}
