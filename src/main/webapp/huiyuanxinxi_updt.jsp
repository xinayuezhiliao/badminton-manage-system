<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.badminton.entity.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>编辑会员信息</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { 
            font-family: 'Microsoft YaHei', Arial, sans-serif; 
            background: #f5f6fa;
            min-height: 100vh;
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
            max-width: 900px;
            margin: 30px auto;
            padding: 0 20px;
        }
        
        /* 表单卡片 */
        .form-card {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 15px rgba(0,0,0,0.1);
            overflow: hidden;
        }
        .form-header {
            background: linear-gradient(135deg, #3498db, #2980b9);
            color: white;
            padding: 20px 30px;
            font-size: 18px;
            font-weight: 600;
        }
        .form-body {
            padding: 40px 30px;
        }
        
        /* 表单项 */
        .form-group {
            margin-bottom: 25px;
        }
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #2c3e50;
            font-size: 15px;
        }
        .form-control {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 6px;
            font-size: 15px;
            transition: all 0.3s;
        }
        .form-control:focus {
            outline: none;
            border-color: #3498db;
            box-shadow: 0 0 0 3px rgba(52,152,219,0.1);
        }
        select.form-control {
            cursor: pointer;
        }
        textarea.form-control {
            resize: vertical;
            min-height: 100px;
        }
        .required {
            color: #e74c3c;
            margin-left: 5px;
        }
        .error-msg {
            color: #e74c3c;
            font-size: 13px;
            margin-top: 5px;
            display: none;
        }
        
        /* 按钮区域 */
        .form-actions {
            display: flex;
            gap: 15px;
            justify-content: center;
            margin-top: 35px;
            padding-top: 30px;
            border-top: 2px solid #ecf0f1;
        }
        .btn {
            padding: 12px 40px;
            border: none;
            border-radius: 6px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
        }
        .btn-primary {
            background: linear-gradient(135deg, #3498db, #2980b9);
            color: white;
        }
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(52,152,219,0.3);
        }
        .btn-secondary {
            background: #95a5a6;
            color: white;
        }
        .btn-secondary:hover {
            background: #7f8c8d;
            transform: translateY(-2px);
        }
        .btn-back {
            background: #16a085;
            color: white;
            text-decoration: none;
            display: inline-block;
        }
        .btn-back:hover {
            background: #1abc9c;
            transform: translateY(-2px);
        }
    </style>
