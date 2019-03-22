<%@page import="java.net.URLEncoder"%>
<%@page import="dao.ck"%>
<%@page import="entiy.menu"%>
<%@page import="java.util.List"%>
<%@page import="dao.menudao"%>
<%@page import="entiy.people"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	List<menu> cklist =   new ck().getck();
	
	people p = (people) request.getSession().getAttribute("people");
	String name = p.getName();
	String ck = "1";
	menudao md = new menudao();
	if (request.getParameter("ck") != null) {
		ck = request.getParameter("ck");
	}
	List<menu> list = md.getallbywindow("窗口" + ck);
	int i=0;
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
	function ct_display() {
		if ($("#window").is(":hidden")) {
			$("#window").show();
		} else {
			$("#window").hide();
		}
	}
	function addmeal(ck) {
		location.href = "addmeal.jsp?ck="+ck;
	}
	function people_display() {
		if ($("#peopleinfo").is(":hidden")) {
			$("#peopleinfo").show();
		} else {
			$("#peopleinfo").hide();
		}
	}
	function serach() {
		location.href="serch.jsp?mealname="+encodeURI(encodeURI($("#serchinput").val())+"="+"meal");//传值解决中文乱码问题
	}
	function ck_display(ck) {
		location.href = "mealpeople.jsp?ck=" + ck;
	}
	function xiugai(s) {
		location.href="alert_meal.jsp?mealname="+encodeURI(encodeURI(s));
	}
	function delect_meal(s) {
		$.ajax({
			type : "post",
			url : "xiugai",
			data : {
				"flag":"delectmeal",
				"newmealname" : s
			},
			success : function(msg) {
				if (msg == "delectsuccess") {
					location.href = "mealpeople.jsp?name=<%=name %>&ck=<%=ck %>";
				}else {
					alert("网络异常，请稍后再试！");
				}
			}

		});
		
	}
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
							<a class="nav-link  active" onclick="ct_display()"> 餐厅入口 </a>
							<div id="collapseThree" class="panel-collapse collapse show">
								<div class="panel-body" style="display: none" id="window">

									<%
										for (i = 0; i < cklist.size(); i++) {
											menu ck_window=cklist.get(i);
									%>
									<a class="dropdown-item" id="<%=i+1 %>"  onclick="ck_display('<%=(i + 1)%>')" ><%=ck_window.getWindow()%></a>
									
									<%
										}
									%>
									
								</div>
							</div>
						</div>
					</li>
					<li class="nav-item">
						<div id="accordion" class="panel-group">
							<a class="nav-link  active" href="order.jsp">
								订单 </a>
						</div>
					</li>
					<li class="nav-item">
						<div id="accordion" class="panel-group">
							<a class="nav-link  active" onclick="people_display()"> 个人中心
							</a>
							<div id="collapseThree" class="panel-collapse collapse show">
								<div class="panel-body" style="display: none" id="peopleinfo">
									<a class="dropdown-item" href="see_info.jsp?no=<%=p.getNo()%>">查看我的信息
									</a> <a class="dropdown-item"
										href="alert_info.jsp?no=<%=p.getNo()%>">修改我的信息 </a>
										<a class="dropdown-item"
										href="see_bill_bywindow.jsp">查看账单 </a>
										<a class="dropdown-item"
										href="caozuock.jsp">窗口管理 </a> <a
										class="dropdown-item" href="alert_pwd.jsp?no=<%=p.getNo()%>">修改登陆密码
									</a>
								</div>
							</div>
						</div>
					</li>
			</div>
			</ul>
		</div>
		</nav>

		<main role="main" class="col-md-9 ml-sm-auto col-lg-10 pt-3 px-4">
		<h2>餐厅主页</h2>
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
						<th>操作</th>
					</tr>
				</thead>
				<tbody>
					<%
						for (int j = 0; j < list.size();j++) {
							menu m = list.get(j);
							String mname=URLEncoder.encode(m.getMealname(), "utf-8");//对汉字编码
					%>
					<tr>
						<th><a href="see_meal.jsp?mealname=<%=mname %>"><%=m.getMealname()%></a></th>
						<% 
							String chk = new menudao().exist(m.getMealname(), name);
						%>
						<th>￥<%=m.getPrice()%></th>
						<th>
							<a href="#" onclick="xiugai('<%=m.getMealname()%>')">修改</a>
							<a href="#" onclick="delect_meal('<%=m.getMealname()%>')">删除</a>
						</th>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
			<div class="form-group" style="margin-left: 10px;">
				<button id="searchBtn" type="button" onclick="addmeal('<%=ck %>')"class="btn btn-primary">添加饭菜</button>
			</div>
		</div>
		</main>
	</div>

</body>
</html>