<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page isELIgnored="false" %>

<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>管理员账户查询 - 羽毛球球馆管理系统</title>
    <link rel="stylesheet" type="text/css" href="<%=basePath%>static/css/beautify.css" />
    <style>
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", "Microsoft YaHei", "微软雅黑", sans-serif;
            font-size: 14px;
            line-height: 1.6;
            color: #333;
            background-color: #f5f7fa;
            margin: 0;
            padding: 20px;
        }
        
        .page-title {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 2px solid #e9ecef;
        }
        
        .page-title h2 {
            font-size: 20px;
            font-weight: 600;
            color: #333;
            margin: 0;
            display: flex;
            align-items: center;
        }
        
        .page-title h2::before {
            content: "";
            display: inline-block;
            width: 4px;
            height: 20px;
            background: linear-gradient(135deg, #16a085 0%, #1abc9c 100%);
            margin-right: 10px;
            border-radius: 2px;
        }
        
        .btn-add {
            display: inline-block;
            padding: 8px 20px;
            font-size: 14px;
            font-weight: 500;
            color: #fff;
            background: linear-gradient(135deg, #16a085 0%, #1abc9c 100%);
            border: none;
            border-radius: 6px;
            text-decoration: none;
            transition: all 0.3s ease;
        }
        
        .btn-add:hover {
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(22, 160, 133, 0.3);
            text-decoration: none;
            color: #fff;
        }
        
        .search-box {
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 12px rgba(0, 0, 0, 0.08);
            margin-bottom: 20px;
        }
        
        .search-form {
            display: flex;
            align-items: center;
            gap: 15px;
            flex-wrap: wrap;
        }
        
        .search-form label {
            font-weight: 500;
            color: #555;
        }
        
        .search-form input[type="text"] {
            width: 200px;
            height: 38px;
            padding: 0 12px;
            font-size: 14px;
            border: 1px solid #ddd;
            border-radius: 6px;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }
        
        .search-form input[type="text"]:focus {
            outline: none;
            border-color: #16a085;
            box-shadow: 0 0 0 3px rgba(22, 160, 133, 0.15);
        }
        
        .btn-search {
            padding: 8px 20px;
            font-size: 14px;
            font-weight: 500;
            color: #fff;
            background: linear-gradient(135deg, #3498db 0%, #2980b9 100%);
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .btn-search:hover {
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(52, 152, 219, 0.3);
        }
        
        .table-container {
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 12px rgba(0, 0, 0, 0.08);
            overflow: hidden;
        }
        
        .data-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 14px;
        }
        
        .data-table thead {
            background: linear-gradient(135deg, #16a085 0%, #1abc9c 100%);
            color: #fff;
        }
        
        .data-table th {
            padding: 14px 12px;
            text-align: center;
            font-weight: 600;
            font-size: 14px;
        }
        
        .data-table td {
            padding: 12px;
            text-align: center;
            border-bottom: 1px solid #eee;
        }
        
        .data-table tbody tr {
            transition: background-color 0.2s ease;
        }
        
        .data-table tbody tr:nth-child(even) {
            background-color: #fafbfc;
        }
        
        .data-table tbody tr:hover {
            background-color: #f0f7f5;
        }
        
        .data-table tbody tr:last-child td {
            border-bottom: none;
        }
        
        .action-btns a {
            display: inline-block;
            padding: 5px 12px;
            margin: 0 3px;
            font-size: 12px;
            border-radius: 4px;
            text-decoration: none;
            transition: all 0.3s ease;
        }
        
        .btn-edit {
            color: #16a085;
            background: rgba(22, 160, 133, 0.1);
        }
        
        .btn-edit:hover {
            color: #fff;
            background: #16a085;
        }
        
        .btn-delete {
            color: #e74c3c;
            background: rgba(231, 76, 60, 0.1);
        }
        
        .btn-delete:hover {
            color: #fff;
            background: #e74c3c;
        }
        
        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 8px;
            margin: 25px 0;
            padding: 0;
            list-style: none;
        }
        
        .pagination a {
            display: inline-block;
            padding: 8px 14px;
            font-size: 14px;
            color: #555;
            background: #fff;
            border: 1px solid #ddd;
            border-radius: 6px;
            text-decoration: none;
            transition: all 0.3s ease;
        }
        
        .pagination a:hover {
            color: #16a085;
            border-color: #16a085;
        }
        
        /* 响应式设计 */
        @media screen and (max-width: 768px) {
            body {
                padding: 15px;
            }
            
            .page-title {
                flex-direction: column;
                align-items: flex-start;
                gap: 10px;
            }
            
            .search-form {
                flex-direction: column;
                align-items: stretch;
            }
            
            .search-form input[type="text"] {
                width: 100%;
            }
            
            .table-container {
                overflow-x: auto;
            }
            
            .data-table {
                min-width: 600px;
            }
            
            .data-table th,
            .data-table td {
                padding: 10px 8px;
                font-size: 13px;
            }
        }
        
        @media screen and (max-width: 480px) {
            body {
                padding: 10px;
            }
            
            .page-title h2 {
                font-size: 18px;
            }
            
            .data-table th,
            .data-table td {
                padding: 8px 6px;
                font-size: 12px;
            }
            
            .action-btns a {
                padding: 4px 8px;
                font-size: 11px;
            }
        }
    </style>
</head>
<body>
    <div class="page-title">
        <h2>👤 管理员账号列表</h2>
        <a href="allusers_add.jsp" class="btn-add">➕ 添加管理员</a>
    </div>
    
    <div style="margin-bottom: 15px;">
        <a href="<%=basePath%>allusers?action=searchPage" class="btn-add" style="background: linear-gradient(135deg, #3498db, #2980b9);">🔍 精准查询</a>
    </div>
    
    <div class="table-container">
        <table class="data-table">
            <thead>
                <tr>
                    <th width="60">序号</th>
                    <th>账号</th>
                    <th>密码</th>
                    <th>权限</th>
                    <th width="160">添加时间</th>
                    <th width="120">操作</th>
                </tr>
            </thead>
            <tbody>
                <% int i=0; %>
                <c:forEach items="${list}" var="u">
                    <% i++; %>
                    <tr>
                        <td><%=i%></td>
                        <td>${u.username}</td>
                        <td>${u.pwd}</td>
                        <td>${u.cx}</td>
                        <td>${u.addtime}</td>
                        <td class="action-btns">
                            <a href="allusers?action=toUpdate&id=${u.id}" class="btn-edit">编辑</a>
                            <a href="allusers?action=delete&id=${u.id}" class="btn-delete" onclick="return confirm('确定要删除吗?')">删除</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
    
    <c:if test="${sessionScope.p==1}">
        <div class="pagination">
            <c:if test="${page.pageNo>1}">
                <a href="allusers?action=list&page=1">首页</a>
                <a href="allusers?action=list&page=${page.pageNo-1}">上一页</a>
            </c:if>
            <c:if test="${page.pageNo<page.totalPage}">
                <a href="allusers?action=list&page=${page.pageNo+1}">下一页</a>
                <a href="allusers?action=list&page=${page.totalPage}">末页</a>
            </c:if>
        </div>
    </c:if>
</body>
</html>
