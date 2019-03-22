<%@page import="dao.peopledao"%>
<%@page import="entiy.people"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>'
<%
	List<people> list = new peopledao().getallbyno(request.getParameter("no"));
	people p = list.get(0);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<script src="jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
function zhuxiao() {
	var flag = "zhuxiao";
	if (confirm("退出该系统？")) {
		$.ajax({
			type : "post",
			url : "zhuxiao",
			data : {
				"flag" : flag
			},
			success : function(msg) {
				if (msg == "success") {
					location.href = "login.jsp";
				} else {
					alert("注销失败！请稍后再试！");
				}
			}
		});
	}
}
	function alert_info() {
		var newno="<%=p.getNo() %>";
		if ($("#password").val() == "") {
			alert("原密码不能为空！");
		} else if ($("#newpassword").val() == "") {
			alert("新密码不能为空！");
		} else if ($("#newpasswordagain").val() == "") {
			alert("重复新密码不能为空！");
		} else if ($("#newpassword").val() != $("#newpasswordagain").val()) {
			alert("两次新密码不一致！");
		}else {
			$.ajax({
				type : "post",
				url : "alertpwd",
				data : {
					"no" : newno,
					"password":$("#password").val(),
					"newpassword" : $("#newpassword").val(),
				},
				success : function(msg) {
					if (msg == "success") {
						alert("恭喜你！密码修改成功！");
						location.href = "login.jsp";
					} else if(msg=="error"){
						alert("原密码错误！请重新输入！");
					}else{
						alert("网络异常！请稍后再试");
					}
				}

			});
		}
	}
	function cz() {
		location.reload();
	}
</script>
<title>修改密码</title>
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
</head>

<body>
	<nav class="navbar navbar-dark sticky-top bg-dark flex-md-nowrap p-0">
	<a class="navbar-brand col-sm-3 col-md-2 mr-0" href="#"></a> <input
		class="form-control form-control-dark w-100" type="text"
		placeholder="Search" aria-label="Search">
	<ul class="navbar-nav px-3">
		<li class="nav-item text-nowrap"><a class="nav-link" onclick="zhuxiao()">注销</a></li>
	</ul>
	</nav>

	<div class="container-fluid">
		<div class="row">
			<nav class="col-md-2 d-none d-md-block bg-light sidebar">
			<div class="sidebar-sticky" style="margin-top: 50px">
				<ul class="nav flex-column">
					<li class="nav-item">
						<div id="accordion" class="panel-group">
							<a class="nav-link  active" href="javascript:history.go(-1)">返回上一页</a>
					</li>
			</div>
			</ul>
		</div>
		</nav>
		<main role="main" class="col-md-9 ml-sm-auto col-lg-10 pt-3 px-4">
		<h2>修改密码</h2>
		<hr>
		<div class="form-group item"
			style="color: red; font-size: 20px; font-family: 微软雅黑，宋体">
			账号:<div class="form-control"> <%=p.getNo() %></div>原密码:<input type="password" id="password"
				 class="form-control"> 新密码:<input type="password" id="newpassword"
				 class="form-control"> 重复新密码:<input type="password" id="newpasswordagain"
				 class="form-control"> 
		</div>
		<div class="form-group" style="margin-left: 10px;">
			<button id="searchBtn" type="button" class="btn btn-primary"
				onclick="alert_info()">提交</button>
			<button id="searchBtn" type="button" class="btn btn-primary"
				onclick="cz('<%=p.getNo()%>')">重置</button>
		</div>
		</main>
	</div>
</body>
</html>