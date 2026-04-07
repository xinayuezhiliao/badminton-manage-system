<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page language="java" import="java.sql.*" %>
<jsp:useBean id="connDbBean" scope="page" class="com.badminton.util.db"/>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>修改密码处理</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
  <%
  String username = (String)request.getSession().getAttribute("username");
  String cx = (String)request.getSession().getAttribute("cx");
  String oldpwd = request.getParameter("oldpwd");
  String newpwd = request.getParameter("newpwd");
  
  if(username == null || username.equals("")){
	  out.print("<script>alert('请先登录');window.parent.location.href='login.jsp';</script>");
	  return;
  }
  
  String sql = "";
  String tableName = "";
  
  // 根据用户类型选择不同的表
  if(cx != null && (cx.equals("超级管理员") || cx.equals("普通管理员"))){
	  tableName = "allusers";
	  sql = "select * from " + tableName + " where username='" + username + "' and pwd='" + oldpwd + "'";
  }else if(cx != null && cx.equals("会员")){
	  tableName = "huiyuanxinxi";
	  sql = "select * from " + tableName + " where huiyuanbianhao='" + username + "' and mima='" + oldpwd + "'";
  }else if(cx != null && cx.equals("注册用户")){
	  tableName = "yonghuzhuce";
	  sql = "select * from " + tableName + " where yonghuming='" + username + "' and mima='" + oldpwd + "'";
  }else{
	  // 默认为管理员
	  tableName = "allusers";
	  sql = "select * from " + tableName + " where username='" + username + "' and pwd='" + oldpwd + "'";
  }
  
  try{
	  ResultSet rs = connDbBean.executeQuery(sql);
	  if(!rs.next()){
		  out.print("<script>alert('原密码错误，请重新输入！');history.go(-1);</script>");
		  rs.close();
	  }else{
		  rs.close();
		  // 更新密码
		  String pwdField = "pwd";
		  String userField = "username";
		  if(cx != null && (cx.equals("会员") || cx.equals("注册用户"))){
			  pwdField = "mima";
		  }
		  if(cx != null && cx.equals("会员")){
			  userField = "huiyuanbianhao";
		  }else if(cx != null && cx.equals("注册用户")){
			  userField = "yonghuming";
		  }
		  
		  String updateSql = "update " + tableName + " set " + pwdField + "='" + newpwd + "' where " + userField + "='" + username + "'";
		  int result = connDbBean.hsgexecute(updateSql);
		  
		  if(result > 0){
			  out.print("<script>alert('密码修改成功');window.location.href='mod.jsp';</script>");
		  }else{
			  out.print("<script>alert('密码修改失败，请重试');history.go(-1);</script>");
		  }
	  }
  }catch(Exception e){
	  e.printStackTrace();
	  out.print("<script>alert('系统错误，请重试');history.go(-1);</script>");
  }
  %>
  </body>
</html>
