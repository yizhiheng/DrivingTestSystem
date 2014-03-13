<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.mysql.jdbc.Driver"%>
<%@ page import="java.sql.*"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	if(session.getAttribute("usersessionID") != null){
		session.removeAttribute("usersessionID");
		session.invalidate(); 
	}

	//驱动程序名 
	String driverName = "com.mysql.jdbc.Driver";
	//数据库用户名 
	String userName = "root";
	//密码 
	String userPasswd = "123456";
	//数据库名 
	String dbName = "driving_test_system";
	//表名 
	String tableName = "user";
	//联结字符串 
	String url = "jdbc:mysql://localhost/" + dbName + "?user="
			+ userName + "&password=" + userPasswd;
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	Connection connection = DriverManager.getConnection(url);
	Statement stmt = connection.createStatement();
	String sql = "SELECT * FROM " + tableName;
	ResultSet rs = stmt.executeQuery(sql);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
<base href="<%=basePath%>">
<title>交规考试系统</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="shortcut icon" href="./img/logo.ico" type="image/icon" />
<!--
<link rel="stylesheet" type="text/css" href="styles.css">
-->
<!-- Bootstrap core CSS -->
<link href="css/bootstrap.css" rel="stylesheet">

<!-- Add custom CSS here -->
<link href="css/landing-page.css" rel="stylesheet">
<!-- Add jQuery library -->
<script type="text/javascript" src="./lib/jquery-1.10.1.min.js"></script>

<!-- Add mousewheel plugin (this is optional) -->
<script type="text/javascript"
	src="./lib/jquery.mousewheel-3.0.6.pack.js"></script>

<!-- Add fancyBox main JS and CSS files -->
<script type="text/javascript" src="./source/jquery.fancybox.js?v=2.1.5"></script>
<link rel="stylesheet" type="text/css"
	href="./source/jquery.fancybox.css?v=2.1.5" media="screen" />

<!-- Add Button helper (this is optional) -->
<link rel="stylesheet" type="text/css"
	href="./source/helpers/jquery.fancybox-buttons.css?v=1.0.5" />
<script type="text/javascript"
	src="./source/helpers/jquery.fancybox-buttons.js?v=1.0.5"></script>

<!-- Add Thumbnail helper (this is optional) -->
<link rel="stylesheet" type="text/css"
	href="./source/helpers/jquery.fancybox-thumbs.css?v=1.0.7" />
<script type="text/javascript"
	src="./source/helpers/jquery.fancybox-thumbs.js?v=1.0.7"></script>

<!-- Add Media helper (this is optional) -->
<script type="text/javascript"
	src="./source/helpers/jquery.fancybox-media.js?v=1.0.6"></script>
<script type="text/javascript">
	$(document).ready(function() {
	    $('.fancybox').fancybox();
	});
</script>
</head>

