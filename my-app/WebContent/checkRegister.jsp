<%@ page language="java" import="java.util.*,java.sql.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>验证注册</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
  </head>
  <body>
    <%      
            String user = new String(request.getParameter("username").getBytes("ISO-8859-1"),"UTF-8");  
            String pwd = request.getParameter("password");
            String driverClass = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
            String url = "jdbc:sqlserver://localhost:1433; DatabaseName = db_01";
            String username = "sa";
            String password = "sa";
            Class.forName(driverClass);//加载驱动 
            Connection conn = DriverManager.getConnection(url,username,password);//得到连接
            PreparedStatement pStmt = conn.prepareStatement("select * from tb_user where UName = '" + user + "'");
              ResultSet rs = pStmt.executeQuery();//产生交互获得结果集
                if(rs.next()){
                    out.println("<script language='javascript'>alert('该用户已存在，请重新注册！');window.location.href='register.jsp';</script>");
                }else{
                    PreparedStatement tmt = conn.prepareStatement("Insert into tb_user values('" + user + "','" + pwd + "')");
                        int rst = tmt.executeUpdate();
                        if (rst != 0){
                              out.println("<script language='javascript'>alert('用户注册成功！');window.location.href='http://localhost:8081/cunity/unity/list.action';</script>");  
                        }else{
                           out.println("<script language='javascript'>alert('用户注册失败！');window.location.href='register.jsp';</script>");  
                        }
                }
     %>
  </body>
</html>