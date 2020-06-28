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
<link href="/resource/css/jquery/screen.css" rel="stylesheet">
<script type="text/javascript" src="/resource/js/jquery-3.2.1.js"></script>
<script type="text/javascript" src="/resource/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/resource/js/jquery.validate.js"></script>

</head>
<body>
	<div class="container">
		<span id="msg" class="bg-danger"></span>
		<form id="reg">

			<div class="form-group">
				<label for="username">用户名</label> <input id="username"
					class="form-control" type="text" name="username">
			</div>
			<div class="form-group">
				<label for="password">密码</label> <input class="form-control"
					type="password" name="password" id="password">
			</div>
			<div class="form-group">
				<label for="repassword">确认密码</label> <input class="form-control"
					type="password" name="repassword" id="repassword">
			</div>

			<div class="form-inline">
				<div class="form-group  form-check">
					<input type="radio" name="gender" class="form-check-input" id="man"
						value="1" checked="checked"> <label
						class="form-check-label" for="man"> 男</label>
				</div>
				<div class="form-group  form-check">
					<input type="radio" name="gender" class="form-check-input"
						id="women" value="0"> <label class="form-check-label"
						for="women"> 女</label>

				</div>
			</div>
			<div class="form-group">
				<button class="btn btn-info" type="submit">注册</button>
				<button class="btn btn-warning" type="reset">重置</button>
			</div>
		</form>
	</div>


</body>
<script type="text/javascript">
 //表单校验
$(function(){
	$("#reg").validate({
	 //1.表单校验规则	
	 rules:{
		 username:{
			 required:true,//用户名不能为空
			 rangelength:[5,10],//用户名的长度在5-10之间
		 },
		 password:{
			 required:true,//密码不能为空
			 rangelength:[6,10],//密码的长度在6-10之间
		 },
		 repassword:{
			 equalTo:"#password",//确认密码和第一次输入的密码一致
		 },
		 
	 },
	 //2不满足规则进行消息提示
	 messages:{
		 username:{
			 required:"用户名不能为空",
			 rangelength:"用户名的长度必须在5-10之间",
		 },
		 password:{
			 required:"密码不能为空",
			 rangelength:"密码的长度在6-10之间",
		 },
		 repassword:{
			 equalTo:"两次密码输入不一致",
		 }
	 },
	 submitHandler:function(){
		 $.post("/passport/reg",$("#reg").serialize(),function(result){
			 if(result.code==200){
				 //注册成功，跳转到登录页面
				 //1.改变modal标题
				 $("#title").text(result.msg);
				 //2.跳转到登录面
				$("#passport").load("/passport/login") ;
			 }else{
				 $("#msg").text(result.msg);
			 }
		 })
		 
	 }
		
	})
	
	
	
	
	
	
})

</script>
</html>
