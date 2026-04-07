<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.badminton.entity.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>场地信息 - 会员端</title>
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

        /* 操作区域 */
        .action-bar {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 15px rgba(0,0,0,0.1);
            margin-bottom: 25px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .user-info {
            font-size: 16px;
            color: #2c3e50;
            font-weight: 600;
        }
        .user-info span {
            color: #16a085;
        }
        .action-buttons {
            display: flex;
            gap: 15px;
        }
        .btn {
            padding: 12px 30px;
            border-radius: 6px;
            text-decoration: none;
            display: inline-block;
            font-size: 15px;
            font-weight: 600;
            transition: all 0.3s;
            cursor: pointer;
            border: none;
        }
        .btn-search {
            background: linear-gradient(135deg, #3498db, #2980b9);
            color: white;
        }
        .btn-search:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(52,152,219,0.3);
        }
        .btn-back {
            background: #95a5a6;
            color: white;
        }
        .btn-back:hover {
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

        /* 场地卡片网格 */
        .court-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
            padding: 30px;
        }
        .court-card {
            background: white;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            overflow: hidden;
            transition: all 0.3s;
        }
        .court-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.15);
            border-color: #16a085;
        }
        .court-header {
            background: linear-gradient(135deg, #16a085, #1abc9c);
            color: white;
            padding: 15px 20px;
            font-size: 18px;
            font-weight: 600;
            text-align: center;
        }
        .court-body {
            padding: 20px;
        }
        .court-info {
            margin-bottom: 15px;
        }
        .court-info-label {
            font-weight: 600;
            color: #7f8c8d;
            font-size: 13px;
            margin-bottom: 5px;
        }
        .court-info-value {
            font-size: 16px;
            color: #2c3e50;
            font-weight: 500;
        }
        .status-badge {
            display: inline-block;
            padding: 6px 15px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 600;
        }
        .status-available {
            background: #d4edda;
            color: #155724;
        }
        .status-booked {
            background: #fff3cd;
            color: #856404;
        }
        .price-tag {
            font-size: 24px;
            color: #16a085;
            font-weight: 700;
        }
        .price-unit {
            font-size: 14px;
            color: #7f8c8d;
        }
        .court-actions {
            padding: 15px 20px;
            background: #f8f9fa;
            border-top: 1px solid #e0e0e0;
            display: flex;
            gap: 10px;
            justify-content: center;
        }
        .btn-book {
            flex: 1;
            padding: 10px 20px;
            background: linear-gradient(135deg, #16a085, #1abc9c);
            color: white;
            text-decoration: none;
            border-radius: 6px;
            text-align: center;
            font-weight: 600;
            transition: all 0.3s;
        }
        .btn-book:hover {
            transform: scale(1.05);
            box-shadow: 0 5px 15px rgba(22,160,133,0.3);
        }
        .btn-disabled {
            background: #bdc3c7;
            cursor: not-allowed;
            pointer-events: none;
        }
        .btn-detail {
            flex: 1;
            padding: 10px 20px;
            background: linear-gradient(135deg, #3498db, #2980b9);
            color: white;
            text-decoration: none;
            border-radius: 6px;
            text-align: center;
            font-weight: 600;
            transition: all 0.3s;
        }
        .btn-detail:hover {
            transform: scale(1.05);
            box-shadow: 0 5px 15px rgba(52,152,219,0.3);
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
            .action-bar {
                flex-direction: column;
                gap: 15px;
            }
            .action-buttons {
                width: 100%;
                flex-direction: column;
            }
            .btn {
                width: 100%;
                text-align: center;
            }
            .court-grid {
                grid-template-columns: 1fr;
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

        // 获取查询参数
        String searchKeyQiu = (String) request.getAttribute("searchKeyQiu");
        String searchKeyZhuangtai = (String) request.getAttribute("searchKeyZhuangtai");
        if (searchKeyQiu == null) searchKeyQiu = "";
        if (searchKeyZhuangtai == null) searchKeyZhuangtai = "";
    %>

    <!-- 顶部标题 -->
    <div class="header">
        <h2>🏟️ 场地信息</h2>
    </div>

    <div class="container">
        <!-- 操作区域 -->
        <div class="action-bar">
            <div class="user-info">
                👤 当前会员：<span><%=huiyuanbianhao%></span>
            </div>
            <div class="action-buttons">
                <a href="<%=basePath%>qiuzhuoxinxi?action=searchPage" class="btn btn-search">🔍 场地查询</a>
            </div>
        </div>

        <!-- 结果展示 -->
        <div class="result-box">
            <%
                List<Qiuzhuoxinxi> courtList = (List<Qiuzhuoxinxi>) request.getAttribute("list");

                if (courtList != null && !courtList.isEmpty()) {
            %>
                <div class="result-header">
                    📋 场地列表
                </div>
                <div class="result-info">
                    📊 共找到 <strong style="color: #16a085;"><%=courtList.size()%></strong> 个场地
                    <% if (!searchKeyQiu.isEmpty() || !searchKeyZhuangtai.isEmpty()) { %>
                        &nbsp;&nbsp;|&nbsp;&nbsp; 🔍 搜索条件：
                        <% if (!searchKeyQiu.isEmpty()) { %>
                            场地号="<strong><%=searchKeyQiu%></strong>"
                        <% } %>
                        <% if (!searchKeyZhuangtai.isEmpty()) { %>
                            <%=searchKeyQiu.isEmpty() ? "" : " & " %>状态="<strong><%=searchKeyZhuangtai%></strong>"
                        <% } %>
                    <% } %>
                </div>

                <!-- 场地卡片网格 -->
                <div class="court-grid">
                    <%
                        for (int j = 0; j < courtList.size(); j++) {
                            Qiuzhuoxinxi u = courtList.get(j);
                            if (u == null) continue;

                            boolean isAvailable = "空闲".equals(u.getZhuangtai());
                    %>
                    <div class="court-card">
                        <div class="court-header">
                            🏟️ <%=u.getQiuzhuohao() != null ? u.getQiuzhuohao() : "未知场地"%>
                        </div>
                        <div class="court-body">
                            <div class="court-info">
                                <div class="court-info-label">状态</div>
                                <div class="court-info-value">
                                    <% if (isAvailable) { %>
                                    <span class="status-badge status-available">🟢 空闲</span>
                                    <% } else { %>
                                    <span class="status-badge status-booked">🔴 已订</span>
                                    <% } %>
                                </div>
                            </div>

                            <div class="court-info">
                                <div class="court-info-label">计费标准</div>
                                <div class="court-info-value">
                                    <span class="price-tag">¥<%=u.getMeixiaoshijifei() != null ? u.getMeixiaoshijifei() : "0"%></span>
                                    <span class="price-unit">/小时</span>
                                </div>
                            </div>

                            <div class="court-info">
                                <div class="court-info-label">添加时间</div>
                                <div class="court-info-value"><%=u.getAddtime() != null ? u.getAddtime() : ""%></div>
                            </div>
                        </div>

                        <div class="court-actions">
                            <% if (isAvailable) { %>
                            <a href="<%=basePath%>dingzhuoxinxi?action=dingyueMember&id=<%=u.getId()%>"
                               class="btn btn-book">📝 预定场地</a>
                            <% } else { %>
                            <a href="javascript:void(0);" class="btn btn-book btn-disabled">❌ 已被预定</a>
                            <% } %>
                            <a href="<%=basePath%>qiuzhuoxinxi?action=detail&id=<%=u.getId()%>"
                               class="btn btn-detail">📖 查看详情</a>
                        </div>
                    </div>
                    <%
                        }
                    %>
                </div>
            <%
                } else {
            %>
                <div class="empty-state">
                    <div class="icon">😕</div>
                    <p>暂无场地信息</p>
                    <p style="font-size: 15px; color: #7f8c8d;">请稍后再来查看可用的场地</p>
                </div>
            <%
                }
            %>
        </div>
    </div>
</body>
</html>
