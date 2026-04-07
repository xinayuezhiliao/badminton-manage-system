<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>羽毛球球馆管理系统</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Microsoft YaHei", sans-serif;
            overflow: hidden;
        }
        
        /* 顶部区域 */
        .top-frame {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            height: 60px;
            background: linear-gradient(135deg, #16a085 0%, #1abc9c 100%);
            z-index: 1000;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            padding-left: 70px; /* 🔥 给汉堡按钮留出空间 */
            display: flex;
            align-items: center;
        }
        
        /* 主容器 */
        .main-container {
            display: flex;
            height: 100vh;
            position: relative;
        }
        
        /* 🔥 强制设置主容器的 flex 行为 */
        .main-container > * {
            flex-shrink: 0;  /* 默认不允许压缩子元素 */
        }
        
        /* ========== 侧边栏（手机端默认隐藏） ========== */
        .sidebar {
            position: fixed;
            left: -280px;
            top: 60px;
            width: 280px;
            height: calc(100vh - 60px);
            background-color: #339999;
            transition: transform 0.3s ease;
            z-index: 999;
            overflow-y: auto;
            box-shadow: 2px 0 10px rgba(0,0,0,0.2);
            -webkit-overflow-scrolling: touch; /* 手机端平滑滚动 */
        }
        
        .sidebar.active {
            transform: translateX(280px);
        }
        
        /* 遮罩层 */
        .overlay {
            position: fixed;
            top: 60px;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0,0,0,0.5);
            z-index: 998;
            opacity: 0;
            visibility: hidden;
            transition: all 0.3s ease;
        }
        
        .overlay.active {
            opacity: 1;
            visibility: visible;
        }
        
        /* 右侧内容区 */
        .content-frame {
            flex: 1 1 auto;      /* 🔥 自动增长和缩小，占满剩余空间 */
            width: 0;            /* 🔥 关键！防止内容溢出 */
            min-width: 0;        /* 🔥 允许缩小到比内容小 */
            height: 100%;
            overflow: hidden;
            background: #f5f7fa;
        }
        
        /* 汉堡按钮 */
        .hamburger-btn {
            position: fixed;
            top: 8px; /* 🔥 向上调整，垂直居中 */
            left: 15px;
            width: 44px;
            height: 44px;
            background: transparent;
            border: none;
            cursor: pointer;
            z-index: 1001;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            gap: 5px;
            padding: 8px;
            transition: all 0.3s ease;
        }
        
        .hamburger-btn span {
            display: block;
            width: 24px;
            height: 3px;
            background-color: white;
            border-radius: 2px;
            transition: all 0.3s ease;
        }
        
        .hamburger-btn.active span:nth-child(1) {
            transform: rotate(45deg) translate(6px, 6px);
        }
        
        .hamburger-btn.active span:nth-child(2) {
            opacity: 0;
        }
        
        .hamburger-btn.active span:nth-child(3) {
            transform: rotate(-45deg) translate(6px, -6px);
        }
        
        /* ========== PC 端适配（>=1024px） ========== */
        @media (min-width: 1024px) {
            .sidebar {
                position: fixed !important;      /* 🔥 PC 端也使用 fixed，直接贴到屏幕最左边 */
                left: 0 !important;              /* 🔥 强制贴在最左侧 */
                top: 60px !important;            /* 🔥 从顶部栏下方开始 */
                
                /* 🔥 使用 flex 属性精确控制宽度 */
                flex: 0 0 280px !important;      /* 🔥 不增长、不缩小、固定 280px */
                width: 280px !important;         /* 强制固定宽度 */
                min-width: 280px !important;     /* 最小宽度保证 */
                max-width: 280px !important;     /* 最大宽度限制 */
                
                height: calc(100vh - 60px) !important;  /* 🔥 PC 端使用完整高度（减去顶部栏） */
                transform: none !important;             /* 强制移除 transform */
                box-shadow: none;                       /* 移除阴影 */
                overflow-y: auto;                       /* 允许垂直滚动 */
            }
            
            .sidebar.active {
                transform: none !important; /* PC 端 active 也不移动 */
            }
            
            .overlay {
                display: none !important; /* PC 端不需要遮罩 */
            }
            
            .hamburger-btn {
                display: none; /* PC 端隐藏汉堡按钮 */
            }
            
            .top-frame {
                padding-left: 0; /* 🔥 PC 端不需要留空间，因为汉堡按钮隐藏了 */
            }
            
            .main-container {
                margin-left: 280px !important;  /* 🔥 关键！主容器向右偏移 280px，给侧边栏腾出空间 */
            }
        }
    </style>
</head>
<body>
    <!-- 顶部 -->
    <div class="top-frame">
        <iframe src="top.jsp" name="topFrame" style="width:100%;height:100%;border:none;" scrolling="No"></iframe>
    </div>
    
    <!-- 汉堡按钮 -->
    <button class="hamburger-btn" id="hamburgerBtn" onclick="toggleSidebar()">
        <span></span>
        <span></span>
        <span></span>
    </button>
    
    <!-- 遮罩层 -->
    <div class="overlay" id="overlay" onclick="toggleSidebar()"></div>
    
    <!-- 主容器 -->
    <div class="main-container">
        <!-- 左侧栏 -->
        <div class="sidebar" id="sidebar">
            <iframe src="mygo.jsp" name="leftFrame" id="leftFrame" style="width:100%;height:100%;border:none;" scrolling="No"></iframe>
        </div>
        
        <!-- 右侧内容 -->
        <div class="content-frame">
            <iframe src="toRightPage.jsp" name="rightFrame" id="rightFrame" style="width:100%;height:100%;border:none;" scrolling="yes"></iframe>
        </div>
    </div>
    
    <script>
        // 统一的侧边栏开关函数
        function toggleSidebar() {
            const sidebar = document.getElementById('sidebar');
            const overlay = document.getElementById('overlay');
            const hamburger = document.getElementById('hamburgerBtn');
            
            // 如果是 PC 端，不执行任何操作（汉堡按钮已隐藏）
            if (window.innerWidth >= 1024) {
                return;
            }
            
            const isActive = sidebar.classList.contains('active');
            
            if (isActive) {
                // 收起侧边栏
                sidebar.classList.remove('active');
                overlay.classList.remove('active');
                hamburger.classList.remove('active');
            } else {
                // 展开侧边栏
                sidebar.classList.add('active');
                overlay.classList.add('active');
                hamburger.classList.add('active');
            }
        }
        
        // 页面加载完成后初始化（PC 端默认展开）
        window.addEventListener('DOMContentLoaded', function() {
            // PC 端不需要任何操作，CSS 已经处理好了
            // 手机端也不需要任何操作，默认就是收起的
        });
    </script>
</body>
</html>

