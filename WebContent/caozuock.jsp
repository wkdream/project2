<%@page import="dao.ck"%>
<%@page import="entiy.menu"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	List<menu> cklist =   new ck().getck();
	
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
	function add() {
		var newck=$("#textinput").val();
		if(newck==""){
			alert("请输入窗口序号");
		}else{
			$.ajax({
				type : "post",
				url : "caozuock",
				data : {
					"flag" : "addck",
					"newck" : newck
				},
				success : function(msg) {
					 if (msg == "success") {
						location.href="caozuock.jsp"
					} else {
						alert("网络异常，请稍后再试！");
					}
				}

			});
		}
	}
	function delect(e) {
		if(e.button==0){//鼠标左键点击
			var id=e.target.id;//获取点击链接的id值
			var text=e.target.textContent;//获取点击链接的文本值
			$.ajax({
				type : "post",
				url : "caozuock",
				data : {
					"flag":"delete",
					"newck" : id
				},
				success : function(msg) {
					if (msg == "success") {
						alert("删除成功");
						location.href = "caozuock.jsp";
					}else {
						alert("网络异常，请稍后再试！");
					}
				}

			});
			
		}
		if(e.button == 1){
			alert("gunlun");
		}
	}
</script>
<title>窗口管理</title>
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
		<h2>窗口管理</h2>
		<form id="searchForm" class="form-inline clearfix" role="form">
			<div class="form-group item">
				添加窗口 <input type="text" placeholder="输入窗口序号，如：2" class="form-control"
					id="textinput">
			</div>
			<div class="form-group" style="margin-left: 10px;">
				<button id="searchBtn" type="button" class="btn btn-primary"
					onclick="add()">确定</button>
			</div>
		</form>
			<div class="table-responsive">
			<table class="table table-striped table-sm">
				<thead>
					<tr>
						<th>窗口</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody>
					<%
						for (int i = 0; i < cklist.size(); i++) {
							menu m = cklist.get(i);
					%>
					<tr>
						<td><%=m.getWindow() %></td>
						<td><a href="#" id="窗口<%=i+1 %>"
							onmousedown="delect(event)">删除</a>&nbsp;&nbsp;&nbsp;
						</td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
		</div>
		
		</main>
	</div>
</body>
</html>