</head>
<body>
    <%
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
        Huiyuanxinxi member = (Huiyuanxinxi) request.getAttribute("huiyuanxinxi");
        if (member == null) {
            response.sendRedirect("huiyuanxinxi?action=list");
            return;
        }
    %>
    
    <!-- 顶部标题 -->
    <div class="header">
        <h2>✏️ 编辑会员信息</h2>
    </div>
    
    <div class="container">
        <form action="<%=basePath%>huiyuanxinxi?action=update" method="post" id="editForm">
            <input type="hidden" name="id" value="<%=member.getId()%>" />
            
            <div class="form-card">
                <div class="form-header">
                    📋 基本信息
                </div>
                
                <div class="form-body">
                    <!-- 会员编号 -->
                    <div class="form-group">
                        <label>会员编号 <span class="required">*</span></label>
                        <input type="text" name="huiyuanbianhao" id="huiyuanbianhao" 
                               class="form-control" value="<%=member.getHuiyuanbianhao() != null ? member.getHuiyuanbianhao() : ""%>"
                               required onblur="checkHuiyuanbianhao()" />
                        <div id="error-huiyuanbianhao" class="error-msg"></div>
                    </div>
                    
                    <!-- 密码 -->
                    <div class="form-group">
                        <label>密码 <span class="required">*</span></label>
                        <input type="text" name="mima" id="mima" 
                               class="form-control" value="<%=member.getMima() != null ? member.getMima() : ""%>"
                               required onblur="checkMima()" />
                        <div id="error-mima" class="error-msg"></div>
                    </div>
                    
                    <!-- 姓名 -->
                    <div class="form-group">
                        <label>姓名</label>
                        <input type="text" name="xingming" id="xingming" 
                               class="form-control" value="<%=member.getXingming() != null ? member.getXingming() : ""%>" />
                    </div>
                    
                    <!-- 性别 -->
                    <div class="form-group">
                        <label>性别</label>
                        <select name="xingbie" id="xingbie" class="form-control">
                            <option value="">请选择</option>
                            <option value="男" <%="男".equals(member.getXingbie()) ? "selected" : ""%>>男</option>
                            <option value="女" <%="女".equals(member.getXingbie()) ? "selected" : ""%>>女</option>
                        </select>
                    </div>
                    
                    <!-- 会员等级 -->
                    <div class="form-group">
                        <label>会员等级</label>
                        <select name="huiyuandengji" id="huiyuandengji" class="form-control">
                            <option value="">请选择</option>
                            <option value="砖石" <%="砖石".equals(member.getHuiyuandengji()) ? "selected" : ""%>>砖石</option>
                            <option value="铂金" <%="铂金".equals(member.getHuiyuandengji()) ? "selected" : ""%>>铂金</option>
                            <option value="黄金" <%="黄金".equals(member.getHuiyuandengji()) ? "selected" : ""%>>黄金</option>
                            <option value="普通" <%="普通".equals(member.getHuiyuandengji()) ? "selected" : ""%>>普通</option>
                        </select>
                    </div>
                    
                    <!-- 折扣 -->
                    <div class="form-group">
                        <label>折扣</label>
                        <input type="text" name="zhekou" id="zhekou" 
                               class="form-control" value="<%=member.getZhekou() != null ? member.getZhekou() : ""%>" />
                    </div>
                    
                    <!-- 手机号 -->
                    <div class="form-group">
                        <label>手机号</label>
                        <input type="text" name="shouji" id="shouji" 
                               class="form-control" value="<%=member.getShouji() != null ? member.getShouji() : ""%>" />
                    </div>
                    
                    <!-- 余额 -->
                    <div class="form-group">
                        <label>余额（元）</label>
                        <input type="number" name="yue" id="yue"
                               class="form-control" value="<%=member.getYue() != null ? member.getYue() : "0.00"%>"
                               step="0.01" min="0" />
                        <small class="help-text">💰 设置会员账户余额，用于场地预定扣款</small>
                    </div>

                    <!-- 备注 -->
                    <div class="form-group">
                        <label>备注</label>
                        <textarea name="beizhu" id="beizhu" class="form-control"><%=member.getBeizhu() != null ? member.getBeizhu() : ""%></textarea>
                    </div>
                    
                    <!-- 按钮区域 -->
                    <div class="form-actions">
                        <a href="<%=basePath%>huiyuanxinxi?action=list" class="btn btn-back">返回列表</a>
                        <button type="submit" class="btn btn-primary">💾 保存修改</button>
                        <button type="reset" class="btn btn-secondary">🔄 重置</button>
                    </div>
                </div>
            </div>
        </form>
    </div>
    
    <script>
        function checkHuiyuanbianhao() {
            var obj = document.getElementById("huiyuanbianhao");
            var errorDiv = document.getElementById("error-huiyuanbianhao");
            if (!obj.value || obj.value.trim() === "") {
                errorDiv.textContent = "请输入会员编号";
                errorDiv.style.display = "block";
                return false;
            } else {
                errorDiv.style.display = "none";
                return true;
            }
        }
        
        function checkMima() {
            var obj = document.getElementById("mima");
            var errorDiv = document.getElementById("error-mima");
            if (!obj.value || obj.value.trim() === "") {
                errorDiv.textContent = "请输入密码";
                errorDiv.style.display = "block";
                return false;
            } else {
                errorDiv.style.display = "none";
                return true;
            }
        }
        
        // 表单提交前验证
        document.getElementById("editForm").onsubmit = function() {
            var valid1 = checkHuiyuanbianhao();
            var valid2 = checkMima();
            return valid1 && valid2;
        };
    </script>
</body>
</html>
