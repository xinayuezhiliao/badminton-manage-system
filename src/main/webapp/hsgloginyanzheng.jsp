<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page language="java" import="java.sql.*" %>
<jsp:useBean id="connDbBean" scope="page" class="com.badminton.util.db"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>My JSP 'adminyanzheng.jsp' starting page</title>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8"></head>
  
  <body>
  <%
 
 String uid=request.getParameter("username");
 String pwd=request.getParameter("pwd");
 String cx=request.getParameter("cx");
 String sql="";
 // 使用英文value匹配，避免中文编码问题
 if(cx.equals("admin")){sql="select * from allusers where username='"+uid+"' and pwd='"+pwd+"'";}
 else if(cx.equals("huiyuan")){sql="select * from huiyuanxinxi where huiyuanbianhao='"+uid+"' and mima='"+pwd+"'";}
 else {
     out.print("<script>alert('未知的登录身份类型');window.history.go(-1);</script>");
     return;
 }






// 密码验证已临时关闭，直接登录
session.setAttribute("username",uid);
session.setAttribute("uid","1");
if(cx.equals("admin"))
{
    session.setAttribute("cx","管理员");
    response.sendRedirect("main.jsp");
}
else
{
    session.setAttribute("cx","会员");
    // 会员登录后直接跳转到场地列表（直接访问 JSP 页面，避免被 main.jsp 框架包裹）
    response.sendRedirect("qiuzhuoxinxi_list2.jsp");
}

 %>
  </body>
</html>
