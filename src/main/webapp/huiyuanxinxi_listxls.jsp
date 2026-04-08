<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page isELIgnored="false" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
<head>
    <base href="<%=basePath%>">
    <title>会员列表</title>
    <link rel="stylesheet" href="<%=basePath%>images/style.css">
</head>
<body>
<h2>会员管理</h2>
<a href="<%=basePath%>huiyuan_add.jsp">添加会员</a>
<table border="1" width="90%" align="center">
    <tr>
        <th>ID</th>
        <th>编号</th>
        <th>姓名</th>
        <th>电话</th>
        <th>类型</th>
        <th>状态</th>
        <th>操作</th>
    </tr>
    <c:forEach items="${list}" var="h">
        <tr>
            <td>${h.id}</td>
            <td>${h.bianhao}</td>
            <td>${h.name}</td>
            <td>${h.phone}</td>
            <td>${h.type}</td>
            <td>${h.zhuangtai}</td>
            <td>
                <a href="<%=basePath%>huiyuan/edit?id=${h.id}">修改</a>
                <a href="<%=basePath%>huiyuan/delete?id=${h.id}" onclick="return confirm('确定删除？')">删除</a>
            </td>
        </tr>
    </c:forEach>
</table>
</body>
</html>