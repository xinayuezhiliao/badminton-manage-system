<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.badminton.entity.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>编辑场地信息</title>
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
        Qiuzhuoxinxi court = (Qiuzhuoxinxi) request.getAttribute("qiuzhuoxinxi");
        if (court == null) {
            response.sendRedirect("qiuzhuoxinxi?action=list");
            return;
        }
    %>
    
    <!-- 顶部标题 -->
    <div class="header">
        <h2>✏️ 编辑场地信息</h2>
    </div>
    
    <div class="container">
        <form action="<%=basePath%>qiuzhuoxinxi?action=update" method="post" id="editForm">
            <input type="hidden" name="id" value="<%=court.getId()%>" />
            
            <div class="form-card">
                <div class="form-header">
                    📋 基本信息
                </div>
                
                <div class="form-body">
                    <!-- 场地号 -->
                    <div class="form-group">
                        <label>场地号 <span class="required">*</span></label>
                        <input type="text" name="qiuzhuohao" id="qiuzhuohao" 
                               class="form-control" value="<%=court.getQiuzhuohao() != null ? court.getQiuzhuohao() : ""%>"
                               required onblur="checkQiuzhuohao()" />
                        <div id="error-qiuzhuohao" class="error-msg"></div>
                    </div>
                    
                    <!-- 状态 -->
                    <div class="form-group">
                        <label>状态 <span class="required">*</span></label>
                        <select name="zhuangtai" id="zhuangtai" class="form-control" required>
                            <option value="">请选择状态</option>
                            <option value="空闲" <%="空闲".equals(court.getZhuangtai()) ? "selected" : ""%>>空闲</option>
                            <option value="已订" <%="已订".equals(court.getZhuangtai()) ? "selected" : ""%>>已订</option>
                        </select>
                        <div id="error-zhuangtai" class="error-msg"></div>
                    </div>
                    
                    <!-- 每小时计费 -->
                    <div class="form-group">
                        <label>每小时计费</label>
                        <input type="text" name="meixiaoshijifei" id="meixiaoshijifei" 
                               class="form-control" value="<%=court.getMeixiaoshijifei() != null ? court.getMeixiaoshijifei() : ""%>" />
                    </div>
                    
                    <!-- 备注 -->
                    <div class="form-group">
                        <label>备注</label>
                        <textarea name="beizhu" id="beizhu" class="form-control"><%=court.getBeizhu() != null ? court.getBeizhu() : ""%></textarea>
                    </div>
                    
                    <!-- 按钮区域 -->
                    <div class="form-actions">
                        <a href="<%=basePath%>qiuzhuoxinxi?action=list" class="btn btn-back">返回列表</a>
                        <button type="submit" class="btn btn-primary">💾 保存修改</button>
                        <button type="reset" class="btn btn-secondary">🔄 重置</button>
                    </div>
                </div>
            </div>
        </form>
    </div>
    
    <script>
        function checkQiuzhuohao() {
            var obj = document.getElementById("qiuzhuohao");
            var errorDiv = document.getElementById("error-qiuzhuohao");
            if (!obj.value || obj.value.trim() === "") {
                errorDiv.textContent = "请输入场地号";
                errorDiv.style.display = "block";
                return false;
            } else {
                errorDiv.style.display = "none";
                return true;
            }
        }
        
        function checkZhuangtai() {
            var obj = document.getElementById("zhuangtai");
            var errorDiv = document.getElementById("error-zhuangtai");
            if (!obj.value || obj.value.trim() === "") {
                errorDiv.textContent = "请选择状态";
                errorDiv.style.display = "block";
                return false;
            } else {
                errorDiv.style.display = "none";
                return true;
            }
        }
        
        // 表单提交前验证
        document.getElementById("editForm").onsubmit = function() {
            var valid1 = checkQiuzhuohao();
            var valid2 = checkZhuangtai();
            return valid1 && valid2;
        };
    </script>
</body>
</html>
