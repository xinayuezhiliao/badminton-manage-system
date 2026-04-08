<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
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
    <title>会员信息查询 - 羽毛球球馆管理系统</title>
    <%-- <link rel="stylesheet" type="text/css" href="<%=basePath%>static/css/beautify.css" /> --%>
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
        
        .result-summary {
            background: linear-gradient(135deg, #e8f5e9 0%, #c8e6c9 100%);
            padding: 15px 20px;
            border-radius: 6px;
            margin-bottom: 15px;
            border-left: 4px solid #4caf50;
            color: #2e7d32;
            font-size: 14px;
        }
        
        .result-summary strong {
            font-size: 16px;
            margin: 0 5px;
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
        
        .search-item input[type="text"],
        .search-item select {
            width: 120px;
            height: 36px;
            padding: 0 10px;
            font-size: 13px;
            border: 1px solid #ddd;
            border-radius: 6px;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }
        
        .search-item input[type="text"]:focus,
        .search-item select:focus {
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
        @media screen and (max-width: 992px) {
            .search-form {
                flex-direction: column;
                align-items: stretch;
            }
            
            .search-item {
                width: 100%;
            }
            
            .search-item input[type="text"],
            .search-item select {
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
    <%
        // 获取查询参数（移到最前面）
        String searchHuiyuanbianhao = request.getParameter("huiyuanbianhao");
        String searchXingming = request.getParameter("xingming");
        String searchXingbie = request.getParameter("xingbie");
        String searchHuiyuandengji = request.getParameter("huiyuandengji");
        if (searchHuiyuanbianhao == null) searchHuiyuanbianhao = "";
        if (searchXingming == null) searchXingming = "";
        if (searchXingbie == null) searchXingbie = "";
        if (searchHuiyuandengji == null) searchHuiyuandengji = "";
    %>
    
    <div style="max-width: 1200px; margin: 0 auto; padding: 20px;">
        <!-- 标题 -->
        <div style="background: linear-gradient(135deg, #16a085 0%, #1abc9c 100%); color: white; padding: 20px; border-radius: 8px; margin-bottom: 20px;">
            <h2 style="margin: 0;">🏸 会员信息管理</h2>
        </div>
        
        <!-- 操作区域 -->
        <div style="background: white; padding: 20px; border-radius: 8px; box-shadow: 0 2px 12px rgba(0,0,0,0.1); margin-bottom: 20px;">
            <div style="display: flex; gap: 15px; flex-wrap: wrap; align-items: center;">
                <a href="<%=basePath%>huiyuanxinxi?action=searchPage" 
                   style="padding: 10px 30px; background: linear-gradient(135deg, #3498db, #2980b9); color: white; text-decoration: none; border-radius: 6px; display: inline-block; font-weight: 600; font-size: 15px;">🔍 精准查询</a>
                <a href="<%=basePath%>huiyuanxinxi_add.jsp" 
                   style="padding: 10px 30px; background: linear-gradient(135deg, #16a085, #1abc9c); color: white; text-decoration: none; border-radius: 6px; display: inline-block; font-weight: 600; font-size: 15px;">➕ 添加会员</a>
            </div>
        </div>
        
        <!-- 结果展示区域 -->
        <%
            // 判断是否有查询条件
            boolean hasSearch = !"".equals(searchHuiyuanbianhao) || !"".equals(searchXingming) 
                               || !"".equals(searchXingbie) || !"".equals(searchHuiyuandengji);
            
            // 获取数据列表
            java.util.List huiyuanList = (java.util.List) request.getAttribute("huiyuanxinxiList");
            
            // 调试信息
            System.out.println("===== JSP 页面调试 =====");
            System.out.println("huiyuanxinxiList: " + (huiyuanList != null ? "不为 null, 大小=" + huiyuanList.size() : "null"));
            System.out.println("hasSearch: " + hasSearch);
        %>
        
        <!-- 统计信息横幅 -->
        <% if (huiyuanList != null && !huiyuanList.isEmpty()) { %>
        <div style="background: linear-gradient(135deg, #e8f5e9 0%, #c8e6c9 100%); padding: 15px 20px; border-radius: 8px; margin-bottom: 20px; border-left: 4px solid #4caf50;">
            <strong style="font-size: 16px;">
                <%=hasSearch ? "🔍 查询结果：共找到 " : "📋 全部数据：共 "%><%=huiyuanList.size()%> 条记录
            </strong>
        </div>
        <% } %>
        
        <!-- 数据表格 -->
        <div style="background: white; border-radius: 8px; box-shadow: 0 2px 12px rgba(0,0,0,0.1); overflow: hidden;">
            <table style="width: 100%; border-collapse: collapse;">
            <thead>
                <tr style="background: linear-gradient(135deg, #16a085 0%, #1abc9c 100%); color: white;">
                    <th style="padding: 14px 10px;">序号</th>
                    <th style="padding: 14px 10px;">会员编号</th>
                    <th style="padding: 14px 10px;">姓名</th>
                    <th style="padding: 14px 10px;">性别</th>
                    <th style="padding: 14px 10px;">等级</th>
                    <th style="padding: 14px 10px;">余额</th>
                    <th style="padding: 14px 10px;">手机</th>
                    <th style="padding: 14px 10px;">操作</th>
                </tr>
            </thead>
            <tbody>
                <% if (huiyuanList != null && !huiyuanList.isEmpty()) {
                    for (int j = 0; j < huiyuanList.size(); j++) {
                        com.badminton.entity.Huiyuanxinxi u = 
                            (com.badminton.entity.Huiyuanxinxi) huiyuanList.get(j);
                        if (u == null) continue;
                %>
                <tr style="border-bottom: 1px solid #eee;">
                    <td style="padding: 12px 10px; text-align: center;"><%=(j+1)%></td>
                    <td style="padding: 12px 10px; text-align: center;"><%=u.getHuiyuanbianhao() != null ? u.getHuiyuanbianhao() : ""%></td>
                    <td style="padding: 12px 10px; text-align: center;"><%=u.getXingming() != null ? u.getXingming() : ""%></td>
                    <td style="padding: 12px 10px; text-align: center;"><%=u.getXingbie() != null ? u.getXingbie() : ""%></td>
                    <td style="padding: 12px 10px; text-align: center;"><%=u.getHuiyuandengji() != null ? u.getHuiyuandengji() : ""%></td>
                    <td style="padding: 12px 10px; text-align: center;"><%=u.getYue() != null ? u.getYue() : "0.00"%></td>
                    <td style="padding: 12px 10px; text-align: center;"><%=u.getShouji() != null ? u.getShouji() : ""%></td>
                    <td style="padding: 12px 10px; text-align: center;">
                        <% if (u.getId() != null) { %>
                        <a href="<%=basePath%>huiyuanxinxi?action=toUpdate&id=<%=u.getId()%>" 
                           style="display: inline-block; padding: 6px 16px; margin: 0 4px; background: #16a085; color: white; text-decoration: none; border-radius: 4px; font-size: 13px;">编辑</a>
                        <a href="<%=basePath%>huiyuanxinxi?action=delete&id=<%=u.getId()%>" 
                           style="display: inline-block; padding: 6px 16px; margin: 0 4px; background: #e74c3c; color: white; text-decoration: none; border-radius: 4px; font-size: 13px;" 
                           onclick="return confirm('确定要删除吗？')">删除</a>
                        <% } %>
                    </td>
                </tr>
                <%
                    }
                } else {
                %>
                <tr>
                    <td colspan="8" style="text-align: center; padding: 60px 20px; color: #999;">
                        <div style="font-size: 48px; margin-bottom: 20px;">😕</div>
                        <div style="font-size: 18px; font-weight: 500;">
                            <%=hasSearch ? "未找到符合条件的会员信息，请检查查询条件" : "暂无会员信息，请点击\"添加会员\"按钮新增"%>
                        </div>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</div>

</body>
</html>
