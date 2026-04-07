<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>跳转页面</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body>
<%
    // 获取当前登录的角色
    String cx = (String)request.getSession().getAttribute("cx");

    if (cx != null) {
        // 如果是会员 → 跳会员专属页面
        if (cx.equals("huiyuan")) {
            response.sendRedirect("member_welcome.jsp");
        }
        // 如果是管理员 → 跳管理员首页
        else if (cx.equals("超级管理员") || cx.equals("普通管理员") || cx.equals("admin")) {
            response.sendRedirect("sy.jsp");
        }
        // 其他情况 → 默认跳会员页
        else {
            response.sendRedirect("member_welcome.jsp");
        }
    } else {
        // 未登录 → 跳回登录页
        response.sendRedirect("login.jsp");
    }
%>
</body>
</html>