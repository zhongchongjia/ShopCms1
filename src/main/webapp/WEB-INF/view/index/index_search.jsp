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
<title>今日头条</title>
<style type="text/css">
.ex {
	overflow: hidden;
	text-overflow: ellipsis;
	display: -webkit-box;
	-webkit-line-clamp: 2;
	-webkit-box-orient: vertical;
}
</style>
<link href="/resource/css/index.css" rel="stylesheet">
<link href="/resource/css/bootstrap.min.css" rel="stylesheet">

<script type="text/javascript" src="/resource/js/jquery-3.2.1.js"></script>
<script type="text/javascript" src="/resource/js/popper.min.js"></script>
<script type="text/javascript" src="/resource/js/bootstrap.min.js"></script>




</head>
<body>
	<div class="container-fluid">
		<!--  head -->
		<div class="row" style="height: 34px">

			<div class="col-md-12 bg-dark">
				<button class="btn btn-link btn-sm">
					<font color="white">下载APP</font>
				</button>
				<button class="btn btn-link btn-sm">
					<button type="button" class="btn btn-link" data-toggle="modal"
						data-target="#exampleModal" onclick="reg()">
						<font color="white">注册</font>
					</button>
					<!-- 如果用户已经登录则不显示登录按钮 -->
					<c:if test="${sessionScope.user==null }">
						<button type="button" class="btn btn-link" data-toggle="modal"
							data-target="#exampleModal" onclick="login()">
							<font color="white">登录</font>
						</button>
					</c:if>
				</button>
				<!-- 如果用户登录显示登录信息 -->
				<c:if test="${sessionScope.user!=null }">
					<div class="float-right">
						<div class="btn-group dropleft">
							<button type="button" class="btn btn-dark dropdown-toggle"
								data-toggle="dropdown" aria-haspopup="true"
								aria-expanded="false">${sessionScope.user.username }</button>
							<div class="dropdown-menu">
								<c:if test="${sessionScope.user.role==0}">
									<a class="dropdown-item" href="/my">个人中心</a>
								</c:if>
								<c:if test="${sessionScope.user.role==1}">
									<a class="dropdown-item" href="/admin">管理员中心</a>
								</c:if>
								<a class="dropdown-item" href="#">头条产品</a> <a
									class="dropdown-item" href="/passport/logout">注销</a>
							</div>
						</div>

					</div>
				</c:if>
			</div>

		</div>
		<!-- body -->
		<div class="row ml-5 mr-5 mt-2">
			<!-- 左侧菜单 -->
			<div class="col-md-2">
				<div class="channel">

					<ul class="sub-list">
						<li class="mb-2"><a><img alt=""
								src="/resource/images/logo-index.png"
								style="height: 27px; width: 108px"></a></li>
						<li><a href="/"
							class="channel-item ${article.channelId==null?'active':"" }">热点</a></li>
						<!-- 遍历所有栏目 -->
						<c:forEach items="${channels}" var="channel">
							<li><a href="/?channelId=${channel.id}"
								class="channel-item ${article.channelId==channel.id?'active':"" }">${channel.name}</a></li>
						</c:forEach>

					</ul>

				</div>

			</div>
			<!-- 中间内容 -->
			<div class="col-md-7">
			<div>
		<form action="${pageContest.request.contextpath}/search">
			搜索内容:<input type="text" name="value" value="${value}">&nbsp;&nbsp;<button class="btn btn-info">搜索</button>
		</form>
			</div>
				<!-- 显示热点文章 和轮播图-->
				<c:if test="${article.channelId==null }">
					<!-- 广告-轮播图 -->
					<div id="carouselExampleCaptions" class="carousel slide"
						data-ride="carousel">
						<ol class="carousel-indicators">
							<c:forEach items="${slides}" var="slide" varStatus="i">
								<li data-target="#carouselExampleCaptions"
									data-slide-to="${i.index }" class="${i.index==0?'active':''}"></li>
							</c:forEach>

						</ol>
						<div class="carousel-inner">
							<c:forEach items="${slides}" var="slide" varStatus="i">
								<div class="carousel-item ${i.index==0?'active':''}">
									<img style="height: 350px" src="/pic/${slide.picture }"
										class="rounded d-block w-100" alt="...">
									<div class="carousel-caption d-none d-md-block">
										<h5>${slide.title }</h5>
									</div>
								</div>
							</c:forEach>
						</div>
						<a class="carousel-control-prev" href="#carouselExampleCaptions"
							role="button" data-slide="prev"> <span
							class="carousel-control-prev-icon" aria-hidden="true"></span> <span
							class="sr-only">Previous</span>
						</a> <a class="carousel-control-next" href="#carouselExampleCaptions"
							role="button" data-slide="next"> <span
							class="carousel-control-next-icon" aria-hidden="true"></span> <span
							class="sr-only">Next</span>
						</a>
					</div>




					<!-- 热点文章 -->
					<div class="mt-3">
						<ul class="list-unstyled">
							<c:forEach items="${info.content}" var="article">
								<li class="media"><img src="/pic/${article.picture}"
									class="mr-3 rounded" alt="..."
									style="height: 101.8px; width: 156px">
									<div class="media-body">
										<h5 class="mt-0 mb-1">
											<a href="/articleDetail?id=${article.id}" target="_blank">${article.title }</a>
										</h5>
										<p class="mt-4">${article.user.username}·
											${article.comments}评论 ·
											${article.mydate}
										</p>
									</div></li>
								<hr>
							</c:forEach>

						</ul>
					<a
						href="${pageContext.request.contextPath}/earch?page=1&value=${value}">首页</a>
						<a
						href="${pageContext.request.contextPath}/search?page=${info.number-1>1?pageInfo.number-1:1}&value=${value}">上一页</a>
						<a
						href="${pageContext.request.contextPath}/search?page=${info.number+1>pageInfo.totalPages?pageInfo.totalPages:pageInfo.number+1}&value=${value}">下一页</a>
						<a
						href="${pageContext.request.contextPath}/search?page=${info.totalPages}&value=${value}">尾页</a>
					
					</div>



				</c:if>


				<!-- 如果栏目不为空则显示栏目及分类下的文章 -->
				<c:if test="${article.channelId!=null }">
					<!-- 显示栏目下的分类 -->
					<div class="subchannel">
						<ul class="sub-list">
							<li class="sub-item ${article.categoryId==null?"sub-selected":"" }"><a
								href="/?channelId=${article.channelId}">全部</a></li>
							<c:forEach items="${categorys}" var="category">
								<li class="sub-item ${article.categoryId==category.id?"sub-selected":"" }""><a
									href="/?channelId=${article.channelId}&categoryId=${category.id}">${category.name }</a></li>
							</c:forEach>

						</ul>
					</div>
					<!-- 显示分类文章 -->
					<div>
						<ul class="list-unstyled">
							<c:forEach items="${info.list}" var="article">
								<li class="media"><img src="/pic/${article.picture}"
									class="mr-3 rounded" alt="..."
									style="height: 101.8px; width: 156px">
									<div class="media-body">
										<h5 class="mt-0 mb-1">
											<a href="/articleDetail?id=${article.id}" target="_blank">${article.title }</a>
										</h5>
										<p class="mt-4">${article.user.username}·
											0评论 ·
										${article.mydate}
												
										</p>
									
									</div></li>
								<hr>
							</c:forEach>

						</ul>
			<!-- 			<jsp:include page="/WEB-INF/view/common/pages.jsp" /> -->
					</div>
				</c:if>


			</div>
			<!-- 右侧边栏 -->
			<div class="col-md-3">
				<div class="card" style="width: 18rem;">
					<div class="card-header">
						<h5>24小时热文</h5>
					</div>
					<div class="card-body">
						<ul class="list-unstyled">
							<c:forEach items="${hot24Articles.list}" var="hot24Article">
								<li class="media"><img src="/pic/${hot24Article.picture}"
									class="mr-3 rounded" alt="..."
									style="width: 60px; height: 60px">
									<div class="media-body">
										<p class="ex">
											<a href="/articleDetail?id=${hot24Article.id}"
												target="_blank">${hot24Article.title }</a>
										</p>
									</div></li>
								<hr>
							</c:forEach>
						</ul>
					</div>
				</div>
			</div>
		</div>


	</div>

	<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">
						<span id="title"></span>
					</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body" id="passport"></div>

			</div>
		</div>
	</div>

</body>
<script type="text/javascript">
	//注册 --在modal里显示注册
	function reg() {
		$("#title").text("注册");
		$("#passport").load("/passport/reg");

	}
	//登录
	function login() {
		$("#title").text("登录");
		$("#passport").load("/passport/login");

	}

</script>
</html>
