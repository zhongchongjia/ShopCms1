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
	<div class="container">
		<div class="form-group form-inline">
			<div class="form-group">
				<label for="username">用户名</label> <input class="form-control" id="username" type="text" name="username"
					value="${user.username}">
			</div>
			<div class="form-check ml-2">
				<input class="form-check-input" type="checkbox" name="locked"
					id="locked" value="1" ${user.locked==1?"checked":"" }> <label
					class="form-check-label" for="locked"> 禁用 </label>
					<button class="btn btn-info btn-sm ml-2" type="button" onclick="query()">查询 </button>
			</div>
		</div>
		<div>
			<table class="table table-hover table-bordered text-center">
				<tr>
					<td>用户名</td>
					<td>昵称</td>
					<td>生日</td>
					<td>性别</td>
					<td>注册时间</td>
					<td>状态</td>
				</tr>
				<c:forEach items="${info.list}" var="user">
					<tr>
						<td>${user.username }</td>
						<td>${user.nickname }</td>
						<td><fmt:formatDate value="${user.birthday }"
								pattern="yyyy-MM-dd" /></td>
						<td>${user.gender==0?"男":"女" }</td>
						<td><fmt:formatDate value="${user.created }"
								pattern="yyyy-MM-dd HH:mm:ss" /></td>
						<td><c:if test="${user.locked==0}">
								<button class="btn btn-success btn-sm" type="button" onclick="update(${user.id},this)">正常</button>

							</c:if> <c:if test="${user.locked==1}">
								<button class="btn btn-danger btn-sm"  type="button" onclick="update(${user.id},this)">禁用</button>

							</c:if></td>

					</tr>

				</c:forEach>
				<tr>
					<td colspan="10"><jsp:include
							page="/WEB-INF/view/common/pages.jsp"></jsp:include></td>
				</tr>
			</table>
		</div>
	</div>
</body>
<script type="text/javascript">


  //管理用户
  function update(id,obj){
	  
	  var  locked =$(obj).text()=='正常'?1:0;
	  
	  $.post("/admin/updateUser",{id:id,locked:locked},function(flag){
		  if(flag){
			  //1改变按钮内容
			  $(obj).text(locked==1?'禁用':'正常')
			  
			  //2改变按钮样式
			   $(obj).attr('class',locked==1?'btn btn-sm btn-warning':'btn btn-sm btn-success')
		  }
	  })
  }

   //查询
   function query(){
	   var username =$("[name='username']").val();
	   var locked =$("[name='locked']:checked").val();//是否禁用
	   
	   var url="/admin/users?username="+username;
       if(locked==1)//表示查询禁用
    	   url+="&locked="+locked
        $("#center").load(url);
	  
   }
	//分页
	function goPage(pageNum) {

		$("#center").load("/admin/users?pageNum=" + pageNum);
	}
</script>
</html>
