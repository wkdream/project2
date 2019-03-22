<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	String error = "";
	error = (String) request.getAttribute("error");
	if (error != null) {
%>
<script type="text/javascript">
	
	alert("<%=error%>");
</script>
<%
	}
%>
<%
	String no="",password="";
	Cookie[] cook = request.getCookies();
	if (cook != null) {
		for (int i = 0; i < cook.length; i++) {
			if (cook[i].getName().equals("no")) {
				no = cook[i].getValue();
			}
			if (cook[i].getName().equals("password")) {
				password = cook[i].getValue();
			}
		}
	}


%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
<link href="asserts/css/bootstrap.min.css" rel="stylesheet">
<link href="asserts/css/dashboard.css" rel="stylesheet">
<style type="text/css">
@
-webkit-keyframes chartjs-render-animation {from { opacity:0.99
	
}

to {
	opacity: 1
}

}
@
keyframes chartjs-render-animation {from { opacity:0.99
	
}

to {
	opacity: 1
}

}
.chartjs-render-monitor {
	-webkit-animation: chartjs-render-animation 0.001s;
	animation: chartjs-render-animation 0.001s;
}
</style>
<title>登陆页面</title>
</head>
<body id="beijing">
	<div align="center" >
		<h2 style="margin-left:80px">中软订餐系统</h2>
		<br><br>
		<form action="login" method="post">
			账&nbsp;&nbsp;&nbsp;&nbsp;号 &nbsp;&nbsp;&nbsp;<input type="text"
				name="no" placeholder="请输入账号" style="width: 200px; height: 40px" value=<%=no %>><br />
			<br /> 密&nbsp;&nbsp;&nbsp;&nbsp;码 &nbsp;&nbsp;&nbsp;<input
				type="password" name="password" placeholder="请输入密码"
				style="width: 200px; height: 40px" value=<%=password %>><br />
			<br /> 身&nbsp;&nbsp;&nbsp;&nbsp;份 &nbsp;&nbsp;&nbsp;<select
				name="identity" style="width: 200px; height: 40px">
				<option>请选择身份</option>
				<option>学生</option>
				<option>餐厅人员</option>
			</select><br>
			<br>
			<input type="checkbox" value="记住密码" name="remember">记住密码 <br><br> &nbsp;&nbsp;&nbsp;&nbsp;<input
				type="submit" value="提交" > &nbsp;&nbsp;&nbsp;&nbsp; <input
				type="reset" value="重置" ><br>
		</form>
		<h6>
			还没有账号?<a href="register.jsp">点击注册</a>
		</h6>
	</div>
</body>
</html>