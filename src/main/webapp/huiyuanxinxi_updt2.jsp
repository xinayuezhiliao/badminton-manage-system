<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.badminton.entity.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>修改个人资料 - 会员端</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { 
            font-family: 'Microsoft YaHei', Arial, sans-serif; 
            background: #f5f6fa;
            min-height: 100vh;
            padding-top: 60px;
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
            max-width: 800px;
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
            background: linear-gradient(135deg, #16a085, #1abc9c);
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
            border-color: #16a085;
            box-shadow: 0 0 0 3px rgba(22,160,133,0.1);
        }
        .form-control[readonly] {
            background-color: #f8f9fa;
            cursor: not-allowed;
            color: #666;
        }
        .required {
            color: #e74c3c;
            margin-left: 5px;
        }
        .help-text {
            color: #7f8c8d;
            font-size: 13px;
            margin-top: 6px;
            display: block;
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
            background: linear-gradient(135deg, #16a085, #1abc9c);
            color: white;
        }
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(22,160,133,0.3);
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
            background: #3498db;
            color: white;
            text-decoration: none;
            display: inline-block;
        }
        .btn-back:hover {
            background: #2980b9;
            transform: translateY(-2px);
        }
        
        /* 两列布局 */
        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }
        @media (max-width: 768px) {
            body {
                padding-top: 60px !important; /* 🔥 手机端也要留出导航栏空间 */
            }
            .form-row {
                grid-template-columns: 1fr;
            }
        }
        
        /* 性别单选框样式 */
        .radio-group {
            display: flex;
            gap: 20px;
            padding: 10px 0;
        }
        .radio-option {
            display: flex;
            align-items: center;
            gap: 8px;
            cursor: pointer;
        }
        .radio-option input[type="radio"] {
            width: 18px;
            height: 18px;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <%
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
        
        // 获取当前登录会员的信息
        String huiyuanbianhao = (String) request.getSession().getAttribute("username");
        if (huiyuanbianhao == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        Huiyuanxinxi member = (Huiyuanxinxi) request.getAttribute("huiyuanxinxi");
        if (member == null) {
            response.sendRedirect("error.jsp");
            return;
        }
    %>
    
    <!-- 顶部标题 -->
    <div class="header">
        <h2>👤 修改个人资料</h2>
    </div>
    
    <div class="container">
        <form action="<%=basePath%>huiyuanxinxi?action=update2" method="post" id="updateForm">
            <input type="hidden" name="id" value="${huiyuanxinxi.id}" />
            
            <div class="form-card">
                <div class="form-header">
                    📋 填写个人信息
                </div>
                
                <div class="form-body">
                    <!-- 会员编号（只读） -->
                    <div class="form-group">
                        <label>会员编号</label>
                        <input type="text" name="huiyuanbianhao" id="huiyuanbianhao" 
                               class="form-control" value="<%=member.getHuiyuanbianhao()%>" readonly />
                        <small class="help-text">会员编号不可修改</small>
                    </div>
                    
                    <!-- 密码和姓名 -->
                    <div class="form-row">
                        <div class="form-group">
                            <label>密码<span class="required">*</span></label>
                            <input type="password" name="mima" id="mima" 
                                   class="form-control" value="<%=member.getMima()%>" required />
                            <small class="help-text">请输入您的登录密码</small>
                        </div>
                        
                        <div class="form-group">
                            <label>姓名<span class="required">*</span></label>
                            <input type="text" name="xingming" id="xingming" 
                                   class="form-control" value="<%=member.getXingming()%>" required />
                        </div>
                    </div>
                    
                    <!-- 性别和会员等级 -->
                    <div class="form-row">
                        <div class="form-group">
                            <label>性别</label>
                            <div class="radio-group">
                                <label class="radio-option">
                                    <input type="radio" name="xingbie" value="男" 
                                           <%= "男".equals(member.getXingbie()) ? "checked" : "" %> />
                                    <span>男</span>
                                </label>
                                <label class="radio-option">
                                    <input type="radio" name="xingbie" value="女" 
                                           <%= "女".equals(member.getXingbie()) ? "checked" : "" %> />
                                    <span>女</span>
                                </label>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label>会员等级</label>
                            <input type="text" name="huiyuandengji" id="huiyuandengji" 
                                   class="form-control" value="<%=member.getHuiyuandengji()%>" readonly />
                            <small class="help-text">会员等级由系统设定</small>
                        </div>
                    </div>
                    
                    <!-- 折扣和手机 -->
                    <div class="form-row">
                        <div class="form-group">
                            <label>折扣</label>
                            <input type="text" name="zhekou" id="zhekou" 
                                   class="form-control" value="<%=member.getZhekou()%>" readonly />
                            <small class="help-text">根据您的会员等级自动享受折扣</small>
                        </div>
                        
                        <div class="form-group">
                            <label>手机<span class="required">*</span></label>
                            <input type="tel" name="shouji" id="shouji" 
                                   class="form-control" value="<%=member.getShouji()%>" 
                                   pattern="[0-9]{11}" required />
                            <small class="help-text">请输入 11 位手机号码</small>
                        </div>
                    </div>
                    
                    <!-- 余额和备注 -->
                    <div class="form-row">
                        <div class="form-group">
                            <label>当前余额（元）</label>
                            <input type="text" name="yue" id="yue"
                                   class="form-control" value="<%=member.getYue() != null ? member.getYue() : "0.00"%>" readonly />
                            <small class="help-text">💰 您的账户余额</small>
                        </div>
                    </div>

                    <div class="form-group">
                        <label>备注</label>
                        <textarea name="beizhu" id="beizhu" class="form-control" rows="4" 
                                  placeholder="请输入备注信息（选填）"><%=member.getBeizhu() != null ? member.getBeizhu() : ""%></textarea>
                    </div>
                    
                    <!-- 提示信息 -->
                    <div style="background: #e8f5e9; border-left: 4px solid #16a085; padding: 15px; margin-top: 20px; border-radius: 6px;">
                        <p style="color: #2c3e50; margin: 0;">
                            <strong>💡 温馨提示：</strong>
                        </p>
                        <ul style="color: #555; margin: 8px 0 0 20px; padding: 0;">
                            <li>请确保填写的信息真实准确</li>
                            <li>会员编号、会员等级和折扣不可修改</li>
                            <li>修改后请点击"保存修改"按钮</li>
                            <li>如需注销账号，请联系管理员</li>
                        </ul>
                    </div>
                </div>
                
                <!-- 按钮区域 -->
                <div class="form-actions">
                    <button type="submit" class="btn btn-primary">✅ 保存修改</button>
                    <button type="reset" class="btn btn-secondary">🔄 重置</button>
                    <a href="<%=basePath%>index.jsp" class="btn btn-back">↩️ 返回首页</a>
                </div>
            </div>
        </form>
    </div>
    
    <script>
        // 表单验证
        document.getElementById('updateForm').onsubmit = function(e) {
            var mima = document.getElementById("mima").value;
            var xingming = document.getElementById("xingming").value;
            var shouji = document.getElementById("shouji").value;
            
            // 验证密码
            if (!mima || mima.trim() === "") {
                alert('请输入密码');
                e.preventDefault();
                return false;
            }
            
            // 验证姓名
            if (!xingming || xingming.trim() === "") {
                alert('请输入姓名');
                e.preventDefault();
                return false;
            }
            
            // 验证手机号
            if (!shouji || shouji.trim() === "") {
                alert('请输入手机号');
                e.preventDefault();
                return false;
            }
            
            var shoujiPattern = /^[0-9]{11}$/;
            if (!shoujiPattern.test(shouji)) {
                alert('请输入正确的 11 位手机号码');
                e.preventDefault();
                return false;
            }
            
            return true;
        };
    </script>
</body>
</html>
