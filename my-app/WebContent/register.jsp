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
    <title>用户注册</title>
	<link href="css/style2.css" rel="stylesheet" type="text/css" media="all"/>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<link href='http://fonts.useso.com/css?family=Roboto:500,900italic,900,400italic,100,700italic,300,700,500italic,100italic,300italic,400' rel='stylesheet' type='text/css'>
	<link href='http://fonts.useso.com/css?family=Droid+Serif:400,700,400italic,700italic' rel='stylesheet' type='text/css'>
 </head>
    <script>
		function addCheck(){
			var username=document.getElementById("username").value;
			var password=document.getElementById("password").value;
			if(username==""){
				alert("用户名不能为空!");
				document.getElementById("username").focus();  
				return false;
                }
			if(password==""){
				alert("密码不能为空!");
				 document.getElementById("password").focus();
				 return false;
				 }
		}
		function validate(){
		    var flag = addCheck();
		    if(flag == false)
		        return false;
		    return true;
	    }
	</script>
  <body>
    <center>
	<form action = "checkRegister.jsp" method = "post" onsubmit = "return validate()">	
	  <div class="login" >
	<h2></h2>
	<div class="login-top">
		<h1>注  册</h1>
		<form>
			<input type="text" name="username" value="输入16个字符以内" maxlength = "16" onfocus = "if(this.value == '输入16个字符以内') this.value =''">
			<input type="text" name="password" value="输入20个字符以内" maxlength = "20" onfocus = "if(this.value == '输入20个字符以内') this.value =''">
	    </form>
	    <div class="forgot">
	    	<a href="#">忘记密码</a>
	    	<input type="submit" name="submit" value="注册" >
	    </div>
	</div>
	<div class="login-bottom">
		<h3>已有账号在此 &nbsp;<a href="login.jsp">登录</a></h3>
	</div>
</div>	
    </form>
    </center>
  </body>
</html>