<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.badminton.entity.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>我的订场记录</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { 
            font-family: 'Microsoft YaHei', Arial, sans-serif; 
            background: #f5f6fa;
            min-height: 100vh;
            padding-top: 60px; /* 🔥 留出顶部导航栏空间（60px） */
        }
        
        /* 顶部标题栏 */
        .header {
            background: linear-gradient(135deg, #16a085 0%, #1abc9c 100%);
            color: white;
            padding: 25px 30px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .header h2 {
            font-size: 24px;
            font-weight: 600;
        }
        .header-title {
            display: flex;
            align-items: center;
            gap: 20px;
        }
        
        /* 主容器 */
        .container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 30px 20px;
        }
        
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
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .header-actions {
            display: flex;
            gap: 15px;
        }
        .btn {
            padding: 10px 25px;
            border-radius: 6px;
            text-decoration: none;
            display: inline-block;
            font-size: 14px;
            font-weight: 600;
            transition: all 0.3s;
        }
        .btn-search {
            background: linear-gradient(135deg, #3498db, #2980b9);
            color: white;
        }
        .btn-search:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(52,152,219,0.3);
        }
        .btn-add {
            background: linear-gradient(135deg, #16a085, #1abc9c);
            color: white;
        }
        .btn-add:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(22,160,133,0.3);
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
        .detail-btn {
            display: inline-block;
            padding: 8px 20px;
            background: #3498db;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-size: 14px;
            font-weight: 500;
            transition: all 0.3s;
        }
        .detail-btn:hover {
            background: #2980b9;
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
        
        /* 响应式设计 */
        @media screen and (max-width: 768px) {
            body {
                padding-top: 60px !important; /* 🔥 手机端也要留出导航栏空间 */
            }
            .header {
                flex-direction: column;
                gap: 15px;
                padding: 20px;
            }
            .header-title {
                flex-direction: column;
                width: 100%;
            }
            .result-header {
                flex-direction: column;
                gap: 15px;
                padding: 20px;
            }
            .header-actions {
                width: 100%;
                justify-content: center;
            }
            .btn {
                width: auto;
                text-align: center;
            }
            table {
                font-size: 12px;
            }
            th, td {
                padding: 10px 8px;
            }
        }
    </style>
</head>
<body>
    <%
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
        
        // 获取当前登录会员的编号
        String huiyuanbianhao = (String) request.getSession().getAttribute("username");
        if (huiyuanbianhao == null) {
            response.sendRedirect("login.jsp");
            return;
        }
    %>
    
    <!-- 顶部标题 -->
    <div class="header">
        <div class="header-title">
            <h2>📋 我的订场记录</h2>
        </div>
    </div>
    
    <div class="container">
        <!-- 结果展示 -->
        <div class="result-box">
            <%
                List<Dingzhuoxinxi> recordList = (List<Dingzhuoxinxi>) request.getAttribute("list");
                
                if (recordList != null && !recordList.isEmpty()) {
            %>
                <div class="result-header">
                    <span>📊 共找到 <strong style="color: #fff;"><%=recordList.size()%></strong> 条订场记录</span>
                    <div class="header-actions">
                        <a href="<%=basePath%>dingzhuoxinxi?action=searchPage2" class="btn btn-search">🔍 精准查询</a>
                        <a href="<%=basePath%>qiuzhuoxinxi?action=listForMember" class="btn btn-add">➕ 预定场地</a>
                    </div>
                </div>
                <table>
                    <thead>
                        <tr>
                            <th width="8%">序号</th>
                            <th width="15%">场地号</th>
                            <th width="18%">每小时计费</th>
                            <th width="39%">订场时间</th>
                            <th width="20%">操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            for (int j = 0; j < recordList.size(); j++) {
                                Dingzhuoxinxi u = recordList.get(j);
                                if (u == null) continue;
                        %>
                        <tr>
                            <td><%=(j+1)%></td>
                            <td><%=u.getQiuzhuohao() != null ? u.getQiuzhuohao() : ""%></td>
                            <td><%=u.getMeixiaoshijifei() != null ? u.getMeixiaoshijifei() : ""%></td>
                            <td><%=u.getDingzhuoshijian() != null ? u.getDingzhuoshijian() : ""%></td>
                            <td>
                                <% if (u.getId() != null) { %>
                                <a href="<%=basePath%>dingzhuoxinxi?action=detail&id=<%=u.getId()%>" 
                                   class="detail-btn">查看详情</a>
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
                    <p>暂无订场记录</p>
                    <p style="font-size: 15px; color: #7f8c8d;">点击上方"预定场地"按钮开始您的第一次订场</p>
                </div>
            <%
                }
            %>
        </div>
    </div>
</body>
</html>
