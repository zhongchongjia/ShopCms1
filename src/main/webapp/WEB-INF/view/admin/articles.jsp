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
<script type="text/javascript" src="/resource/js/bootstrap.min.js"></script>
</head>
<body>
	<div class="container-fluid">
		<div class="form-inline">
			<div class="form-group">
				<label for="title">标题</label> <input class="form-control" id="title"
					type="text" name="title" value="${article.title}">
			</div>

			<div class="form-check">
				<input class="form-check-input" type="radio" name="status"
					id="status0" value="0" ${article.status==0?"checked":"" }> <label class="form-check-label"
					for="status0"> 待审 </label>
			</div>
			<div class="form-check">
				<input class="form-check-input" type="radio" name="status"
					id="status1" value="1" ${article.status==1?"checked":"" }> <label class="form-check-label"
					for="status1"> 已审 </label>
			</div>
			<div class="form-check">
				<input class="form-check-input" type="radio" name="status"
					id="status-1" value="-1" ${article.status==-1?"checked":"" }> <label class="form-check-label"
					for="status-1"> 驳回 </label>
			</div>
			<div>
				<button class="btn btn-info" type="button" onclick="query()">查询</button>
			</div>

		</div>
		<div class="mt-1">
			<table class="table table-hover table-bordered text-center">
				<tr>
					<td>序号</td>
					<td>标题</td>
					<td>栏目</td>
					<td>分类</td>
					<td>作者</td>
					<td>发布时间</td>
					<td>审核状态</td>
					<td>是否热门</td>
					<td>查看</td>
				</tr>

				<c:forEach items="${info.list}" var="article" varStatus="i">
					<tr>
						<td>${i.count }</td>
						<td width="350px">${article.title }</td>
						<td>${article.channel.name }</td>
						<td>${article.category.name }</td>
						<td>${article.user.username }</td>
						<td><fmt:formatDate value="${article.created}"
								pattern="yyyy-MM-dd HH:mm:ss" /></td>
						<td>${article.status==0?"待审":article.status==1?"已审":"驳回"}</td>
						<td><c:if test="${article.hot==0}">
								<button class="btn btn-info btn-sm" type="button" onclick="update(${article.id},this)">否</button>
							</c:if> 
							<c:if test="${article.hot==1}">

								<button class="btn btn-danger btn-sm" type="button" onclick="update(${article.id},this)">是</button>
							</c:if></td>
							<td><button type="button" class="btn btn-link btn-sm" data-toggle="modal" onclick="detail(${article.id})" data-target="#exampleModalLong">
详情
</button></td>
					</tr>
				</c:forEach>
				<tr>
					<td colspan="10"><jsp:include
							page="/WEB-INF/view/common/pages.jsp"></jsp:include></td>
				</tr>
			</table>
		</div>
	</div>
	
	<!-- Modal -->
<div class="modal fade" id="exampleModalLong" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle"><span id="title1"></span></h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body" id="content">
      </div>
      <div class="modal-footer">
        <span id="msg"></span>
  
        <button type="button" class="btn btn-success" onclick="check(1)">通过</button>
         <button type="button" class="btn btn-danger" onclick="check(-1)">驳回</button>
               <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
      </div>
    </div>
  </div>
</div>
</body>
<script type="text/javascript">

//审核文章
function check(status){
	
	$.post("/admin/updateArticle",{id:articleId,status:status},function(flag){
		if(flag){
		  $("#msg").text("操作成功");	
		}else{
			 $("#msg").text("操作失败");	
		}
	})
	
	
}

var articleId;//文章id
//文章详情
function detail(id){
	//获取文章的id,赋值给全局变量 
	articleId =id;
	
	$("#title1").empty();
	$("#content").empty();
	
	$.get("/admin/article",{id:id},function(article){
	
		$("#title1").append(article.title);
		$("#content").append(article.content);
		
		
	})
}


//设置热门文章
function update(id,obj){
	// hot ： 0 ：否， 1：是
	var hot =$(obj).text()=='是'?0:1
	
	$.post("/admin/updateArticle",{id:id,hot:hot},function(flag){
		if(flag){//更新成功
			//1 改变按钮的内容
			$(obj).text($(obj).text()=='是'?'否':'是');
		//2改变按钮的演示
		   $(obj).attr("class",$(obj).text()=='是'?'btn btn-danger btn-sm':'btn btn-info btn-sm');
			
		}
	})
	
}


//条件查询
function query(){
	var title=$("[name='title']").val();
	var status=$("[name='status']:checked").val();
	$("#center").load("/admin/articles?title="+title+"&status="+status);
	
}

//分页
function goPage(pageNum){
	var title=$("[name='title']").val();
	var status=$("[name='status']:checked").val();
	$("#center").load("/admin/articles?pageNum="+pageNum+"&title="+title+"&status="+status);
}
</script>
</html>
