<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" import="java.sql.*" %>
<jsp:useBean id="connDbBean" scope="page" class="com.badminton.util.db"/>
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
    <title>订场信息查询 - 羽毛球球馆管理系统</title>
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
        
        .search-box {
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 12px rgba(0, 0, 0, 0.08);
            margin-bottom: 20px;
        }
        
        .search-form {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            align-items: center;
        }
        
        .search-item {
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .search-item label {
            font-weight: 500;
            color: #555;
            white-space: nowrap;
            font-size: 13px;
        }
        
        .search-item input[type="text"] {
            width: 130px;
            height: 36px;
            padding: 0 10px;
            font-size: 13px;
            border: 1px solid #ddd;
            border-radius: 6px;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }
        
        .search-item input[type="text"]:focus {
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
            padding: 14px 10px;
            text-align: center;
            font-weight: 600;
            font-size: 13px;
            white-space: nowrap;
        }
        
        .data-table td {
            padding: 12px 10px;
            text-align: center;
            border-bottom: 1px solid #eee;
            font-size: 13px;
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
            margin: 20px 0;
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
        @media screen and (max-width: 1200px) {
            .search-item input[type="text"] {
                width: 110px;
            }
        }
        
        @media screen and (max-width: 992px) {
            .search-form {
                flex-direction: column;
                align-items: stretch;
            }
            
            .search-item {
                width: 100%;
            }
            
            .search-item input[type="text"] {
                flex: 1;
                width: auto;
            }
            
            .table-container {
                overflow-x: auto;
            }
            
            .data-table {
                min-width: 900px;
            }
        }
        
        @media screen and (max-width: 768px) {
            body {
                padding: 15px;
            }
            
            .page-title {
                flex-direction: column;
                align-items: flex-start;
                gap: 10px;
            }
            
            .data-table th,
            .data-table td {
                padding: 10px 8px;
                font-size: 12px;
            }
        }
        
        @media screen and (max-width: 480px) {
            body {
                padding: 10px;
            }
            
            .page-title h2 {
                font-size: 18px;
            }
            
            .search-box {
                padding: 15px;
            }
            
            .action-btns a {
                padding: 4px 8px;
                font-size: 11px;
            }
        }
    </style>
</head>
<body>
    <div class="content-wrapper">
    <div class="page-title">
        <h2>📋 订场信息列表</h2>
        <a href="<%=basePath%>dingzhuoxinxi?action=searchPage" class="btn-search" style="background: linear-gradient(135deg, #3498db, #2980b9);">🔍 精准查询</a>
    </div>
    
    <div class="table-container">
        <table class="data-table">
            <thead>
                <tr>
                    <th width="50">序号</th>
                    <th>场地号</th>
                    <th>每小时计费</th>
                    <th>订场时间</th>
                    <th>会员编号</th>
                    <th>姓名</th>
                    <th>会员等级</th>
                    <th>折扣</th>
                    <th width="140">添加时间</th>
                    <th width="100">操作</th>
                </tr>
            </thead>
            <tbody>
                <% int i=0; %>
                <c:forEach items="${dingzhuoxinxiList}" var="u">
                    <% i++; %>
                    <tr>
                        <td><%=i%></td>
                        <td>${u.qiuzhuohao}</td>
                        <td>${u.meixiaoshijifei}</td>
                        <td>${u.addtime}</td>
                        <td>${u.huiyuanbianhao}</td>
                        <td>${u.xingming}</td>
                        <td>${u.huiyuandengji}</td>
                        <td>${u.zhekou}</td>
                        <td>${u.addtime}</td>
                        <td class="action-btns">
                            <a href="<%=basePath%>dingzhuoxinxi?action=toUpdate&id=${u.id}" class="btn-edit">编辑</a>
                            <a href="<%=basePath%>dingzhuoxinxi?action=delete&id=${u.id}" class="btn-delete" onclick="return confirm('确定要删除吗?')">删除</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
    
    <c:if test="${sessionScope.p==1}">
        <div class="pagination">
            <c:if test="${page.pageNo>1}">
                <a href="<%=basePath%>dingzhuoxinxi?action=list&page=1">首页</a>
                <a href="<%=basePath%>dingzhuoxinxi?action=list&page=${page.pageNo-1}">上一页</a>
            </c:if>
            <c:if test="${page.pageNo<page.totalPage}">
                <a href="<%=basePath%>dingzhuoxinxi?action=list&page=${page.pageNo+1}">下一页</a>
                <a href="<%=basePath%>dingzhuoxinxi?action=list&page=${page.totalPage}">末页</a>
            </c:if>
        </div>
    </c:if>
</body>
</html>