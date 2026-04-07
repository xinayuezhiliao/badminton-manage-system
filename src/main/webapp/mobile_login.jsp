<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE html>
<html>
<head>
    <title>羽毛球球馆管理系统 - 手机登录</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
            background: linear-gradient(135deg, #16a085 0%, #1abc9c 100%);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        
        .login-container {
            width: 100%;
            max-width: 360px;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 16px;
            padding: 30px 25px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
        }
        
        .logo-area {
            text-align: center;
            margin-bottom: 25px;
        }
        
        .logo-area h1 {
            color: #16a085;
            font-size: 22px;
            font-weight: 600;
            margin-bottom: 5px;
        }
        
        .logo-area p {
            color: #7f8c8d;
            font-size: 13px;
        }
        
        .form-group {
            margin-bottom: 18px;
        }
        
        .form-group label {
            display: block;
            color: #555;
            font-size: 14px;
            margin-bottom: 6px;
            font-weight: 500;
        }
        
        .form-group input,
        .form-group select {
            width: 100%;
            height: 46px;
            padding: 0 15px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 15px;
            background: #fff;
            transition: border-color 0.3s;
        }
        
        .form-group input:focus,
        .form-group select:focus {
            outline: none;
            border-color: #16a085;
        }
        
        .captcha-group {
            display: flex;
            gap: 10px;
        }
        
        .captcha-group input {
            flex: 1;
        }
        
        .captcha-img {
            width: 100px;
            height: 46px;
            border-radius: 8px;
            cursor: pointer;
            object-fit: cover;
        }
        
        .submit-btn {
            width: 100%;
            height: 48px;
            background: linear-gradient(135deg, #16a085 0%, #1abc9c 100%);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 17px;
            font-weight: 600;
            cursor: pointer;
            margin-top: 10px;
            transition: transform 0.2s, box-shadow 0.2s;
        }
        
        .submit-btn:active {
            transform: scale(0.98);
        }
        
        .footer {
            margin-top: 20px;
            text-align: center;
            color: rgba(255, 255, 255, 0.8);
            font-size: 12px;
        }
        
        .pc-link {
            display: block;
            text-align: center;
            margin-top: 15px;
            color: #16a085;
            font-size: 13px;
            text-decoration: none;
        }
    </style>
</head>
<body>
<%
    String msg = (String) request.getAttribute("msg");
    if(msg != null) {
        out.println("<script>alert('" + msg + "');</script>");
    }
%>

<div class="login-container">
    <div class="logo-area">
        <h1>羽毛球球馆管理系统</h1>
        <p>Badminton Management System</p>
    </div>
    
    <form name="f11" id="f11" method="post" action="<%=basePath%>hsgloginyanzheng.jsp" onsubmit="return checkLogin();">
        <div class="form-group">
            <label>账号</label>
            <input type="text" name="username" id="username" placeholder="请输入账号" autocomplete="off">
        </div>
        
        <div class="form-group">
            <label>密码</label>
            <input type="password" name="pwd" id="pwd" placeholder="请输入密码">
        </div>
        
        <div class="form-group">
            <label>权限</label>
            <select name="cx" id="cx">
                <option value="超级管理员">管理员</option>
                <option value="huiyuan">会员</option>
            </select>
        </div>
        
        <div class="form-group">
            <label>验证码</label>
            <div class="captcha-group">
                <input type="text" name="pagerandom" id="pagerandom" placeholder="请输入验证码" maxlength="4" autocomplete="off">
                <img src="image.jsp" class="captcha-img" onclick="this.src='image.jsp?'+Math.random()" title="点击刷新">
            </div>
        </div>
        
        <button type="submit" class="submit-btn">立即登录</button>
        <input type="hidden" name="login" value="1">
    </form>
    
    <a href="<%=basePath%>login.jsp" class="pc-link">切换到电脑版</a>
</div>

<div class="footer">© 羽毛球球馆管理系统</div>

<script>
    function checkLogin() {
        var username = document.getElementById('username').value.trim();
        var pwd = document.getElementById('pwd').value.trim();
        var pagerandom = document.getElementById('pagerandom').value.trim();
        
        if(username === '') {
            alert('请输入账号!');
            return false;
        }
        if(pwd === '') {
            alert('请输入密码!');
            return false;
        }
        if(pagerandom === '') {
            alert('请输入验证码!');
            return false;
        }
        return true;
    }
</script>

</body>
</html>
