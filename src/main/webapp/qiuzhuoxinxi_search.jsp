<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.badminton.entity.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>精准查询 - 场地信息</title>
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
            max-width: 1400px;
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
            display: flex;
            gap: 15px;
            align-items: center;
            flex-wrap: wrap;
        }
        .search-input {
            padding: 12px 18px;
            border: 2px solid #e0e0e0;
            border-radius: 6px;
            font-size: 15px;
            width: 300px;
            transition: all 0.3s;
        }
        .search-input:focus {
            outline: none;
            border-color: #3498db;
            box-shadow: 0 0 0 3px rgba(52,152,219,0.1);
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
            padding: 18px 15px;
            text-align: center;
            font-weight: 600;
            color: #2c3e50;
            border-bottom: 2px solid #bdc3c7;
        }
        td {
            padding: 15px;
            text-align: center;
            border-bottom: 1px solid #ecf0f1;
            color: #333;
        }
        tr:hover {
            background: #f8f9fa;
        }
        .status-badge {
            display: inline-block;
            padding: 6px 12px;
            border-radius: 4px;
            font-size: 13px;
            font-weight: 500;
        }
        .status-free {
            background: #d4edda;
            color: #155724;
        }
        .status-booked {
            background: #f8d7da;
            color: #721c24;
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
        String searchKey = (String) request.getAttribute("searchKey");
        if (searchKey == null) searchKey = "";
    %>
    
    <!-- 顶部标题 -->
    <div class="header">
        <h2>🔍 场地精准查询</h2>
    </div>
    
    <div class="container">
        <!-- 搜索框 -->
        <div class="search-box">
            <form action="<%=basePath%>qiuzhuoxinxi?action=doSearch" method="post" class="search-form">
                <input type="text" name="qiuzhuohao" class="search-input" 
                       placeholder="请输入场地号进行精准查找" 
                       value="<%=searchKey%>" />
                <button type="submit" class="search-btn">🔍 查询</button>
                <a href="<%=basePath%>qiuzhuoxinxi?action=list2" class="back-btn">返回场地列表</a>
            </form>
        </div>
        
        <!-- 结果展示 -->
        <div class="result-box">
            <%
                List<Qiuzhuoxinxi> courtList = (List<Qiuzhuoxinxi>) request.getAttribute("qiuzhuoxinxiList");
                
                if (courtList != null && !courtList.isEmpty()) {
            %>
                <div class="result-header">
                    📋 查询结果
                </div>
                <div class="result-info">
                    🔍 搜索关键词：<strong><%=searchKey%></strong> &nbsp;&nbsp;|&nbsp;&nbsp; 
                    📊 共找到 <strong style="color: #16a085;"><%=courtList.size()%></strong> 条记录
                </div>
                <table>
                    <thead>
                        <tr>
                            <th width="8%">序号</th>
                            <th width="20%">场地号</th>
                            <th width="15%">状态</th>
                            <th width="17%">每小时计费</th>
                            <th width="20%">备注</th>
                            <th width="20%">操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            for (int j = 0; j < courtList.size(); j++) {
                                Qiuzhuoxinxi u = courtList.get(j);
                                if (u == null) continue;
                        %>
                        <tr>
                            <td><%=(j+1)%></td>
                            <td><%=u.getQiuzhuohao() != null ? u.getQiuzhuohao() : ""%></td>
                            <td>
                                <% if ("空闲".equals(u.getZhuangtai())) { %>
                                    <span class="status-badge status-free">空闲</span>
                                <% } else if ("已订".equals(u.getZhuangtai())) { %>
                                    <span class="status-badge status-booked">已订</span>
                                <% } else { %>
                                    <%=u.getZhuangtai() != null ? u.getZhuangtai() : ""%>
                                <% } %>
                            </td>
                            <td><%=u.getMeixiaoshijifei() != null ? u.getMeixiaoshijifei() : ""%></td>
                            <td><%=u.getBeizhu() != null ? u.getBeizhu() : ""%></td>
                            <td>
                                <% if (u.getId() != null) { %>
                                <a href="<%=basePath%>qiuzhuoxinxi?action=toUpdate&id=<%=u.getId()%>" 
                                   class="action-btn edit-btn">编辑</a>
                                <a href="<%=basePath%>qiuzhuoxinxi?action=delete&id=<%=u.getId()%>" 
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
                    <p>未找到符合条件的场地信息</p>
                    <p style="font-size: 15px; color: #7f8c8d;">请检查输入的场地号是否正确，或尝试其他关键词</p>
                </div>
            <%
                }
            %>
        </div>
    </div>
</body>
</html>
