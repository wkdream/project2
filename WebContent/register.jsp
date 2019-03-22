<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
	String error="";
    error = (String) request.getAttribute("error");
	if(error!=null){
%>
	<script type="text/javascript">
	alert("<%=error %>");
	</script>
<%	
	}
%>
<html>
<head>
<style type="text/css">
#beijing {
	background-image: URL(img/背景.jpg);
	background-size: 100%;
	background-repeat: no-repeat;
}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>注册页面</title>
</head>
<body id="beijing">
	<div align="center" >
	<h2 style="margin-left:60px">注册账号</h2>
	<form action="register" method="post">
	账&nbsp;&nbsp;&nbsp;&nbsp;号 &nbsp;&nbsp;&nbsp;<input type="text" name="no" placeholder="账号" style="width:200px;height:40px"/><br/><br/>
	密&nbsp;&nbsp;&nbsp;&nbsp;码 &nbsp;&nbsp;&nbsp;<input type="password" name="password" placeholder="密码"style="width:200px;height:40px"/><br/><br/>
	姓&nbsp;&nbsp;&nbsp;&nbsp;名 &nbsp;&nbsp;&nbsp;<input type="text" name="name" placeholder="姓名"style="width:200px;height:40px"/><br/><br/>
	身&nbsp;&nbsp;&nbsp;&nbsp;份 &nbsp;&nbsp;&nbsp;<select name="identity" style="width:200px;height:40px">
	<option>请选择身份</option>
	<option>学生</option>
	<option>餐厅人员</option>
	</select><br><br>
	联系方式&nbsp;<input type="text" name="phoneno" placeholder="联系方式"style="width:200px;height:40px"/><br/><br/>
	地&nbsp;&nbsp;&nbsp;&nbsp;址&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="location" placeholder="地址"style="width:200px;height:40px"/><br/><br/>
	 &nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" value="提交"> &nbsp;&nbsp;&nbsp;&nbsp;
	<input type="reset" value="重置"><br>
	</form>
	</div>
</body>
</html>