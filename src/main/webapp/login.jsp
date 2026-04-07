<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
    <title>羽毛球球馆管理系统 - 登录</title>
    <link rel="stylesheet" type="text/css" href="<%=basePath%>static/css/beautify.css" />
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", "Microsoft YaHei", "微软雅黑", sans-serif;
            min-height: 100vh;
            background: linear-gradient(135deg, #16a085 0%, #1abc9c 50%, #2ecc71 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            position: relative;
        }
        
        /* 动态背景粒子效果 */
        .particles {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            overflow: hidden;
            z-index: 0;
        }
        
        .particle {
            position: absolute;
            width: 10px;
            height: 10px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 50%;
            animation: float 15s infinite;
        }
        
        @keyframes float {
            0%, 100% {
                transform: translateY(100vh) rotate(0deg);
                opacity: 0;
            }
            10% {
                opacity: 1;
            }
            90% {
                opacity: 1;
            }
            100% {
                transform: translateY(-100vh) rotate(720deg);
                opacity: 0;
            }
        }
        
        .login-container {
            position: relative;
            z-index: 1;
            width: 100%;
            max-width: 420px;
            padding: 20px;
        }
        
        .login-box {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 40px 35px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            backdrop-filter: blur(10px);
        }
        
        .login-header {
            text-align: center;
            margin-bottom: 35px;
        }
        
        .login-header .logo {
            width: 80px;
            height: 80px;
            background: linear-gradient(135deg, #16a085 0%, #1abc9c 100%);
            border-radius: 50%;
            margin: 0 auto 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 36px;
            color: white;
            box-shadow: 0 8px 20px rgba(22, 160, 133, 0.3);
        }
        
        .login-header h1 {
            font-size: 24px;
            font-weight: 600;
            color: #333;
            margin-bottom: 8px;
        }
        
        .login-header p {
            font-size: 14px;
            color: #888;
        }
        
        .form-group {
            margin-bottom: 22px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-size: 14px;
            font-weight: 500;
            color: #555;
        }
        
        .input-wrapper {
            position: relative;
        }
        
        .input-wrapper .icon {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            font-size: 18px;
            color: #16a085;
        }
        
        .form-control {
            width: 100%;
            height: 50px;
            padding: 0 15px 0 45px;
            font-size: 15px;
            border: 2px solid #e8e8e8;
            border-radius: 10px;
            background: #fafafa;
            transition: all 0.3s ease;
        }
        
        .form-control:focus {
            outline: none;
            border-color: #16a085;
            background: #fff;
            box-shadow: 0 0 0 4px rgba(22, 160, 133, 0.1);
        }
        
        .form-control::placeholder {
            color: #aaa;
        }
        
        select.form-control {
            padding-left: 15px;
            cursor: pointer;
        }
        
        .captcha-wrapper {
            display: flex;
            gap: 12px;
        }
        
        .captcha-wrapper .form-control {
            flex: 1;
        }
        
        .captcha-img {
            width: 120px;
            height: 50px;
            border-radius: 10px;
            cursor: pointer;
            object-fit: cover;
            border: 2px solid #e8e8e8;
            transition: border-color 0.3s ease;
        }
        
        .captcha-img:hover {
            border-color: #16a085;
        }
        
        .btn-login {
            width: 100%;
            height: 52px;
            background: linear-gradient(135deg, #16a085 0%, #1abc9c 100%);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 17px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 10px;
        }
        
        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(22, 160, 133, 0.4);
        }
        
        .btn-login:active {
            transform: translateY(0);
        }
        
        .login-footer {
            text-align: center;
            margin-top: 25px;
            color: #888;
            font-size: 13px;
        }
        
        .mobile-link {
            display: none;
            text-align: center;
            margin-top: 15px;
        }
        
        .mobile-link a {
            color: #16a085;
            font-size: 14px;
            text-decoration: none;
        }
        
        /* 响应式设计 */
        @media screen and (max-width: 768px) {
            .login-box {
                padding: 30px 25px;
                margin: 15px;
            }
            
            .login-header h1 {
                font-size: 20px;
            }
            
            .form-control {
                height: 46px;
                font-size: 14px;
            }
            
            .btn-login {
                height: 48px;
                font-size: 16px;
            }
        }
        
        @media screen and (max-width: 480px) {
            body {
                background: linear-gradient(135deg, #16a085 0%, #1abc9c 100%);
            }
            
            .login-box {
                padding: 25px 20px;
                border-radius: 16px;
            }
            
            .login-header .logo {
                width: 60px;
                height: 60px;
                font-size: 28px;
            }
            
            .login-header h1 {
                font-size: 18px;
            }
            
            .form-group {
                margin-bottom: 18px;
            }
        }
    </style>
</head>
<script>
    // 自动识别移动设备并跳转
    if(/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent)) {
        window.location.href = "<%=basePath%>mobile_login.jsp";
    }
</script>
<body>
    <!-- 动态背景粒子 -->
    <div class="particles" id="particles"></div>

<%
    String msg = (String) request.getAttribute("msg");
    if(msg != null) {
        out.println("<script>alert('" + msg + "');</script>");
    }
%>

    <div class="login-container">
        <div class="login-box">
            <div class="login-header">
                <div class="logo">🏸</div>
                <h1>羽毛球球馆管理系统</h1>
                <p>Badminton Management System</p>
            </div>
            
            <form name="f11" id="f11" method="post" action="<%=basePath%>hsgloginyanzheng.jsp" onsubmit="return hsgchecklogin();">
                <div class="form-group">
                    <label>账号</label>
                    <div class="input-wrapper">
                        <span class="icon">👤</span>
                        <input type="text" name="username" id="username" class="form-control" placeholder="请输入账号" autocomplete="off">
                    </div>
                </div>
                
                <div class="form-group">
                    <label>密码</label>
                    <div class="input-wrapper">
                        <span class="icon">🔒</span>
                        <input type="password" name="pwd" id="pwd" class="form-control" placeholder="请输入密码">
                    </div>
                </div>
                
                <div class="form-group">
                    <label>权限</label>
                    <select name="cx" id="cx" class="form-control">
                        <option value="超级管理员">管理员</option>
                        <option value="huiyuan">会员</option>
                    </select>
                </div>
                
                <div class="form-group">
                    <label>验证码</label>
                    <div class="captcha-wrapper">
                        <input type="text" name="pagerandom" id="pagerandom" class="form-control" placeholder="请输入验证码" maxlength="4" autocomplete="off" style="padding-left: 15px;">
                        <img src="image.jsp" class="captcha-img" onclick="this.src='image.jsp?'+Math.random()" title="点击刷新验证码">
                    </div>
                </div>
                
                <button type="submit" class="btn-login">立即登录</button>
                <input type="hidden" name="login" value="1">
            </form>
            
            <div class="login-footer">
                &copy; 2026 羽毛球球馆管理系统 版权所有
            </div>
        </div>
    </div>

    <script>
        // 生成背景粒子
        function createParticles() {
            const container = document.getElementById('particles');
            const particleCount = 20;
            
            for (let i = 0; i < particleCount; i++) {
                const particle = document.createElement('div');
                particle.className = 'particle';
                particle.style.left = Math.random() * 100 + '%';
                particle.style.width = Math.random() * 15 + 5 + 'px';
                particle.style.height = particle.style.width;
                particle.style.animationDelay = Math.random() * 15 + 's';
                particle.style.animationDuration = (Math.random() * 10 + 10) + 's';
                container.appendChild(particle);
            }
        }
        
        createParticles();
        
        // 登录验证
        function hsgchecklogin() {
            var username = document.getElementById('username').value.trim();
            var pwd = document.getElementById('pwd').value.trim();
            var pagerandom = document.getElementById('pagerandom').value.trim();
            
            if(username === '') {
                alert('请输入账号!');
                document.getElementById('username').focus();
                return false;
            }
            if(pwd === '') {
                alert('请输入密码!');
                document.getElementById('pwd').focus();
                return false;
            }
            if(pagerandom === '') {
                alert('请输入验证码!');
                document.getElementById('pagerandom').focus();
                return false;
            }
            return true;
        }
    </script>
</body>
</html>