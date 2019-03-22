<%@page import="java.net.URLEncoder"%>
<%@page import="dao.ck"%>
<%@page import="entiy.people"%>
<%@page import="java.util.List"%>
<%@page import="entiy.menu"%>
<%@page import="dao.menudao"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	List<menu> cklist = new ck().getck();
	people p = (people) request.getSession().getAttribute("people");
	String name = p.getName();
	String ck = "1";
	menudao md = new menudao();
	if (request.getParameter("ck") != null) {
		ck = request.getParameter("ck");
	}
	List<menu> list = md.getallbywindow("窗口" + ck);
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
	function ct_display() {
		if ($("#window").is(":hidden")) {
			$("#window").show();
		} else {
			$("#window").hide();
		}
	}
	function people_display() {
		if ($("#peopleinfo").is(":hidden")) {
			$("#peopleinfo").show();
		} else {
			$("#peopleinfo").hide();
		}
	}
	function serach() {
		location.href = "serch.jsp?mealname="
				+ encodeURI(encodeURI($("#serchinput").val()) + "=" + "student");//传值解决中文乱码问题
	}
	function ck_display(ck) {
		location.href = "student.jsp?ck=" + ck;
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
<title>中软网上点餐系统</title>
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
							<a class="nav-link  active" onclick="ct_display()"> 餐厅入口 </a>
							<div id="collapseThree" class="panel-collapse collapse show">
								<div class="panel-body" style="display: none" id="window">

									<%
										for (int i = 0; i < cklist.size(); i++) {
									%>
									<a class="dropdown-item" onclick="ck_display('<%=(i + 1)%>')">窗口<%=i + 1%></a>

									<%
										}
									%>
								</div>
							</div>
						</div>
					</li>
				</ul>
				<li class="nav-item">
					<div id="accordion" class="panel-group">
						<a class="nav-link  active" href="myorder.jsp?name=<%=name%>">
							我的订单 </a>
					</div>
				</li>
				<li class="nav-item">
					<div id="accordion" class="panel-group">
						<a class="nav-link  active" onclick="people_display()"> 个人中心 </a>
						<div id="collapseThree" class="panel-collapse collapse show">
							<div class="panel-body" style="display: none" id="peopleinfo">
								<a class="dropdown-item" href="see_info.jsp?no=<%=p.getNo()%>">查看我的信息
								</a> <a class="dropdown-item"
									href="alert_info.jsp?no=<%=p.getNo()%>">修改我的信息 </a> <a
									class="dropdown-item" href="alert_pwd.jsp?no=<%=p.getNo()%>">修改登陆密码
								</a>
							</div>
						</div>
					</div>
				</li>
			</div>
			</nav>
		</div>
		<main role="main" class="col-md-9 ml-sm-auto col-lg-10 pt-3 px-4">
		<h2>欢迎点餐</h2>
		<form id="searchForm" class="form-inline clearfix" role="form">
			<div class="form-group item">
				<input type="text" placeholder="输入餐饮名字" class="form-control"
					id="serchinput">
			</div>
			<div class="form-group" style="margin-left: 10px;">
				<button id="searchBtn" type="button" class="btn btn-primary"
					onclick="serach()">搜索</button>
			</div>
		</form>
		<div class="table-responsive">
			<table class="table table-striped table-sm">
				<thead>
					<tr>
						<th>菜名</th>
						<th>价格</th>
						<th>点餐</th>
					</tr>
				</thead>
				<tbody>
					<%
						for (int i = 0; i < list.size(); i++) {
							menu m = list.get(i);
							String mname=URLEncoder.encode(m.getMealname(), "utf-8");//对汉字编码
					%>
					<tr>
						<th><a href="see_meal.jsp?mealname=<%=mname %>"><%=m.getMealname()%></a></th>
						<%
							String chk = new menudao().exist(m.getMealname(), name);
						%>
						<th>￥<%=m.getPrice()%></th>
						<th><input type="checkbox" id="checkbox<%=i%>"
							value="meal_xz" <%=chk%>
							onclick="xuanze('<%=name + "=" + m.getMealname() + "=" + "checkbox" + i + "=" + m.getPrice()%>')"></th>
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