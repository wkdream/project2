<%@page import="dao.ck"%>
<%@page import="entiy.menu"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	String ck = "窗口" + request.getParameter("ck");
	List<menu> cklist = new ck().getck();
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
	function alert_meal_info() {
		var v = $("#ck").val();
		var ck = parseInt(v.substring(1).substring(1));
		if ($("#newmealname").val() == "") {
			alert("名字不能为空！");
		} else if ($("#newprice").val() == "") {
			alert("价格不能为空！");
		} else if ($("#ck").val() == "") {
			alert("请选择一个窗口");
		} else if ($("#newtroduction").val() == "") {
			alert("介绍不能为空！");
		}else if ($("#file").val() == "") {
			alert("请选择图片！");
		}else {
			$.ajax({
				type : "post",
				url : "xiugai",
				data : {
					"flag" : "addmeal",
					"newmealname" : $("#newmealname").val(),
					"newfile" : $("#file").val(),
					"newprice" : $("#newprice").val(),
					"newwindow" : $("#ck").val(),
					"newtroduction" : $("#newtroduction").val()
				},
				success : function(msg) {
					if (msg == "addsuccess") {
						location.href = "mealpeople.jsp?ck=" + ck;
					} else {
						alert("该菜品已存在！请重新添加！");
						location.href = "addmeal.jsp?ck="+ck;
					}
				}

			});
		}
	}
	function cz() {
		location.reload();
	}
</script>
<title>addmeal</title>
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
		aria-label="Search">
	<ul class="navbar-nav px-3">
		<li class="nav-item text-nowrap"><a class="nav-link" href="#" onclick="zhuxiao()">注销
				</a></li>
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
						</div>
					</li>
				</ul>
			</div>
			</nav>
		</div>
		</nav>
		<main role="main" class="col-md-9 ml-sm-auto col-lg-10 pt-3 px-4">
		<h2>添加饭菜</h2>
		<hr>
		<div class="form-group item"
			style="color: red; font-size: 20px; font-family: 微软雅黑，宋体">
			名字:<input type="text" id="newmealname" class="form-control">
			价格: <input type="text" id="newprice" class="form-control">
			窗口: <select id="ck" class="form-control">
				<%
					for (int i = 0; i < cklist.size(); i++) {
						menu ck1 = cklist.get(i);

						if (ck.equals(ck1.getWindow())) {
				%>
				<option selected="selected"><%=ck%></option>
				<%
					continue;
						}
				%>
				<option><%=ck1.getWindow()%></option>
				<%
					}
				%>
			</select> 介绍:<input type="text" id="newtroduction" class="form-control">
			图片:<input type="file" id="file" class="form-control">
		</div>
		<div class="form-group" style="margin-left: 10px;">
			<button id="searchBtn" type="button" class="btn btn-primary"
				onclick="alert_meal_info()">提交</button>
			<button id="searchBtn" type="button" class="btn btn-primary"
				onclick="cz()">重置</button>
		</div>
		</main>
	</div>
</body>
</html>