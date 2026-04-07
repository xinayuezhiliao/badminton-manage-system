<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page isELIgnored="false" %>

<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    java.util.Date date = new java.util.Date();
    java.text.SimpleDateFormat format = new java.text.SimpleDateFormat("yyyy-MM-dd", java.util.Locale.CHINA);
    String result = format.format(date);
%>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>首页 - 羽毛球球馆管理系统</title>
    <link rel="stylesheet" type="text/css" href="<%=basePath%>static/css/beautify.css" />
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        html, body {
            height: 100%;
            overflow-x: hidden;
        }
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Microsoft YaHei", sans-serif;
            font-size: 16px;
            line-height: 1.8;
            color: #333;
            background-color: #f5f7fa;
            margin: 0;
            padding: 0;
            padding-top: 60px !important;
        }

        .welcome-banner {
            background: linear-gradient(135deg, #16a085 0%, #1abc9c 100%);
            border-radius: 16px;
            padding: 40px;
            color: white;
            margin: 25px; /* 四边留边，不贴死 */
            box-shadow: 0 8px 20px rgba(22, 160, 133, 0.25);
            position: relative;
            overflow: hidden;
        }

        .welcome-banner::before {
            content: '';
            position: absolute;
            top: -50%;
            right: -10%;
            width: 300px;
            height: 300px;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 70%);
            border-radius: 50%;
            pointer-events: none;
        }

        .welcome-banner h1 {
            font-size: 28px;
            margin-bottom: 15px;
            font-weight: 600;
            text-shadow: 0 2px 4px rgba(0,0,0,0.2);
            position: relative;
            z-index: 1;
        }
        .welcome-banner p {
            font-size: 16px;
            opacity: 0.95;
            text-shadow: 0 1px 2px rgba(0,0,0,0.2);
            position: relative;
            z-index: 1;
        }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 25px;
            margin: 0 25px 25px 25px;
            animation: fadeInUp 0.6s ease-out;
        }

        .info-card {
            background: white;
            border-radius: 12px;
            padding: 25px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
            border: 1px solid rgba(22, 160, 133, 0.1);
        }

        .info-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.15);
        }
        .info-card h3 {
            font-size: 20px;
            color: #16a085;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 2px solid #e9ecef;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .info-item {
            display: flex;
            justify-content: space-between;
            padding: 15px 0;
            border-bottom: 1px solid #f0f0f0;
            font-size: 16px;
        }
        .info-item:last-child {
            border-bottom: none;
        }
        .info-label {
            color: #666;
            font-weight: 500;
        }
        .info-value {
            color: #333;
            font-weight: 600;
        }
        .status-badge {
            display: inline-block;
            padding: 6px 16px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 500;
        }
        .status-online {
            background: #d4edda;
            color: #155724;
        }

        .team-info {
            background: white;
            border-radius: 12px;
            padding: 25px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            margin: 0 25px 25px 25px;
            animation: fadeInUp 0.6s ease-out 0.2s both;
            border: 1px solid rgba(22, 160, 133, 0.1);
        }

        .team-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }

        .team-item {
            text-align: center;
            padding: 20px;
            background: #f8f9fa;
            border-radius: 10px;
            transition: all 0.3s ease;
        }

        .team-item:hover {
            background: linear-gradient(135deg, #e8f5e9 0%, #f1f8e9 100%);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(22, 160, 133, 0.15);
        }
        .team-item .label {
            font-size: 14px;
            color: #666;
            margin-bottom: 8px;
        }
        .team-item .value {
            font-size: 18px;
            font-weight: 600;
            color: #333;
        }

        @media screen and (max-width: 768px) {
            body {
                padding-top: 60px !important;
            }
            .welcome-banner {
                padding: 30px;
                border-radius: 12px;
                margin: 15px;
            }
            .welcome-banner h1 {
                font-size: 22px;
            }
            .info-grid {
                grid-template-columns: 1fr;
                margin: 0 15px 15px 15px;
            }
            .info-card, .team-info {
                padding: 20px;
            }
            .team-info {
                margin: 0 15px 15px 15px;
            }
            .team-grid {
                grid-template-columns: 1fr;
            }
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
    </style>
</head>
<body>

<div class="welcome-banner">
    <h1>🏸 欢迎使用羽毛球球馆管理系统</h1>
    <p>高效管理场地预订、会员信息、收费记录，让球馆运营更轻松</p>
</div>

<div class="info-grid">
    <div class="info-card">
        <h3>👤 用户信息</h3>
        <div class="info-item">
            <span class="info-label">当前用户</span>
            <span class="info-value"><%=request.getSession().getAttribute("username")%></span>
        </div>
        <div class="info-item">
            <span class="info-label">用户权限</span>
            <span class="status-badge status-online"><%=request.getSession().getAttribute("cx")%></span>
        </div>
        <div class="info-item">
            <span class="info-label">登录IP</span>
            <span class="info-value"><%=request.getRemoteAddr()%></span>
        </div>
    </div>

    <div class="info-card">
        <h3>🖥️ 系统信息</h3>
        <div class="info-item">
            <span class="info-label">当前日期</span>
            <span class="info-value"><%=result%></span>
        </div>
        <div class="info-item">
            <span class="info-label">服务器端口</span>
            <span class="info-value"><%=request.getServerPort()%></span>
        </div>
        <div class="info-item">
            <span class="info-label">操作系统</span>
            <span class="info-value"><%=System.getProperty("os.name")%></span>
        </div>
    </div>
</div>

<div class="team-info">
    <h3>📋 项目信息</h3>
    <div class="team-grid">
        <div class="team-item">
            <div class="label">系统作者</div>
            <div class="value">第二小组</div>
        </div>
        <div class="team-item">
            <div class="label">指导老师</div>
            <div class="value">卢泽勇</div>
        </div>
        <div class="team-item">
            <div class="label">联系方式</div>
            <div class="value">15115444051</div>
        </div>
        <div class="team-item">
            <div class="label">开发日期</div>
            <div class="value">2026.04.01</div>
        </div>
    </div>
</div>

</body>
</html>