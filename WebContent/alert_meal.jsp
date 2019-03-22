<%@page import="entiy.people"%>
<%@page import="dao.ck"%>
<%@page import="entiy.menu"%>
<%@page import="java.util.List"%>
<%@page import="dao.menudao"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
	people p = (people) request.getSession().getAttribute("people");
	String pname = p.getName();
	List<menu> list = new menudao().getallbymealname(java.net.URLDecoder.decode(request.getParameter("mealname"), "UTF-8"));
	menu m = list.get(0);
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
		var s="<%=m.getWindow() %>";
		var ck=parseInt(s.substring(1).substring(1));
		if ($("#newmealname").val() == "") {
			alert("名字不能为空！");
		} else if ($("#newprice").val() == "") {
			alert("价格不能为空！");
		} else if ($("#newwindow").val() == "") {
			alert("联系方式不能为空！");
		}else if ($("#newtroduction").val() == "") {
			alert("介绍不能为空！");
		} else {
			$.ajax({
				type : "post",
				url : "xiugai",
				data : {
					"flag":"xiugaimeal",
					"oldmealname" :"<%=m.getMealname()%>", 
					"newmealname" : $("#newmealname").val(),
					"newprice" : $("#newprice").val(),
					"newwindow" : $("#newwindow").val(),
					"newtroduction" : $("#newtroduction").val()
				},
				success : function(msg) {
					if (msg == "alertsuccess") {
						location.href = "mealpeople.jsp?name=<%=pname %>&ck="+ck;
					} else {
						alert("网络异常，请稍后再试！");
					}
				}

			});
		}
	}
	function cz() {
		location.reload();
	}
</script>
<title>修改信息</title>
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
							<a class="nav-link  active" href="javascript:history.go(-1)">返回上一页</a></div>
					</li></ul>
			</div></nav>
		</div>
		</nav>
		<main role="main" class="col-md-9 ml-sm-auto col-lg-10 pt-3 px-4">
		<h2>修改信息</h2>
		<hr>
		<div class="form-group item"
			style="color: red; font-size: 20px; font-family: 微软雅黑，宋体">
			 菜名:<input type="text" id="newmealname"
				value=<%=m.getMealname()%> class="form-control"> 价格: <input type="text" id="newprice"
				value=<%=m.getPrice()%> class="form-control"> 
				窗口: <select id="newwindow" class="form-control">
				<%
					for (int i = 0; i < cklist.size(); i++) {
						menu ck1 = cklist.get(i);

						if (m.getWindow().equals(ck1.getWindow())) {
				%>
				<option selected="selected"><%=m.getWindow()%></option>
				<%
							continue;
						}
				%>
				<option><%=ck1.getWindow()%></option>
				<%
					}
				%>
			</select> 
				介绍:<input type="text" id="newtroduction"
				value=<%=m.getMealtroduction()%> class="form-control">
		</div>
		<div class="form-group" style="margin-left: 10px;">
			<button id="searchBtn" type="button" class="btn btn-primary"
				onclick="alert_meal_info()">提交</button>
			<button id="searchBtn" type="button" class="btn btn-primary"
				onclick="cz('<%=m.getMealname()%>')">重置</button>
		</div>
		</main>
	</div>
</body>
</html>