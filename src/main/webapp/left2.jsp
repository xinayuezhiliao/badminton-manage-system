<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page isELIgnored="false" %>

<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    
    // 获取当前用户信息
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect(basePath + "login.jsp");
        return;
    }
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>会员中心</title>
    <style type="text/css">
        /* ========== 基础重置 ========== */
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: '微软雅黑', -apple-system, BlinkMacSystemFont, sans-serif;
            font-size: 14px;
            color: #333;
            background-color: #339999;
            overflow-x: hidden;
        }
        
        a { text-decoration: none; color: inherit; }
        ul, li { list-style: none; }
        
        /* ========== 侧边栏容器 ========== */
        .sidebar-container {
            width: 100%;
            min-height: 100vh;
            background-color: #339999;
            padding-bottom: 0; /* 🔥 移除底部 padding，避免下沉 */
        }
        
        /* ========== 用户信息区 ========== */
        .sidebar-user {
            display: flex;
            align-items: center;
            gap: 15px;
            padding: 15px 20px; /* 🔥 减小上下 padding，从 25px 改为 15px */
            background-color: rgba(0,0,0,0.1);
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }
        
        .user-avatar {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            background-color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 28px;
            flex-shrink: 0; /* 🔥 防止被压缩 */
            box-shadow: 0 2px 8px rgba(0,0,0,0.15);
            margin-top: 0; /* 🔥 确保没有额外偏移 */
        }
        
        .user-details {
            flex: 1;
            min-width: 0;
            padding-top: 0; /* 🔥 确保没有额外偏移 */
        }
        
        .user-details h3 {
            font-size: 17px;
            font-weight: 600;
            color: white;
            margin-bottom: 5px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        
        .user-details p {
            font-size: 13px;
            color: rgba(255,255,255,0.85);
            font-weight: 500;
        }
        
        /* ========== 菜单区域 ========== */
        .sidebar-menu {
            padding: 20px 0;
        }
        
        .menu-group {
            margin-bottom: 25px;
        }
        
        .menu-title {
            padding: 10px 20px 8px;
            color: rgba(255,255,255,0.6);
            font-size: 12px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        
        .menu-item {
            display: flex;
            align-items: center;
            padding: 16px 20px;
            color: white;
            font-size: 15px;
            transition: all 0.3s ease;
            border-left: 3px solid transparent;
            min-height: 52px;
            cursor: pointer;
        }
        
        .menu-item:hover {
            background-color: rgba(255,255,255,0.1);
            border-left-color: white;
        }
        
        .menu-item:active {
            background-color: rgba(255,255,255,0.15);
            transform: translateX(2px);
        }
        
        .menu-item.active {
            background-color: rgba(255,255,255,0.15);
            border-left-color: white;
        }
        
        .menu-icon {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 28px;
            margin-right: 12px;
            font-size: 18px;
            flex-shrink: 0;
        }
        
        .menu-text {
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            flex: 1;
        }
        
        ::-webkit-scrollbar {
            width: 6px;
        }
        
        ::-webkit-scrollbar-track {
            background: rgba(0,0,0,0.1);
        }
        
        ::-webkit-scrollbar-thumb {
            background: rgba(255,255,255,0.3);
            border-radius: 3px;
        }
        
        ::-webkit-scrollbar-thumb:hover {
            background: rgba(255,255,255,0.5);
        }
    </style>
</head>
<body>
    <div class="sidebar-container">
        <!-- 用户信息 -->
        <div class="sidebar-user">
            <div class="user-avatar">👤</div>
            <div class="user-details">
                <h3><%=username%></h3>
                <p>尊贵会员</p>
            </div>
        </div>
        
        <!-- 菜单导航 -->
        <nav class="sidebar-menu">
            <div class="menu-group">
                <div class="menu-title">个人资料</div>
                <a href="huiyuanxinxi?action=toUpdate2" target="rightFrame" class="menu-item">
                    <span class="menu-icon">📋</span>
                    <span class="menu-text">资料管理</span>
                </a>
            </div>
            
            <div class="menu-group">
                <div class="menu-title">场地服务</div>
                <a href="qiuzhuoxinxi?action=list2" target="rightFrame" class="menu-item">
                    <span class="menu-icon">🏟️</span>
                    <span class="menu-text">场地列表</span>
                </a>
                <a href="qiuzhuoxinxi?action=searchPage" target="rightFrame" class="menu-item">
                    <span class="menu-icon">🔍</span>
                    <span class="menu-text">场地查询</span>
                </a>
            </div>
            
            <div class="menu-group">
                <div class="menu-title">订场管理</div>
                <a href="dingzhuoxinxi?action=list2" target="rightFrame" class="menu-item">
                    <span class="menu-icon">📝</span>
                    <span class="menu-text">订场记录</span>
                </a>
            </div>
            
            <div class="menu-group">
                <div class="menu-title">付费信息</div>
                <a href="fufei?action=list2" target="rightFrame" class="menu-item">
                    <span class="menu-icon">💰</span>
                    <span class="menu-text">已付费查询</span>
                </a>
            </div>
        </nav>
    </div>
    
    <script type="text/javascript">
        // 点击菜单项后自动关闭侧边栏（仅移动端）
        document.querySelectorAll('.menu-item').forEach(item => {
            item.addEventListener('click', function() {
                // 移除其他菜单项的 active 状态
                document.querySelectorAll('.menu-item').forEach(i => i.classList.remove('active'));
                // 添加当前菜单项的 active 状态
                this.classList.add('active');
                
                // 如果是移动端，关闭侧边栏
                if (window.innerWidth < 1024) {
                    const sidebar = parent.document.getElementById('sidebar');
                    const overlay = parent.document.getElementById('overlay');
                    const hamburger = parent.document.getElementById('hamburgerBtn');
                    
                    if (sidebar && overlay && hamburger) {
                        sidebar.classList.remove('active');
                        overlay.classList.remove('active');
                        hamburger.classList.remove('active');
                    }
                }
            });
        });
    </script>
</body>
</html>
