<%@ page language="java" import="java.util.*,java.sql.*,java.net.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>登陆验证</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache"> <!--请求或响应不能缓存-->
	<meta http-equiv="expires" content="0">     <!--网页到期时间-->

  </head>
  <body>
    <%      //接收用户名和密码  
            String user = new String(request.getParameter("name").getBytes("ISO-8859-1"),"UTF-8");  
            String pwd = request.getParameter("pwd");
            String driverClass = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
            String url = "jdbc:sqlserver://localhost:1433; DatabaseName = db_01";
            String username = "sa";
            String password = "sa";
            Class.forName(driverClass);//加载驱动 
            Connection conn = DriverManager.getConnection(url,username,password);//得到连接
            PreparedStatement pStmt = conn.prepareStatement("select * from tb_user where UName = '" + user + "' and Pwd = '" + pwd + "'");
              ResultSet rs = pStmt.executeQuery();
                if(rs.next()){
                    response.sendRedirect("http://localhost:8081/cunity/unity/list.action?username="+URLEncoder.encode(user)); //解决乱码 
                }else{
                    response.sendRedirect("login.jsp?errNo");//密码不对返回到登陆  
                }
     rs.close();
     pStmt.close();
     conn.close();
     %>
  </body>
</html>