<body>
	<nav class="navbar navbar-default navbar-fixed-top" role="navigation">
	<div class="container">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse"
				data-target=".navbar-ex1-collapse">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="http://startbootstrap.com">驾照考试系统</a>
		</div>

		<!-- Collect the nav links, forms, and other content for toggling -->
		<div class="collapse navbar-collapse navbar-right navbar-ex1-collapse">
			<ul class="nav navbar-nav">
				<li><a href="#about">关于</a></li>
				<li><a href="#services">服务</a></li>
				<li><a href="#contact">联系我们</a></li>
			</ul>
		</div>
		<!-- /.navbar-collapse -->
	</div>
	<!-- /.container --> </nav>

	<div class="intro-header">

		<div class="container">

			<div class="row">
				<div class="col-lg-12">
					<div class="intro-message">
						<h1>驾照考试系统</h1>

						<hr class="intro-divider">
						<ul class="list-inline intro-social-buttons">
							<li><a href="#signin"
								class="btn btn-default btn-lg fancybox" title="登录"> <span
									class="network-name">登录</span> </a></li>
							<li><a href="#register"
								class="btn btn-default btn-lg fancybox" title="注册"> <span
									class="network-name">注册</span> </a></li>
						</ul>
					</div>
				</div>
			</div>

		</div>
		<!-- /.container -->
	</div>
	<!-- /.intro-header -->

	<div class="content-section-a">

		<div class="container">

			<div class="row">
				<div class="col-lg-5 col-sm-6">
					<hr class="section-heading-spacer">
					<div class="clearfix"></div>
					<h2 class="section-heading">驾照考试系统</h2>
					<p class="lead">驾校考试系统是一个为驾驶初学者，准备参加驾照考试的人群而设计的专业型培训网站。</p>
				</div>
				<div class="col-lg-5 col-lg-offset-2 col-sm-6">
					<img class="img-responsive" src="img/ipad.png" alt="">
				</div>
			</div>

		</div>
		<!-- /.container -->
	</div>
	<!-- /.content-section-a -->

	<div class="content-section-b">

		<div class="container">

			<div class="row">
				<div class="col-lg-5 col-lg-offset-1 col-sm-push-6  col-sm-6">
					<hr class="section-heading-spacer">
					<div class="clearfix"></div>
					<h2 class="section-heading">系统简介</h2>
					<p class="lead">
						本系统根据2014最新版驾照科目一考试题目建立，具有章节练习，顺序练习，随机练习，错题复习，用户练习数据统计等功能。让您能随时随地的练习驾照科目一考试的题目，助您更容易地通过考试！
					</p>
				</div>
				<div class="col-lg-5 col-sm-pull-6  col-sm-6">
					<img class="img-responsive" src="img/doge.png" alt="">
				</div>
			</div>

		</div>
		<!-- /.container -->
	</div>
	<!-- /.content-section-b -->

	<div class="content-section-a">

		<div class="container">

			<div class="row">
				<div class="col-lg-5 col-sm-6">
					<hr class="section-heading-spacer">
					<div class="clearfix"></div>
					<h2 class="section-heading">多平台支持</h2>
					<p class="lead">
						本系统UI基于HTML5，CSS3建立，采用响应式动态布局，使您不管是通过小分辨率的智能手机，中分辨率的平板电脑或者大分辨率的手提电脑和超大分辨率桌面计算机使用，都能有最佳的用户体验效果。让您能随时随地的练习。
					</p>
				</div>
				<div class="col-lg-5 col-lg-offset-2 col-sm-6">
					<img class="img-responsive" src="img/phones.png" alt="">
				</div>
			</div>

		</div>
		<!-- /.container -->
	</div>
	<!-- /.content-section-a -->

	<div class="banner">

		<div class="container">

			<div class="row">
				<div class="col-lg-6">
					<h2>开始使用驾照考试系统！</h2>
				</div>
				<div class="col-lg-6">
					<ul class="list-inline banner-social-buttons">
						<li><a href="https://twitter.com/SBootstrap"
							class="btn btn-default btn-lg"> <i
								class="fa fa-twitter fa-fw"></i> <span class="network-name">登陆</span>
						</a></li>
						<li><a
							href="https://github.com/IronSummitMedia/startbootstrap"
							class="btn btn-default btn-lg"> <i class="fa fa-github fa-fw"></i>
								<span class="network-name">现在注册</span> </a></li>
					</ul>
				</div>
			</div>

		</div>
		<!-- /.container -->
	</div>
	<!-- /.banner -->

	<!-- FancyBox -->
	<div id="signin">
		<form class="form-signin userform" method="post" action="index.jsp">
			<h2 class="form-signin-heading">请登录</h2>
			<input type="text" class="form-control" placeholder="Email address"
				required autofocus name="username"> <input type="password"
				class="form-control" placeholder="Password" required name="password">
			<label class="checkbox"> <input type="checkbox"
				value="remember-me">记住密码</label>
			<button class="btn btn-lg btn-primary btn-block" type="submit"
				name="submitform">登录</button>
			<button class="btn btn-lg btn-default btn-block" type="reset">重置</button>
		</form>
	</div>
	<div id="register">
		<form class="form-signin" role="form">
			<h2 class="form-signin-heading">请注册</h2>
			<input type="text" class="form-control" placeholder="Email address"
				required autofocus> <input type="password"
				class="form-control" placeholder="Password" required> <label
				class="checkbox"> <input type="checkbox" value="remember-me">Remember
				me</label>
			<button class="btn btn-lg btn-primary btn-block" type="submit">注册</button>
		</form>
	</div>

	<footer>
	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<ul class="list-inline">
					<li><a href="#home">首页</a></li>
					<li class="footer-menu-divider">&sdot;</li>
					<li><a href="#about">关于</a></li>
					<li class="footer-menu-divider">&sdot;</li>
					<li><a href="#services">服务</a></li>
					<li class="footer-menu-divider">&sdot;</li>
					<li><a href="#contact">联系我们</a></li>
				</ul>
				<p class="copyright text-muted small">Copyright &copy; SouthWest
					Jiaotong University Zhiheng Yi. All Rights Reserved</p>
			</div>
		</div>
	</div>
	</footer>

	<!-- JavaScript -->

	<script src="js/bootstrap.js"></script>
	<script src="js/jquery.fancybox.pack.js"></script>
</body>
<%
if (request.getParameter("submitform") != null) {
	String username = request.getParameter("username");
	sql = "SELECT * FROM user WHERE name=" + "'" + username + "'";
	rs = stmt.executeQuery(sql);
	while (rs.next()) {
		if (request.getParameter("password").equals(rs.getString("pwd"))) {
			//密码正确
			session.setAttribute("usersessionID",rs.getString("id"));
			out.println("<script>window.location.href='mainpage.jsp'</script>");
			
		} else {
			out.println("<Script>alert('密码错误')</script>");
		}
	}
}
%>
</html>
