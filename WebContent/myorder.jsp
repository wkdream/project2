<%@page import="java.net.URLEncoder"%>
<%@page import="entiy.menu"%>
<%@page import="java.util.List"%>
<%@page import="dao.menudao"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	menudao md = new menudao();
	int totalprice = 0;
	String stuname=request.getParameter("name");
	List<menu> list = md.getallbystuname(stuname);
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
function addone(s) {
	var mealname = "";
	var peoplename = "";
	var price="";
	var quantity="";
	str = s.split("=");
	var mydate = new Date();
	var time = (1900 + mydate.getYear()) + "年" + (1 + mydate.getMonth())
			+ "月" + mydate.getDate() + "日" + mydate.getHours() + "时"
			+ mydate.getMinutes() + "分" + mydate.getSeconds() + "秒";
	for (var i = 0; i < str.length; i++) {
		peoplename = str[0];
		mealname = str[1];
		price=str[2];
		quantity=str[3];
	}
	$.ajax({
		type : "post",
		url : "order",
		data : {
			"check" : "update",
			"caozuo": "add",
			"mealname" : mealname,
			"peoplename" : peoplename,
			"price":price,
			"quantity":quantity,
			"time" : time
			},
			success : function(msg) {
				if (msg == "success") {
					location.reload();
				}else {
					alert("网络异常，请稍后再试！");
				}
			}
		});
	}
function reduceone(s) {
	var mealname = "";
	var peoplename = "";
	var price="";
	var quantity="";
	str = s.split("=");
	var mydate = new Date();
	var time = (1900 + mydate.getYear()) + "年" + (1 + mydate.getMonth())
			+ "月" + mydate.getDate() + "日" + mydate.getHours() + "时"
			+ mydate.getMinutes() + "分" + mydate.getSeconds() + "秒";
	for (var i = 0; i < str.length; i++) {
		peoplename = str[0];
		mealname = str[1];
		price=str[2];
		quantity=str[3];
	}
	$.ajax({
		type : "post",
		url : "order",
		data : {
			"check" : "update",
			"caozuo": "reduce",
			"mealname" : mealname,
			"peoplename" : peoplename,
			"price":price,
			"quantity":quantity,
			"time" : time
			},
			success : function(msg) {
				if (msg == "success") {
					location.reload();
				}else {
					location.reload();;
				}
			}
		});
	}
	function delect(s) {
		var mealname = "";
		var peoplename = "";
		
		str = s.split("=");
		for (var i = 0; i < str.length; i++) {
			peoplename = str[0];
			mealname = str[1];
			
		}
		$.ajax({
			type : "post",
			url : "order",
			data : {
				"check" : "not",
				"mealname" : mealname,
				"peoplename" : peoplename,
			},
			success : function(msg) {
				 if (msg == "delectsuccess") {
					location.reload();
				} else {
					alert("网络异常，请稍后再试！");
				}
			}

		});
	}
	function queren(s) {
		$.ajax({
			type : "post",
			url : "order",
			data : {
				"check" : "queren",
				"peoplename" : "<%=stuname %>",
				"totalprice" : s
			},
			success : function(msg) {
				 if (msg == "success") {
					alert("订单已提交，请用心等待！");
				} else {
					alert("网络异常，请稍后再试！");
				}
			}

		});
	}
</script>
<title>我的订单</title>
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
		<h2>我的订单</h2>
		<div class="table-responsive">
			<table class="table table-striped table-sm">
				<thead>
					<tr>
						<th>菜名</th>
						<th>&nbsp;&nbsp;价格</th>
						<th>操作</th>
						<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;数量</th>
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
						<td>￥<%=m.getPrice()%></td>
						<td><a href="#"
							onclick="delect('<%=request.getParameter("name") + "=" + m.getMealname()%>')">取消</a>&nbsp;&nbsp;&nbsp;
						</td>
						<td>
							<button class="btn btn-primary" id="add"
								style="width: 30px; height: 32px"
								onclick="reduceone('<%=request.getParameter("name") + "=" + m.getMealname() + "=" + m.getPrice() + "="
						+ m.getQuantity()%>')"
								class="lnkAddAttn">-</button>&nbsp;&nbsp;&nbsp;<%=m.getQuantity()%>
							&nbsp;&nbsp;&nbsp;<button class="btn btn-primary" id="reduce"
								style="width: 30px; height: 32px"
								onclick="addone('<%=request.getParameter("name") + "=" + m.getMealname() + "=" + m.getPrice() + "="
						+ m.getQuantity()%>')"
								class="lnkAddAttn">+</button>
						</td>
					</tr>
					<%
						totalprice += Integer.parseInt(m.getPrice());

						}
					%>
				</tbody>
				<tr>
					<th>统计</th>
					<td>￥<%=totalprice%></td>
					<td></td>
				</tr>
			</table>
			<div class="form-group" style="margin-left: 10px;">
				<button id="searchBtn" type="button" onclick="queren('<%=totalprice %>')"class="btn btn-primary">确认订单并支付</button>
			</div>
		</div>
		</main>
	</div>
</body>
</html>