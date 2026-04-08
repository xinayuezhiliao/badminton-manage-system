<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.badminton.entity.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>精准查询 - 管理员账号</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { 
            font-family: 'Microsoft YaHei', Arial, sans-serif; 
            background: #f5f6fa;
            min-height: 100vh;
        }
        
        /* 顶部标题栏 */
        .header {
            background: linear-gradient(135deg, #16a085 0%, #1abc9c 100%);
            color: white;
            padding: 25px 30px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .header h2 {
            font-size: 24px;
            font-weight: 600;
        }
        
        /* 主容器 */
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 30px 20px;
        }
        
        /* 搜索框区域 */
        .search-box {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 15px rgba(0,0,0,0.1);
            margin-bottom: 25px;
        }
        .search-form {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
            align-items: end;
        }
        .form-group {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }
        .form-group label {
            font-weight: 600;
            color: #2c3e50;
            font-size: 14px;
        }
        .search-input {
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 6px;
            font-size: 15px;
            transition: all 0.3s;
        }
        .search-input:focus {
            outline: none;
            border-color: #3498db;
            box-shadow: 0 0 0 3px rgba(52,152,219,0.1);
        }
        .search-select {
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 6px;
            font-size: 15px;
            background: white;
            cursor: pointer;
        }
        .search-btn {
            padding: 12px 35px;
            background: linear-gradient(135deg, #3498db, #2980b9);
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 15px;
            font-weight: 600;
            transition: all 0.3s;
            height: 48px;
        }
        .search-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(52,152,219,0.3);
        }
        .back-btn {
            padding: 12px 35px;
            background: #95a5a6;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            display: inline-block;
            font-size: 15px;
            font-weight: 600;
            transition: all 0.3s;
            height: 48px;
            line-height: 24px;
        }
        .back-btn:hover {
            background: #7f8c8d;
            transform: translateY(-2px);
        }
        
        /* 结果区域 */
        .result-box {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 15px rgba(0,0,0,0.1);
            overflow: hidden;
        }
        .result-header {
            background: linear-gradient(135deg, #3498db, #2980b9);
            color: white;
            padding: 20px 30px;
            font-size: 18px;
            font-weight: 600;
        }
        .result-info {
            padding: 20px 30px;
            background: #f8f9fa;
            border-bottom: 2px solid #e0e0e0;
            color: #555;
            font-size: 15px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        thead {
            background: linear-gradient(135deg, #ecf0f1, #bdc3c7);
        }
        th {
            padding: 18px 12px;
            text-align: center;
            font-weight: 600;
            color: #2c3e50;
            border-bottom: 2px solid #bdc3c7;
            font-size: 14px;
        }
        td {
            padding: 15px 12px;
            text-align: center;
            border-bottom: 1px solid #ecf0f1;
            color: #333;
            font-size: 14px;
        }
        tr:hover {
            background: #f8f9fa;
        }
        .action-btn {
            display: inline-block;
            padding: 8px 18px;
            margin: 0 5px;
            border-radius: 5px;
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            transition: all 0.3s;
        }
        .edit-btn {
            background: #16a085;
            color: white;
        }
        .edit-btn:hover {
            background: #1abc9c;
            transform: translateY(-2px);
        }
        .delete-btn {
            background: #e74c3c;
            color: white;
        }
        .delete-btn:hover {
            background: #c0392b;
            transform: translateY(-2px);
        }
        .empty-state {
            text-align: center;
            padding: 80px 20px;
            color: #95a5a6;
        }
        .empty-state .icon {
            font-size: 80px;
            margin-bottom: 20px;
        }
        .empty-state p {
            font-size: 18px;
            margin-bottom: 25px;
        }
    </style>
</head>
<body>
    <%
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
        
        // 获取搜索关键词
        String searchKeyUser = (String) request.getAttribute("searchKeyUser");
        String searchKeyCx = (String) request.getAttribute("searchKeyCx");
        if (searchKeyUser == null) searchKeyUser = "";
        if (searchKeyCx == null) searchKeyCx = "";
    %>
    
    <!-- 顶部标题 -->
    <div class="header">
        <h2>🔍 管理员账号精准查询</h2>
    </div>
    
    <div class="container">
        <!-- 搜索框 -->
        <div class="search-box">
            <form action="<%=basePath%>allusers?action=doSearch" method="post" class="search-form">
                <div class="form-group">
                    <label>账号：</label>
                    <input type="text" name="username" class="search-input" 
                           placeholder="请输入账号（如：admin）" 
                           value="<%=searchKeyUser%>" />
                </div>
                <div class="form-group">
                    <label>角色权限：</label>
                    <select name="cx" class="search-select">
                        <option value="">全部</option>
                        <option value="管理员" <%=searchKeyCx.equals("管理员") ? "selected" : ""%>>管理员</option>
                        <option value="普通会员" <%=searchKeyCx.equals("普通会员") ? "selected" : ""%>>普通会员</option>
                    </select>
                </div>
                <div style="display: flex; gap: 15px; grid-column: 1 / -1;">
                    <button type="submit" class="search-btn">🔍 查询</button>
                    <a href="<%=basePath%>allusers?action=list" class="back-btn">返回列表</a>
                </div>
            </form>
        </div>
        
        <!-- 结果展示 -->
        <div class="result-box">
            <%
                List<Allusers> userList = (List<Allusers>) request.getAttribute("allusersList");
                
                if (userList != null && !userList.isEmpty()) {
            %>
                <div class="result-header">
                    📋 查询结果
                </div>
                <div class="result-info">
                    🔍 搜索条件：
                    <% if (!searchKeyUser.isEmpty()) { %>
                        账号="<strong><%=searchKeyUser%></strong>"
                    <% } %>
                    <% if (!searchKeyCx.isEmpty()) { %>
                        <%=searchKeyUser.isEmpty() ? "" : " & " %>角色权限="<strong><%=searchKeyCx%></strong>"
                    <% } %>
                    &nbsp;&nbsp;|&nbsp;&nbsp; 
                    📊 共找到 <strong style="color: #16a085;"><%=userList.size()%></strong> 条记录
                </div>
                <table>
                    <thead>
                        <tr>
                            <th width="8%">序号</th>
                            <th width="20%">账号</th>
                            <th width="25%">密码</th>
                            <th width="15%">权限</th>
                            <th width="22%">添加时间</th>
                            <th width="20%">操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            for (int j = 0; j < userList.size(); j++) {
                                Allusers u = userList.get(j);
                                if (u == null) continue;
                        %>
                        <tr>
                            <td><%=(j+1)%></td>
                            <td><%=u.getUsername() != null ? u.getUsername() : ""%></td>
                            <td><%=u.getPwd() != null ? u.getPwd() : ""%></td>
                            <td><%=u.getCx() != null ? u.getCx() : ""%></td>
                            <td><%=u.getAddtime() != null ? u.getAddtime() : ""%></td>
                            <td>
                                <% if (u.getId() != null) { %>
                                <a href="<%=basePath%>allusers?action=toUpdate&id=<%=u.getId()%>" 
                                   class="action-btn edit-btn">编辑</a>
                                <a href="<%=basePath%>allusers?action=delete&id=<%=u.getId()%>" 
                                   class="action-btn delete-btn" 
                                   onclick="return confirm('确定要删除吗？')">删除</a>
                                <% } %>
                            </td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            <%
                } else {
            %>
                <div class="empty-state">
                    <div class="icon">😕</div>
                    <p>未找到符合条件的管理员账号</p>
                    <p style="font-size: 15px; color: #7f8c8d;">请检查输入的账号或角色权限是否正确，或尝试其他关键词</p>
                </div>
            <%
                }
            %>
        </div>
    </div>
</body>
</html>
