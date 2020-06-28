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
<meta name="passwords" content="${article.passwords}">
<meta name="original" charset="${article.original}">
<meta name="description" content="${article.summary}" />
<title>${article.title }</title>
<link href="/resource/css/bootstrap.min.css" rel="stylesheet">
<script type="text/javascript" src="/resource/js/jquery-3.2.1.js"></script>
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
					<font color="white">注册头条号</font>
				</button>
				<div class="float-right">

					<button class="btn btn-link btn-sm">
						<font color="white">侵权投诉</font>
					</button>
					<button class="btn btn-link btn-sm">
						<font color="white">头条产品</font>
					</button>
					<button class="btn btn-link btn-sm" onclick="return1()">
						<font color="white">返回首页</font>
					</button>
				</div>
			</div>

		</div>
		<div class="row">

			<div class="col-md-2"></div>
			<div class="col-md-7">
				<h1>${article.title }</h1>
				<p>来源:${article.original}&nbsp;&nbsp;(微信公众号:${article.num})&nbsp;&nbsp;${article.user.username}·&nbsp;&nbsp;发布时间:${article.mydate}
				</p>
				<p>${article.content }</p>
				<!--发布评论  如果是登录用户则有发布框-->
				<c:if test="${sessionScope.user!=null }">
					<div>
						<hr>
						评论：
						<textarea rows="6" cols="110" name="content"></textarea>

						<button class="btn btn-info" type="button"
							onclick="add('${article.id }')">评论</button>
					</div>
				</c:if>


				<!-- 显示评论 -->
				<div>
					<hr>
					<c:forEach items="${info.list }" var="comment">
						<h5>
							${comment.user.username}
							<fmt:formatDate value="${comment.created}"
								pattern="yyyy-MM-dd HH:mm:ss" />
						</h5>
						<p>${comment.content }</p>

						<hr>
					</c:forEach>

				</div>
			</div>
			<div class="col-md-3">

				<div class="card" style="width: 18rem;">
				  <div class="card-header">评论排行榜</div>
					<div class="card-body">
						  <c:forEach items="${info2.list}" var="article" varStatus="i">
						   <p>${i.count}.${article.title }</p>
						   <hr>
						  </c:forEach>
					</div>
				</div>




			</div>


		</div>


	</div>

</body>
<script type="text/javascript">
	function add(articleId) {
		var content = $("[name='content']").val();
		$.post("/addComments", {
			articleId : articleId,
			content : content
		}, function(flag) {
			if (flag) {
				alert("评论成功");
				window.location.reload();//刷新当前页面
			}
		})

	}
	function return1(){
		location.href="/index";
	}
</script>
</html>
