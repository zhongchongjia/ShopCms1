<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 视窗 -->
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>管理员中心</title>
<link href="/resource/css/bootstrap.min.css" rel="stylesheet">
<script type="text/javascript" src="/resource/js/jquery-3.2.1.js"></script>
<script type="text/javascript" src="/resource/js/bootstrap.min.js"></script>
</head>
<body>

	<div class="container-fluid">

		<div class="row bg-dark">
			<div class="col-md-12" style="height: 50px">
				<img alt="" src="/resource/images/logo-my1.jpg" width="50px" height="50px" class="rounded-circle">
					<font color="white">管理员中心</font>
			</div>

		</div>

		<div class="row mt-1">

			<div class="col-md-2 bg-light" style="height: 550px">

				<div class="list-group text-center">
					<a href="#" data="/admin/articles"
						class="list-group-item list-group-item-action active"> 审核文章</a> <a
						href="#" data="/admin/users"
						class="list-group-item list-group-item-action"> 管理用户</a> <a
						href="#"  data="/admin/settings" class="list-group-item list-group-item-action">系统设置</a>
				</div>

			</div>

			<div class="col-md-10" id="center"></div>

		</div>

	</div>

</body>

<script type="text/javascript">
//文档就绪函数
$(function(){
	 //0 默认显示所有的文章
	 $("#center").load("/admin/articles")
	 
	 
	//1.为左侧菜单添加点击事件
	$("a").click(function(){
		//2/获取A标签的data
		var url =$(this).attr("data");
		
		$("a").removeClass("active");//删除所有样式
	    $(this).addClass("active");//为当前点击的菜单增加选中样式
		//3 在中间区域加载url
		$("#center").load(url);
	})
})

</script>
</html>
