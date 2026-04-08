<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page language="java" import="java.sql.*" %>
<jsp:useBean id="connDbBean" scope="page" class="com.badminton.util.db"/>
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
    <title>修改密码 - 羽毛球球馆管理系统</title>
    <link rel="stylesheet" type="text/css" href="<%=basePath%>static/css/beautify.css" />
    <script type="text/javascript" src="<%=basePath%>js/jquery-1.11.0.min.js"></script>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", "Microsoft YaHei", sans-serif; font-size: 14px; line-height: 1.6; color: #333; background-color: #f5f7fa; margin: 0; padding: 20px; }
        .page-title { margin-bottom: 20px; padding-bottom: 15px; border-bottom: 2px solid #e9ecef; }
        .page-title h2 { font-size: 20px; font-weight: 600; color: #333; margin: 0; display: flex; align-items: center; }
        .page-title h2::before { content: ""; display: inline-block; width: 4px; height: 20px; background: linear-gradient(135deg, #16a085 0%, #1abc9c 100%); margin-right: 10px; border-radius: 2px; }
        .form-container { background: #fff; border-radius: 8px; box-shadow: 0 2px 12px rgba(0, 0, 0, 0.08); overflow: hidden; }
        .form-header { background: linear-gradient(135deg, #16a085 0%, #1abc9c 100%); color: #fff; padding: 16px 20px; font-size: 16px; font-weight: 600; }
        .form-body { padding: 30px; }
        .form-table { width: 100%; border-collapse: separate; border-spacing: 0; }
        .form-table th { width: 150px; padding: 16px 20px; text-align: right; font-weight: 500; color: #555; background: #f8f9fa; border-bottom: 1px solid #eee; vertical-align: middle; }
        .form-table td { padding: 16px 20px; border-bottom: 1px solid #eee; }
        .form-table tr:last-child th, .form-table tr:last-child td { border-bottom: none; }
        .form-control { width: 100%; max-width: 300px; height: 42px; padding: 0 14px; font-size: 14px; border: 1px solid #ddd; border-radius: 6px; transition: border-color 0.3s ease, box-shadow 0.3s ease; }
        .form-control:focus { outline: none; border-color: #16a085; box-shadow: 0 0 0 3px rgba(22, 160, 133, 0.15); }
        .required { color: #e74c3c; margin-left: 4px; }
        .error-msg { color: #e74c3c; font-size: 13px; margin-left: 10px; }
        .form-actions { padding: 25px 20px; background: #f8f9fa; text-align: center; }
        .btn { display: inline-block; padding: 10px 28px; font-size: 14px; font-weight: 500; border: none; border-radius: 6px; cursor: pointer; transition: all 0.3s ease; margin: 0 8px; }
        .btn-primary { color: #fff; background: linear-gradient(135deg, #16a085 0%, #1abc9c 100%); }
        .btn-primary:hover { transform: translateY(-1px); box-shadow: 0 4px 12px rgba(22, 160, 133, 0.3); }
        .btn-secondary { color: #666; background: #fff; border: 1px solid #ddd; }
        .btn-secondary:hover { background: #f0f0f0; }
        .user-info { font-weight: 600; color: #16a085; }
        @media screen and (max-width: 768px) {
            body { padding: 15px; }
            .form-body { padding: 20px; }
            .form-table th, .form-table td { display: block; width: 100%; text-align: left; padding: 12px 15px; }
            .form-table th { background: #f0f0f0; border-bottom: none; padding-bottom: 5px; }
            .form-table td { padding-top: 5px; padding-bottom: 20px; }
            .form-control { max-width: 100%; }
        }
    </style>
</head>
<body>
    <div class="page-title">
        <h2>修改密码</h2>
    </div>
    
    <div class="form-container">
        <div class="form-header">🔐 修改登录密码</div>
        
        <form action="mod2.jsp" name="form1" method="post" onsubmit="return checkform();">
            <div class="form-body">
                <table class="form-table">
                    <tr>
                        <th>当前用户</th>
                        <td class="user-info"><%=request.getSession().getAttribute("username")%></td>
                    </tr>
                    <tr>
                        <th>原密码<span class="required">*</span></th>
                        <td>
                            <input type="password" name="oldpwd" id="oldpwd" class="form-control" placeholder="请输入原密码">
                            <span id="clabeloldpwd" class="error-msg"></span>
                        </td>
                    </tr>
                    <tr>
                        <th>新密码<span class="required">*</span></th>
                        <td>
                            <input type="password" name="newpwd" id="newpwd" class="form-control" placeholder="请输入新密码">
                            <span id="clabelnewpwd" class="error-msg"></span>
                        </td>
                    </tr>
                    <tr>
                        <th>确认新密码<span class="required">*</span></th>
                        <td>
                            <input type="password" name="newpwd2" id="newpwd2" class="form-control" placeholder="请再次输入新密码">
                            <span id="clabelnewpwd2" class="error-msg"></span>
                        </td>
                    </tr>
                </table>
            </div>
            
            <div class="form-actions">
                <button type="submit" name="querenzhuce" id="querenzhuce" class="btn btn-primary">提交</button>
                <button type="reset" class="btn btn-secondary">重置</button>
            </div>
        </form>
    </div>

<script language="javascript">
function checkform(){
    var oldpwdobj = document.getElementById("oldpwd");
    if(oldpwdobj.value==""){
        document.getElementById("clabeloldpwd").innerHTML="请输入原密码";
        return false;
    }else{
        document.getElementById("clabeloldpwd").innerHTML="";
    }
    
    var newpwdobj = document.getElementById("newpwd");
    if(newpwdobj.value==""){
        document.getElementById("clabelnewpwd").innerHTML="请输入新密码";
        return false;
    }else{
        document.getElementById("clabelnewpwd").innerHTML="";
    }
    
    var newpwd2obj = document.getElementById("newpwd2");
    if(newpwd2obj.value==""){
        document.getElementById("clabelnewpwd2").innerHTML="请确认新密码";
        return false;
    }else if(newpwd2obj.value != newpwdobj.value){
        document.getElementById("clabelnewpwd2").innerHTML="两次密码输入不一致";
        return false;
    }else{
        document.getElementById("clabelnewpwd2").innerHTML="";
    }
    
    return true;
}
</script>
</body>
</html>
