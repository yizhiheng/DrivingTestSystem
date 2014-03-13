<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.mysql.jdbc.Driver"%>
<%@page import="java.sql.*"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	
	//判断是否登陆过期
	if(session.getAttribute("usersessionID") == null){
		out.println("<script>alert('登陆已过期，请重新登陆。');window.location.href='http://localhost:8080/DrivingTestSystem/';</script>");

	}
	
	String driverName = "com.mysql.jdbc.Driver"; //驱动名称
	String DBUser = "root"; //mysql用户名
	String DBPasswd = "123456"; //mysql密码
	String DBName = "driving_test_system"; //数据库名
	//数据库完整链接地址
	String connUrl = "jdbc:mysql://localhost/" + DBName + "?user="
			+ DBUser + "&password=" + DBPasswd;
	//加载数据库驱动
	Class.forName(driverName).newInstance();
	//链接数据库并保存到 conn 变量中
	Connection conn = DriverManager.getConnection(connUrl);
	//申明～？
	Statement stmt = conn.createStatement();
	//设置字符集
	stmt.executeQuery("SET NAMES UTF8");
	//取出基本信息
	String sql = "SELECT * FROM user WHERE id='"
			+ session.getAttribute("usersessionID") + "'";
	ResultSet rs = stmt.executeQuery(sql);

	String username = "";
	int userid;
	while (rs.next()) {
		username = rs.getString("name");
		userid = rs.getInt("id");
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'mainpage.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="shortcut icon" href="./img/logo.ico" type="image/icon" /> 
    <link href="css/bootstrap.css" rel="stylesheet">
    <!-- Add custom CSS here -->
    <link href="css/mypage.css" rel="stylesheet">

  </head>

<body>
	<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
	<div class="container">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse"
				data-target=".navbar-ex1-collapse">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="#home">驾照考试系统</a>
		</div>

		<!-- Collect the nav links, forms, and other content for toggling -->
		<div class="collapse navbar-collapse">
			<ul class="nav navbar-nav">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown"> 章节练习 <b class="caret"></b> </a>
					<ul class="dropdown-menu">
						<li><a href="practice.jsp?type=category&num=1">道路交通安全法律法规</a>
						</li>
						<li><a href="practice.jsp?type=category&num=2">道路交通信号</a></li>
						<li><a href="practice.jsp?type=category&num=3">文明驾驶知识</a></li>
						<li><a href="practice.jsp?type=category&num=4">驾驶操作知识</a></li>

					</ul>
				</li>
				<li><a href="practice.jsp?type=order">顺序练习</a></li>
				<li><a href="practice.jsp?type=random">随机练习</a></li>
				<li><a href="errorsPractice.jsp">错题练习</a></li>
				<li><a href="test.jsp">模拟考试</a></li>

			</ul>
			<ul class="nav navbar-nav navbar-right">
				<li><a href="mainpage.jsp">我的主页</a></li>
				<li><a href="javascript:void(0)" onclick="logout()">退出登录</a></li>

			</ul>
		</div>
		<!-- /.navbar-collapse -->
	</div>
	<!-- /.container --> 
	</nav>

	<div class="container">

		<div class="row">

			<div class="col-md-3">
				<p class="lead">
					<%out.println(username);%>,欢迎登陆
				</p>
				<div class="list-group">
					<a href="#" class="list-group-item active">Printable</a> <a
						href="#" class="list-group-item">Cupcake Wrappers</a> <a href="#"
						class="list-group-item">Authentic Dragon Bones</a>
				</div>
			</div>

			<div class="col-md-9">

				<div class="thumbnail">
					<img class="img-responsive" src="img/14.jpg" alt="">
					<div class="caption-full">

						<h3>
							<a href="#">驾照考试系统</a>
						</h3>
						<h4>欢迎登陆驾照考试系统，请在顶部导航栏中选择您需要的操作。</h4>
						<p>
							驾照考试系统是按照最新的驾照理论考试题库设计的集练习，错题复习，模拟考试功能为一体的系统。能帮助你快速准确地通过理论考试！</p>

					</div>
				</div>


			</div>

		</div>

	</div>
	<!-- /.container -->

	<div class="container">

		<hr>

		<footer>
		<div class="row">
			<div class="col-lg-12">
				<p>
				Copyright &copy; SouthWest Jiaotong University Zhiheng Yi. All Rights Reserved
				</p>
			</div>
		</div>
		</footer>

	</div>
	<!-- /.container -->

	<!-- JavaScript -->
	<script src="js/jquery-1.10.2.js"></script>
	<script src="js/bootstrap.js"></script>
	<script>
		function logout(){
			if (confirm("确认要退出登录吗？")){
				window.location.href='index.jsp';
			}
		}
	</script>
</body>
<%
	rs.close();
	conn.close();
%>
</html>
