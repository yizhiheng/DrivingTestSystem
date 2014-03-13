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

	//定义三个变量，分别记录用户名，用户ID和用户的错题库
	int userid = 0;
	String username = "";
	String errors = "";

	while (rs.next()) {
		username = rs.getString("name");
		userid = rs.getInt("id");
		errors = rs.getString("errors");
	}

	String type="";	//记录练习的种类
	int testNum = 0;
	//判断点的是那种类型的练习，来执行不同的SQL语句
	
	try {
		if (request.getParameter("type").equals("category")) {

			testNum = 1;
			if (request.getParameter("num").equals("1")) {
				type = "章节练习 - 道路交通安全法律法规";
				//按序取问题数据的SQL语句
				sql = "SELECT * FROM question WHERE category=1";
				rs = stmt.executeQuery(sql);
			} else if (request.getParameter("num").equals("2")) {
				type = "章节练习 - 道路交通信号";
				//按序取问题数据的SQL语句
				sql = "SELECT * FROM question WHERE category=2";
				rs = stmt.executeQuery(sql);
			} else if (request.getParameter("num").equals("3")) {
				type = "章节练习 - 文明驾驶知识";
				//按序取问题数据的SQL语句
				sql = "SELECT * FROM question WHERE category=3";
				rs = stmt.executeQuery(sql);
			} else if (request.getParameter("num").equals("4")) {
				type = "章节练习 - 驾驶操作知识";
				//按序取问题数据的SQL语句
				sql = "SELECT * FROM question WHERE category=4";
				rs = stmt.executeQuery(sql);
			} else {
				out.println("<script>window.location.href='errorpage.jsp'</script>");
			}

		} else if (request.getParameter("type").equals("order")) {
			testNum = 2;
			type = "顺序练习";
			//按序取问题数据的SQL语句
			sql = "SELECT * FROM question";
			rs = stmt.executeQuery(sql);
		} else if (request.getParameter("type").equals("random")) {
			testNum = 3;
			type = "随机练习";
			//随机取问题数据的SQL语句
			sql = "Select *From question Order By Rand(id)";
			rs = stmt.executeQuery(sql);
		} else {
			//跳转的错误页面
			out.println("<script>window.location.href='errorpage.jsp'</script>");
		}
	} catch (Exception e) {
		out.println("<script>window.location.href='errorpage.jsp'</script>");
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>驾照考试系统 - <%=type %></title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<script type="text/javascript" src="./js/jquery-2.0.3.min.js"></script>
<script type="text/javascript">
	var errors = ""; //error的记录变量
	
	$(document).ready(
	    function() {
	    	<%
	    		//给导航栏置active类
	    		if(testNum==1)out.print("$('#category').addClass('active');");
	    		if(testNum==2)out.print("$('#order').addClass('active');");
	    		if(testNum==3)out.print("$('#random').addClass('active');");
	    	 %>
	    	
	        //查看本题解释按钮被单击时的响应事件
	        $("input.explainButton").click(
	            function() {
	                var questionid = $(this).parent().find("input.questionId").attr("id");
	                $("#explain" + questionid).css("display", "block");
	            });
	        //添加错题本按钮被单击时的响应事件
	        $("input.addError").click(
	            function() {
	                var questionid = $(this).parent().find("input.questionId").attr("id");
	                var rightAnswer = $(this).parent().find("input.rightAnswer").attr("id");
	                var userid = $("#userid").attr("value");
	                addError(userid, questionid); //执行addError函数
	            });
	
	        //单选框被单击时的响应事件
	        $(":radio").click(
	            function() {
	                var questionid = $(this).parent().find("input.questionId").attr("id"); //id变量记录了此题目的id
	                var rightAnswer = $(this).parent().find("input.rightAnswer").attr("id"); //rightAnswer记录了正确的答案,例如optionA
	                if ($(this).attr("id") == rightAnswer) {
	                    $(this).parent().find("span.rightAnswer").css("display", "block");
	                    $(this).parent().find("span.wrongAnswer").css("display", "none");
	                } else {
	                    $(this).parent().find("span.wrongAnswer").css("display", "block");
	                    $(this).parent().find("span.rightAnswer").css("display", "none");
	                };
	
	            });
	    });
	
	// ajax初始化
	function addError(userid, questionid) {	
	    var xmlhttp;
	    if (window.XMLHttpRequest) { // code for IE7+, Firefox, Chrome, Opera, Safari
	        xmlhttp = new XMLHttpRequest();
	    } else { // code for IE6, IE5
	        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
	    }
	    xmlhttp.onreadystatechange = function() {
	        if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
	            $("#question" + questionid).find("input.addError").attr(
	                "disabled", "disabled"); //把此题目的加入错题本按钮设置为disabled
	            alert("加入错题本成功！");
	        }
	    }
	    xmlhttp.open("GET", "http://localhost:8080/DrivingTestSystem/servlet/AddError?userid=" + userid + "&questionid=" + questionid, true);
	    xmlhttp.send();
	}
	function logout(){
		if (confirm("确认要退出登录吗？")){
			window.location.href='index.jsp';
		}
	}
</script>
<link rel="shortcut icon" href="./img/logo.ico" type="image/icon" /> 
<link href="css/bootstrap.css" rel="stylesheet">

