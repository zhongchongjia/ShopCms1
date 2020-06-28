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
<title></title>
<link href="/resource/css/bootstrap.min.css" rel="stylesheet">
<script type="text/javascript" src="/resource/js/jquery-3.2.1.js"></script>
<script type="text/javascript" src="/resource/js/popper.min.js"></script>
<script type="text/javascript" src="/resource/js/bootstrap.min.js"></script>
</head>
<body>
	<div class="container-fluid">

		<!-- head -->
		<div class="row">
			<div class="col-md-12"
				style="background-color: #563D7C; height: 50px">
				<a href="/">
				<img alt="" src="/resource/images/logo-my1.jpg" class="rounded-circle" width="50px"
					height="50px"></a> <font color="white">个人中心</font>
			
			<!-- 如果用户登录显示登录信息 -->
				<c:if test="${sessionScope.user!=null }">
					<div class="float-right">
				
						<div class="btn-group dropleft">
							<button type="button" class="btn btn-purple text-white dropdown-toggle"
								data-toggle="dropdown" aria-haspopup="true"
								aria-expanded="false">${sessionScope.user.username }</button>
							<div class="dropdown-menu">

								<a class="dropdown-item" href="/">首页</a> <a
									class="dropdown-item" href="#">头条产品</a>
									<a
									class="dropdown-item" href="/passport/logout">注销</a>
							</div>
						</div>

					</div>
				</c:if>
				</div>

		</div>
		<div class="row mt-1">
			<div class="col-md-2 bg-light" style="height: 550px">

				<div class="list-group text-center">
					<a href="#" data="/my/articles" class="list-group-item list-group-item-action active">
						我的文章 </a> <a href="#" data="/my/publish" class="list-group-item list-group-item-action">
						发布文章</a> <a href="#" class="list-group-item list-group-item-action">我的收藏</a>
					<a href="#" class="list-group-item list-group-item-action">
						我的评论</a> <a href="#"
						class="list-group-item list-group-item-action disabled"
						tabindex="-1" aria-disabled="true">我的设置</a>
				</div>

			</div>
			 <!-- 中间内容区域 -->
			<div class="col-md-10" id="center">
			 <!-- 提前引入kindeditor -->
			<div style="display: none">
			  <jsp:include page="/resource/kindeditor/jsp/demo.jsp"/>
			</div>
			
			
			</div>
		</div>
	</div>



</body>
<script type="text/javascript">
//文档就绪函数
 $(function(){
	 //0 默认显示我的文章
	 $("#center").load("/my/articles")
	 
	 
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
