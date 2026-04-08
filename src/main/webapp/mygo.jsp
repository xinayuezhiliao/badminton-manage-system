<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>My JSP 'adminyanzheng.jsp' starting page</title>
    

  <meta http-equiv="Content-Type" content="text/html; charset=utf-8"></head>
  
  <body>
  <%
String cx = (String)request.getSession().getAttribute("cx");
if (cx != null && cx.equals("huiyuan"))
{
	response.sendRedirect("left2.jsp");
}
else if (cx != null && (cx.equals("超级管理员") || cx.equals("普通管理员")))
{
	response.sendRedirect("left.jsp");
}
else
{
	// 默认跳转到管理员菜单
	response.sendRedirect("left2.jsp");
}
 %>
  </body>
</html>