<!-- Add custom CSS here -->
<link href="css/practice.css" rel="stylesheet">
</head>


<body>
	<!-- 记录信息 -->
	<% 
		out.println("<input type='hidden' value='"+ userid+"' id='userid'/>");
	%>
	<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
	<div class="container">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse"
				data-target=".navbar-ex1-collapse">
				<span class="sr-only">Toggle navigation</span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="mainpage.jsp">驾照考试系统</a>
		</div>

		<!-- Collect the nav links, forms, and other content for toggling -->
		<div class="collapse navbar-collapse">
			<ul class="nav navbar-nav">
				<li class="dropdown" id="category"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown"> 章节练习 <b class="caret"></b> </a>
					<ul class="dropdown-menu">
						<li><a href="practice.jsp?type=category&num=1">道路交通安全法律法规</a>
						</li>
						<li><a href="practice.jsp?type=category&num=2">道路交通信号</a></li>
						<li><a href="practice.jsp?type=category&num=3">文明驾驶知识</a></li>
						<li><a href="practice.jsp?type=category&num=4">驾驶操作知识</a></li>
					</ul></li>
				<li id="order"><a href="practice.jsp?type=order">顺序练习</a></li>
				<li id="random"><a href="practice.jsp?type=random">随机练习</a></li>
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
	<!-- /.container --> </nav>

	<div class="container">

		<div class="row">

			<div class="col-md-3">
				<p class="lead"><% out.println(username);%>,欢迎登陆</p>
				<div class="list-group">
					<a href="#" class="list-group-item active">Printable</a> <a href="#" class="list-group-item">Cupcake Wrappers</a> <a href="#"
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
						<h4><%=type %></h4>
						<p>
							驾照考试系统是按照最新的驾照理论考试题库设计的集练习，错题复习，模拟考试功能为一体的系统。能帮助你快速准确地通过理论考试！</p>

					</div>
				</div>

				<div class="well">

					<div class="text-right">
						<a class="btn btn-success">Leave a Review</a>
					</div>

					<hr>
					<%

                    int questionId;
					String rightAnswer = "";

					int counter = 1; //题目循环计数变量
					while (rs.next()) {
						questionId = rs.getInt("id");
						rightAnswer = rs.getString("answer"); //rightAnswer后台变量记录了正确答案是哪个，例如optionA

						//题目的DIV
						out.println("<div id='question" + questionId + "' class='row question'>"); //Div id为question+id号
						out.println("<div class='col-md-12'>");
						out.println("<input name='' class='questionId' type='hidden' id='"
								+ questionId + "'/>"); //记录题目ID的标签		
						out.println("<input name='' class='rightAnswer' type='hidden' id='"
								+ rightAnswer + "'/>"); //记录题目正确答案的标签	

						out.println("<p>" + counter + "、" + rs.getString("subject")
								+ "</p>"); //题目
						counter++;
						
						//判断是否有图片，如果有的话添加图片
						if(rs.getString("pic")!=null){
							out.println("<img class='question-img img-responsive pull-right' src='queimg/"+rs.getString("pic")+"'>");
						}
						
						//四个选项
						if (rs.getString("optionA") != null) {
							out.println("<input type='radio' name='" + questionId + "' id='optionA'/>");
							out.println("<span class='options'>A." + rs.getString("optionA") + "</span>");
							out.println("<br>");
						}
						if (rs.getString("optionB") != null) {
							out.println("<input type='radio' name='" + questionId + "' id='optionB'/>");
							out.println("<span class='options'>B." + rs.getString("optionB") + "</span>");
							out.println("<br>");
						}
						if (rs.getString("optionC") != null) {
							out.println("<input type='radio' name='" + questionId + "' id='optionC'/>");
							out.println("<span class='options'>C." + rs.getString("optionC") + "</span>");
							out.println("<br>");
						}
						if (rs.getString("optionD") != null) {
							out.println("<input type='radio' name='" + questionId + "' id='optionD'/>");
							out.println("<span class='options'>D." + rs.getString("optionD") + "</span>");
							out.println("<br>");
						}
						out.println("<span class='rightAnswer'>回答正确</span>");
						out.println("<span class='wrongAnswer'>回答错误</span>");                     

            			//此处为显示解释的按钮，按钮类是explainButton，id是题目编号
						out.println("<input type='button' value='本题解释' class='explainButton btn btn-info' id='"+ questionId + "'/>");

            			//判断是否为错题，如果是错题的话加入错题本的按钮为disabled		
						if (errors.indexOf(questionId + "") >= 0) {
							out.println("<input type='button' value='加入错题本' class='addError btn btn-default' disabled='disabled' />");
						} else {
							out.println("<input type='button' value='加入错题本' class='addError btn btn-default' />");
						}

						//此处是解释的显示span标签，载入时不显示，类是explain，id是explain+questionId
						out.println("<span style='display:none' class='explain alert alert-info' id='explain"
								+ questionId
								+ "'>"
								+ rs.getString("explain")
								+ "</span>");
						out.println("</div>");
						out.println("</div>");
						out.println("<hr>");
						}
		            %>


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
	<script src="js/bootstrap.js"></script>



</body>
<%
	rs.close();
	conn.close();
%>

</html>

