<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<title>用户登录</title>
	<link href="css/style2.css" rel="stylesheet" type="text/css" media="all"/>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<link href='http://fonts.useso.com/css?family=Roboto:500,900italic,900,400italic,100,700italic,300,700,500italic,100italic,300italic,400' rel='stylesheet' type='text/css'>
	<link href='http://fonts.useso.com/css?family=Droid+Serif:400,700,400italic,700italic' rel='stylesheet' type='text/css'>

  </head>

  <body>
  
  	<%  
    String flag = request.getParameter("errNo");  
    try{
         if(flag!=null)
            out.println("用户名不存在或密码错误");
    }catch(Exception e){
        e.printStackTrace();
    }
   %>

  <form action = "loginCh.jsp" method="post">
  <div class="login" >
	<h2></h2>
	<div class="login-top">
		<h1>登  录</h1>
		<form>
			<input type="text" name="name"  value = "请输入用户名"  onfocus = "if(this.value == '请输入用户名') this.value =''">
		    <input type="password" name="pwd" maxlength = "20" >
	    </form>
	    <div class="forgot">
	    	<a href="#">忘记密码</a>
	    	<input type="submit" name="submit" value="登录" >
	    </div>
	</div>
	<div class="login-bottom">
		<h3>新管理员在此 &nbsp;<a href="register.jsp">注册</a></h3>
	</div>
</div>	
  </form>
  
  </body>
</html>