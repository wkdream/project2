<%@page import="dao.peopledao"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="entiy.menu"%>
<%@page import="java.util.List"%>
<%@page import="dao.menudao"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	List<menu> list = new menudao().getall();
	int k = 0,q=0,n=0,totalprice=0;
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
	function wancheng(name) {
		$.ajax({
			type : "post",
			url : "order",
			data : {
				"check" : "wancheng",
				"peoplename":name
			},
			success : function(msg) {
				 if (msg == "success") {
					 location.href = "order.jsp";
				} else {
					alert("网络异常，请稍后再试！");
				}
			}

		});
	}
</script>
<title>订单</title>
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
		<h2>订单</h2>
		<div class="table-responsive">
			<table class="table table-sm" border="1">
				<thead>
					<tr>
						<th>订购者</th>
						<th>菜名</th>
						<th>数量</th>
						<th>价格</th>
						<th>总价</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody>
					<%
						for (int i = 0; i < list.size(); i++) {
							menu m = list.get(i);
							String name = m.getStuname();
							String no=new peopledao().getnobyname(name);
							String mname=URLEncoder.encode(m.getMealname(), "utf-8");//对汉字编码
							k = 1;
							for (int j = i + 1; j < list.size(); j++) {
								menu mu = list.get(j);
								if (name.equals(mu.getStuname())) {
									k++;
								}
							}
					%>
					<tr>
						<td rowspan="<%=k%>" valign="middle"><a href="see_info.jsp?no=<%=no %>"><%=name %></a></td>
						<td  valign="middle"><a href="see_meal.jsp?mealname=<%=mname %>"><%=m.getMealname()%></a></td>
						<td  valign="middle"><%=m.getQuantity()%></td>
						<td valign="middle">￥<%=m.getPrice()%></td>
					
						<td  valign="middle" rowspan="<%=k%>">￥<%=m.getStutotalprice() %></td>
						<td  valign="middle" rowspan="<%=k%>"><a onclick="wancheng('<%=name%>')">完成</a></td>
					</tr>	
						<%
								while (k > 0) {
								menu m1 = list.get(q);
								String m1name=URLEncoder.encode(m1.getMealname(), "utf-8");//对汉字编码
								if(m.getMealname().equals(m1.getMealname())){
									
								}else{
						%>
						<tr>
							<td  valign="middle"><a href="see_meal.jsp?mealname=<%=m1name %>"><%=m1.getMealname()%></a></td>
							<td  valign="middle"><%=m1.getQuantity()%></td>
							<td valign="middle">￥<%=m1.getPrice()%></td>
						</tr>
						<%
								}
								q++;
								k--;
							}
							i=q-1;
						}
						%>
					
				</tbody>
			</table>
		</div>
		</main>
	</div>
</body>
</html>