<%@page import="java.net.URLEncoder"%>
<%@page import="entiy.menu"%>
<%@page import="java.util.List"%>
<%@page import="dao.menudao"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	List<menu> list = new menudao().getallbillbymealname();
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
	function see_bill_byid() {
		var fs = $("#select").val();
		if (fs == "窗口") {
			location.href = "see_bill_bywindow.jsp";
		} else {
			location.href = "see_bill_bymealname.jsp";
		}
	}
</script>
<title>账单</title>
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
		<h2>账单</h2>
		<form id="searchForm" class="form-inline clearfix" role="form">
			<div class="form-group item">
				<select id="select" class="form-control">
					<option>窗口</option>
					<option>菜名</option>
				</select>
			</div>
			<div class="form-group" style="margin-left: 10px;">
				<button id="searchBtn" type="button" class="btn btn-primary"
					onclick="see_bill_byid()">查看</button>
			</div>
		</form>

		<div class="table-responsive">
			<table class="table table-striped table-sm">
				<thead>
					<tr>
						<th>菜名</th>
						<th>数量</th>
						<th>总收入</th>
					</tr>
				</thead>
				<tbody>
					<%
						for (int i = 0; i < list.size(); i++) {
							menu m = list.get(i);
							String mname=URLEncoder.encode(m.getMealname(), "utf-8");//对汉字编码
					%>
					<tr>
						<td><a href="see_meal.jsp?mealname=<%=mname %>"><%=m.getMealname()%></a></td>
						<td><%=m.getQuantity()%></td>
						<td>￥<%=m.getPrice()%></td>
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
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

</body>
</html>