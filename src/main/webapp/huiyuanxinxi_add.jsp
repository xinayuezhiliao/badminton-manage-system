<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
    <title>添加会员信息 - 羽毛球球馆管理系统</title>
    <link rel="stylesheet" type="text/css" href="<%=basePath%>static/css/beautify.css" />
    <script type="text/javascript" src="<%=basePath%>js/My97DatePicker/WdatePicker.js" charset="gb2312"></script>
    <script type="text/javascript" src="<%=basePath%>js/popup.js"></script>
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
        select.form-control { cursor: pointer; appearance: none; background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 12 12'%3E%3Cpath fill='%23666' d='M6 8L1 3h10z'/%3E%3C/svg%3E"); background-repeat: no-repeat; background-position: right 12px center; padding-right: 35px; }
        textarea.form-control { height: auto; min-height: 100px; padding: 12px; resize: vertical; }
        .required { color: #e74c3c; margin-left: 4px; }
        .error-msg { color: #e74c3c; font-size: 13px; margin-left: 10px; }
        .form-actions { padding: 25px 20px; background: #f8f9fa; text-align: center; }
        .btn { display: inline-block; padding: 10px 28px; font-size: 14px; font-weight: 500; border: none; border-radius: 6px; cursor: pointer; transition: all 0.3s ease; margin: 0 8px; }
        .btn-primary { color: #fff; background: linear-gradient(135deg, #16a085 0%, #1abc9c 100%); }
        .btn-primary:hover { transform: translateY(-1px); box-shadow: 0 4px 12px rgba(22, 160, 133, 0.3); }
        .btn-secondary { color: #666; background: #fff; border: 1px solid #ddd; }
        .btn-secondary:hover { background: #f0f0f0; }
        @media screen and (max-width: 768px) {
            body { padding: 15px; }
            .form-body { padding: 20px; }
            .form-table th, .form-table td { display: block; width: 100%; text-align: left; padding: 12px 15px; }
            .form-table th { background: #f0f0f0; border-bottom: none; padding-bottom: 5px; }
            .form-table td { padding-top: 5px; padding-bottom: 20px; }
            .form-control { max-width: 100%; }
        }
        @media screen and (max-width: 480px) {
            body { padding: 10px; }
            .page-title h2 { font-size: 18px; }
            .form-header { padding: 14px 15px; font-size: 15px; }
            .form-body { padding: 15px; }
            .btn { padding: 10px 20px; margin: 0 4px; }
        }
    </style>
</head>
<body>
    <div class="page-title">
        <h2>添加会员信息</h2>
    </div>
    
    <!-- 错误提示 -->
    <%
        String addError = (String) session.getAttribute("addError");
        if (addError != null) {
    %>
    <div style="background: #fee; border-left: 4px solid #e74c3c; padding: 15px; margin-bottom: 20px; border-radius: 4px;">
        <span style="color: #e74c3c;">⚠️ <%= addError %></span>
    </div>
    <%
            session.removeAttribute("addError");
        }
    %>
    
    <div class="form-container">
        <div class="form-header">填写会员信息</div>
        
        <form action="<%=basePath%>huiyuanxinxi?action=add" name="form1" method="post">
            <div class="form-body">
                <table class="form-table">
                    <tr>
                        <th>会员编号<span class="required">*</span></th>
                        <td>
                            <input type="text" name="huiyuanbianhao" id="huiyuanbianhao" class="form-control" placeholder="请输入会员编号（具有唯一性）" onblur="hsgcheck()" autocomplete="off">
                            <span id="clabelhuiyuanbianhao" class="error-msg"></span>
                            <small style="color: #666; display: block; margin-top: 5px;">💡 会员编号具有唯一性，不能与现有会员重复</small>
                        </td>
                    </tr>
                    <tr>
                        <th>密码<span class="required">*</span></th>
                        <td>
                            <input type="password" name="mima" id="mima" class="form-control" placeholder="请输入密码" onblur="checkform()">
                            <span id="clabelmima" class="error-msg"></span>
                        </td>
                    </tr>
                    <tr>
                        <th>姓名</th>
                        <td><input type="text" name="xingming" id="xingming" class="form-control" placeholder="请输入姓名"></td>
                    </tr>
                    <tr>
                        <th>性别</th>
                        <td>
                            <select name="xingbie" id="xingbie" class="form-control">
                                <option value="男">男</option>
                                <option value="女">女</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <th>会员等级</th>
                        <td>
                            <select name="huiyuandengji" id="huiyuandengji" class="form-control">
                                <option value="砖石">砖石</option>
                                <option value="铂金">铂金</option>
                                <option value="黄金">黄金</option>
                                <option value="普通">普通</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <th>折扣</th>
                        <td><input type="text" name="zhekou" id="zhekou" class="form-control" placeholder="请输入折扣"></td>
                    </tr>
                    <tr>
                        <th>手机</th>
                        <td><input type="text" name="shouji" id="shouji" class="form-control" placeholder="请输入手机号码"></td>
                    </tr>
                    <tr>
                        <th>余额（元）</th>
                        <td>
                            <input type="number" name="yue" id="yue" class="form-control" value="0.00" 
                                   step="0.01" min="0" placeholder="请输入初始余额">
                            <small style="color: #666; display: block; margin-top: 5px;">💰 设置会员账户初始余额，用于场地预定扣款</small>
                        </td>
                    </tr>
                    <tr>
                        <th>备注</th>
                        <td><textarea name="beizhu" id="beizhu" class="form-control" placeholder="请输入备注信息"></textarea></td>
                    </tr>
                </table>
            </div>
            
            <div class="form-actions">
                <button type="submit" name="querenzhuce" id="querenzhuce" class="btn btn-primary" onclick="return checkform();">提交</button>
                <button type="reset" class="btn btn-secondary">重置</button>
            </div>
        </form>
    </div>

<script language="javascript">
function hsgcheck() {
    var huiyuanbianhao = $("#huiyuanbianhao").val();
    if(huiyuanbianhao == "") {
        $("#clabelhuiyuanbianhao").html("会员编号不能为空！");
        $("input[id=huiyuanbianhao]").focus();
        $("#querenzhuce").attr("disabled", "disabled");
        return false;
    } else {
        $("#clabelhuiyuanbianhao").html("");
        $.ajax({
            url: "<%=basePath%>huiyuanxinxi?action=check",
            type: "post",
            data: "huiyuanbianhao=" + huiyuanbianhao,
            dataType: "json",
            success: function(result) {
                if(result.info == "ng") {
                    $("#clabelhuiyuanbianhao").html("会员编号已存在，请更换！");
                    $("input[id=huiyuanbianhao]").focus();
                    $("#querenzhuce").attr("disabled", "disabled");
                    return false;
                } else {
                    $("#querenzhuce").removeAttr("disabled");
                }
            },
            error: function() {
                $("#clabelhuiyuanbianhao").html("系统异常，请检查错误！");
                $("input[id=huiyuanbianhao]").focus();
                $("#querenzhuce").attr("disabled", "disabled");
                return false;
            }
        });
    }
}

function checkform() {
    var huiyuanbianhaoobj = document.getElementById("huiyuanbianhao");
    if(huiyuanbianhaoobj.value == "") {
        document.getElementById("clabelhuiyuanbianhao").innerHTML = "请输入会员编号";
        return false;
    } else {
        document.getElementById("clabelhuiyuanbianhao").innerHTML = "";
    }
    
    var mimaobj = document.getElementById("mima");
    if(mimaobj.value == "") {
        document.getElementById("clabelmima").innerHTML = "请输入密码";
        return false;
    } else {
        document.getElementById("clabelmima").innerHTML = "";
    }
    
    return true;
}
</script>
</body>
</html>
