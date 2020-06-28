<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String htmlData = request.getParameter("content1") != null ? request.getParameter("content1") : "";
%>
<!doctype html>
<html>
<head>
<meta charset="utf-8" />
<title>KindEditor JSP</title>
<link rel="stylesheet"
	href="/resource/kindeditor/themes/default/default.css" />
<link rel="stylesheet"
	href="/resource/kindeditor/plugins/code/prettify.css" />
<script charset="utf-8" src="/resource/kindeditor/kindeditor.js"></script>
<script charset="utf-8" src="/resource/kindeditor/lang/zh-CN.js"></script>
<script charset="utf-8"
	src="/resource/kindeditor/plugins/code/prettify.js"></script>
<script>
	KindEditor.ready(function(K) {
		window.editor1 = K.create('textarea[name="content1"]', {
			cssPath : '/resource/kindeditor/plugins/code/prettify.css',
			uploadJson : '/resource/kindeditor/jsp/upload_json.jsp',
			fileManagerJson : '/resource/kindeditor/jsp/file_manager_json.jsp',
			allowFileManager : true,
			afterCreate : function() {
				var self = this;
				K.ctrl(document, 13, function() {
					self.sync();
					document.forms['example'].submit();
				});
				K.ctrl(self.edit.doc, 13, function() {
					self.sync();
					document.forms['example'].submit();
				});
			}
		});
		prettyPrint();
	});
</script>
</head>
<body>

	<form id="form1">
		<div class="form-group">
			<label for="title"> 文章标题：</label>
			 <input id="title" 	class="form-control" type="text" name="title">
		</div>
		<div class="form-group">
			<label for="title"> 微信号：</label>
			 <input id="title" 	class="form-control" type="text" name="num">
		</div>
		<div class="form-group">
			<label for="picture"> 标题图片：</label>
			 <input id="picture" 	class="form-control-file" type="file" name="file">
		</div>
		<div class="form-group form-inline">
			<label for="channel">栏目</label> <select
				class="form-control" id="channel" name="channelId">
				<option>请选择</option>
			</select>
			
			<label for="category">分类</label> <select
				class="form-control" id="category" name="categoryId">
				<option>请选择</option>
			</select>
		</div>
		<textarea name="content1" cols="100" rows="8"
			style="width: 1102.16px; height: 200px; visibility: hidden;"><%=htmlspecialchars(htmlData)%></textarea>
		<br /> <input type="button" name="button" onclick="publish()" class="btn btn-info" value="发布" />
	</form>
</body>

<script type="text/javascript">
//发布文章
function publish(){
	var formData = new FormData($("#form1")[0]);
	formData.set("content",editor1.html());// 获取文本域中带html的内容，并封装到formData
	
   $.ajax({
		url : "/my/publish",
		type : 'POST',
		data : formData,
		// 告诉jQuery不要去处理发送的数据
		processData : false,
		// 告诉jQuery不要去设置Content-Type请求头
		contentType : false,
		success:function(flag){
			if(flag){
				alert("发布成功");
				location.href="/my";//回到主页面
			}else{
				alert("发布失败")
			}
		}
   })
}




 $(function(){
	 $.get("/my/channels",function(channels){
		 //遍历所有的栏目，动态追加option
		 for(var i in channels){
			 $("#channel").append("<option value='"+channels[i].id+"'>"+channels[i].name+"</option>");
		 }
		 
	 });
	 //为栏目添加点击事件
	 $("#channel").change(function(){
		 var channelId =$(this).val();//获取当前点击的栏目id
		 $("#category").empty();//先清空原有分类
		 $.get("/my/selectCategorysByChannelId",{channelId:channelId},function(categorys){
			 //遍历所有的分类，动态追加option
			 for(var i in categorys){
				 $("#category").append("<option value='"+categorys[i].id+"'>"+categorys[i].name+"</option>");
			 }
		 })
		 
	 })
	 
 })


</script>
</html>
<%!private String htmlspecialchars(String str) {
		str = str.replaceAll("&", "&amp;");
		str = str.replaceAll("<", "&lt;");
		str = str.replaceAll(">", "&gt;");
		str = str.replaceAll("\"", "&quot;");
		return str;
	}%>