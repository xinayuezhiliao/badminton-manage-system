<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page language="java" import="java.sql.*" %>
<jsp:useBean id="connDbBean" scope="page" class="com.badminton.util.db"/>
<%@ page isELIgnored="false" %>

<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<html lang="zh-CN">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>个人中心 - 羽毛球球馆管理系统</title>
    <link rel="stylesheet" type="text/css" href="<%=basePath%>static/css/beautify.css" />
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { 
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", "Microsoft YaHei", sans-serif; 
            background: #f5f7fa;
            min-height: 100vh;
            padding: 20px;
        }
        .profile-card {
            max-width: 800px;
            margin: 0 auto;
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.1);
            overflow: hidden;
            margin-bottom: 20px;
        }
        .profile-header {
            background: linear-gradient(135deg, #16a085 0%, #1abc9c 100%);
            color: white;
            padding: 25px;
            text-align: center;
        }
        .profile-header h2 {
            font-size: 24px;
            margin-bottom: 10px;
        }
        .profile-avatar {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background: white;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 40px;
            margin-bottom: 15px;
        }
        .profile-info {
            padding: 25px;
        }
        .info-row {
            display: flex;
            padding: 15px 0;
            border-bottom: 1px solid #eee;
        }
        .info-row:last-child {
            border-bottom: none;
        }
        .info-label {
            width: 120px;
            font-weight: 600;
            color: #555;
        }
        .info-value {
            flex: 1;
            color: #333;
        }
        .action-buttons {
            padding: 20px;
            display: flex;
            gap: 15px;
            justify-content: center;
        }
        .btn {
            padding: 12px 30px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s;
            display: inline-block;
        }
        .btn-primary {
            background: linear-gradient(135deg, #16a085, #1abc9c);
            color: white;
        }
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(22, 160, 133, 0.3);
        }
        .btn-secondary {
            background: #95a5a6;
            color: white;
        }
        .btn-secondary:hover {
            background: #7f8c8d;
        }
        
        @media screen and (max-width: 768px) {
            body { padding: 10px; }
            .profile-header { padding: 20px; }
            .profile-info { padding: 20px; }
            .info-row { flex-direction: column; gap: 5px; }
            .info-label { width: 100%; }
            .action-buttons { flex-direction: column; }
            .btn { width: 100%; }
        }
    <div class="profile-card">
        <div class="profile-header">
            <div class="profile-avatar">👤</div>
            <h2>${huiyuanxinxi.xingming}</h2>
            <p style="opacity: 0.9;">${huiyuanxinxi.huiyuandengji}</p>
        </div>
        
        <div class="profile-info">
            <div class="info-row">
                <span class="info-label">会员编号：</span>
                <span class="info-value">${huiyuanxinxi.huiyuanbianhao}</span>
            </div>
            <div class="info-row">
                <span class="info-label">密码：</span>
                <span class="info-value">******</span>
            </div>
            <div class="info-row">
                <span class="info-label">姓名：</span>
                <span class="info-value">${huiyuanxinxi.xingming}</span>
            </div>
            <div class="info-row">
                <span class="info-label">性别：</span>
                <span class="info-value">${huiyuanxinxi.xingbie}</span>
            </div>
            <div class="info-row">
                <span class="info-label">会员等级：</span>
                <span class="info-value">${huiyuanxinxi.huiyuandengji}</span>
            </div>
            <div class="info-row">
                <span class="info-label">折扣：</span>
                <span class="info-value">${huiyuanxinxi.zhekou}</span>
            </div>
            <div class="info-row">
                <span class="info-label">手机：</span>
                <span class="info-value">${huiyuanxinxi.shouji}</span>
            </div>
            <div class="info-row">
                <span class="info-label">备注：</span>
                <span class="info-value">${huiyuanxinxi.beizhu != null ? huiyuanxinxi.beizhu : '无'}</span>
            </div>
        </div>
        
        <div class="action-buttons">
            <a href="javascript:history.back()" class="btn btn-secondary">返回</a>
            <a href="javascript:window.print()" class="btn btn-primary">打印</a>
        </div>
    </div>
  </body>
</html>
