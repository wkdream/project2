<%@page import="entiy.people"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="entiy.menu"%>
<%@page import="java.util.List"%>
<%@page import="dao.menudao"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	people p = (people) request.getSession().getAttribute("people");
	String name = p.getName();
	String s = java.net.URLDecoder.decode(request.getParameter("mealname"), "UTF-8");//解决中文乱码的接收方式
	String[] str = s.split("=");
	String mealname = "", flag = "";
	for (int i = 0; i < str.length; i++) {
		mealname = str[0];
		flag = str[1];
	}
	menudao md = new menudao();
	List<menu> list = md.getallbymealname(mealname);
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
	function xuanze(s) {
		var check = "";
		var mealname = "";
		var peoplename = "";
		str = s.split("=");
		var mydate = new Date();
		var time = (1900 + mydate.getYear()) + "年" + (1 + mydate.getMonth())
				+ "月" + mydate.getDate() + "日" + mydate.getHours() + "时"
				+ mydate.getMinutes() + "分" + mydate.getSeconds() + "秒";
		for (var i = 0; i < str.length; i++) {
			peoplename = str[0];
			mealname = str[1];
			check = str[2];
			price = str[3];
		}
		if ($("#" + check).is(":checked")) {
			check = "xz";
		} else {
			check = "not";
		}
		$.ajax({
			type : "post",
			url : "order",
			data : {
				"check" : check,
				"mealname" : mealname,
				"peoplename" : peoplename,
				"price" : price,
				"time" : time
			},
			success : function(msg) {
				if (msg == "insertsuccess") {
					alert("已选择！");
				} else if (msg == "delectsuccess") {
					alert("已取消！");
				} else {
					alert("网络异常，请稍后再试！");
				}
			}

		});
	}
</script>
<title>搜索界面</title>
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
		<li class="nav-item text-nowrap"><a class="nav-link"
			onclick="zhuxiao()">注销</a></li>
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
		<h2>搜索结果</h2>
		<div class="table-responsive">
			<table class="table table-striped table-sm">
				<thead>
					<tr>
						<th>菜名</th>
						<th>价格</th>
						<%
							if (flag.equals("student")) {
						%>
						<th>点餐</th>
						<%
							} else {
						%>
						<th>操作</th>
						<%
							}
						%>
					</tr>
				</thead>
				<tbody>
					<%
						for (int i = 0; i < list.size(); i++) {
							menu m = list.get(i);
							String mname = URLEncoder.encode(m.getMealname(), "utf-8");//对汉字编码
					%>
					<tr>
						<th><a href="see_meal.jsp?mealname=<%=mname%>"><%=m.getMealname()%></a></th>
						<th>￥<%=m.getPrice()%></th>
						<th>
							<%
								if (flag.equals("student")) {

								String chk = new menudao().exist(m.getMealname(), name);
							%> <input type="checkbox" id="checkbox<%=i%>" value="meal_xz"
							<%=chk%>
							onclick="xuanze('<%=name + "=" + m.getMealname() + "=" + "checkbox" + i + "=" + m.getPrice()%>')">
						</th>
						<%
							} else {
						%>

						<a href="alert_meal.jsp?mealname="+encodeURI(encodeURI(<%=m.getMealname()%>))>修改</a>
						<%
							}
						%>
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