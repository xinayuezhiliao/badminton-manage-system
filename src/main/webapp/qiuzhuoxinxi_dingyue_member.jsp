<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.badminton.entity.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>预定场地 - 会员端</title>
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
            max-width: 1000px;
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
            .form-row {
                grid-template-columns: 1fr;
            }
        }
        
        /* 金额显示框 */
        .amount-display {
            background: #e8f5e9;
            border-color: #16a085;
            color: #16a085;
            font-weight: 700;
            font-size: 18px;
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
        
        // 获取场地 ID
        String id = request.getParameter("id");
        String qiuzhuohao = "";
        String meixiaoshijifei = "";
        
        // 如果提供了 ID，需要从数据库读取场地信息
        if (id != null && !id.isEmpty()) {
            // 使用 Bean 查询数据库
            com.badminton.util.db dbBean = new com.badminton.util.db();
            qiuzhuohao = dbBean.readzd("qiuzhuoxinxi", "qiuzhuohao", "id", id);
            meixiaoshijifei = dbBean.readzd("qiuzhuoxinxi", "meixiaoshijifei", "id", id);
            
            // 查询会员详细信息
            try {
                com.badminton.service.HuiyuanxinxiService memberService = new com.badminton.service.impl.HuiyuanxinxiServiceImpl();
                Huiyuanxinxi member = memberService.getByHuiyuanbianhao(huiyuanbianhao);
                if (member != null) {
                    request.setAttribute("member", member);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        
        Huiyuanxinxi member = (Huiyuanxinxi) request.getAttribute("member");
        String xingming = member != null && member.getXingming() != null ? member.getXingming() : "";
        String huiyuandengji = member != null && member.getHuiyuandengji() != null ? member.getHuiyuandengji() : "";
        String zhekou = member != null && member.getZhekou() != null ? member.getZhekou() : "1.0";
    %>
    
    <!-- 顶部标题 -->
    <div class="header">
        <h2>🏟️ 会员预定场地</h2>
    </div>
    
    <div class="container">
        <% String error = (String) request.getAttribute("error");
           if (error != null && !error.isEmpty()) { %>
        <div style="background: #ffebee; border: 1px solid #f44336; color: #c62828; padding: 15px; border-radius: 6px; margin-bottom: 20px; text-align: center;">
            <strong>❌ 预定失败：</strong><%=error%>
        </div>
        <% } %>

        <form action="<%=basePath%>dingzhuoxinxi?action=addMember" method="post" id="bookForm">
            <input type="hidden" name="qiuzhuoid" value="<%=id != null ? id : ""%>" />
            <input type="hidden" name="huiyuanbianhao" value="<%=huiyuanbianhao%>" />
            
            <div class="form-card">
                <div class="form-header">
                    📋 填写预定信息
                </div>
                
                <div class="form-body">
                    <!-- 场地基本信息 -->
                    <div class="form-row">
                        <div class="form-group">
                            <label>场地号</label>
                            <input type="text" name="qiuzhuohao" id="qiuzhuohao" 
                                   class="form-control" value="<%=qiuzhuohao%>" readonly />
                            <small class="help-text">场地号自动填充，不可修改</small>
                        </div>
                        
                        <div class="form-group">
                            <label>每小时计费（元）</label>
                            <input type="number" name="meixiaoshijifei" id="meixiaoshijifei" 
                                   class="form-control" value="<%=meixiaoshijifei != null && !meixiaoshijifei.isEmpty() ? meixiaoshijifei : "0"%>" readonly />
                            <small class="help-text">计费标准由系统设定</small>
                        </div>
                    </div>
                    
                    <!-- 时长选择 -->
                    <div class="form-row">
                        <div class="form-group">
                            <label>总时长（小时）<span class="required">*</span></label>
                            <input type="number" name="zongshichang" id="zongshichang" 
                                   class="form-control" value="1" min="1" max="24" onchange="jisuan()" required />
                            <small class="help-text">请选择 1-24 小时</small>
                        </div>
                        
                        <div class="form-group">
                            <label>折扣</label>
                            <input type="text" name="zhekou" id="zhekou" 
                                   class="form-control" value="<%=zhekou%>" readonly />
                            <small class="help-text">根据您的会员等级自动享受折扣</small>
                        </div>
                    </div>
                    
                    <!-- 会员信息 -->
                    <div class="form-row">
                        <div class="form-group">
                            <label>会员编号</label>
                            <input type="text" name="huiyuanbianhao_display" id="huiyuanbianhao_display" 
                                   class="form-control" value="<%=huiyuanbianhao%>" readonly />
                        </div>
                        
                        <div class="form-group">
                            <label>姓名</label>
                            <input type="text" name="xingming" id="xingming" 
                                   class="form-control" value="<%=xingming%>" readonly />
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label>会员等级</label>
                            <input type="text" name="huiyuandengji" id="huiyuandengji" 
                                   class="form-control" value="<%=huiyuandengji%>" readonly />
                        </div>
                        
                        <div class="form-group">
                            <label>当前余额（元）</label>
                            <input type="text" name="yue" id="yue"
                                   class="form-control" value="<%=member != null && member.getYue() != null ? member.getYue() : "0.00"%>" readonly />
                            <small class="help-text">💰 您的账户余额</small>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label>总金额（元）</label>
                            <input type="text" name="zongjine" id="zongjine" 
                                   class="form-control amount-display" value="0.00" readonly />
                            <small class="help-text">💡 系统自动计算，无需手动填写</small>
                        </div>
                    </div>
                    
                    <!-- 备注 -->
                    <div class="form-group">
                        <label>备注</label>
                        <textarea name="beizhu" id="beizhu" class="form-control" rows="4" 
                                  placeholder="请输入备注信息（选填）"></textarea>
                    </div>
                    
                    <!-- 提示信息 -->
                    <div style="background: #e8f5e9; border-left: 4px solid #16a085; padding: 15px; margin-top: 20px; border-radius: 6px;">
                        <p style="color: #2c3e50; margin: 0;">
                            <strong>💡 温馨提示：</strong>
                        </p>
                        <ul style="color: #555; margin: 8px 0 0 20px; padding: 0;">
                            <li>提交预定后，将从您的余额中直接扣款</li>
                            <li>场地状态将变为"已订"</li>
                            <li>请按时到达场地，超时可能影响后续使用</li>
                            <li>如需取消预定，请联系管理员</li>
                            <li>如余额不足，请先充值后再预定</li>
                        </ul>
                    </div>
                </div>
                
                <!-- 按钮区域 -->
                <div class="form-actions">
                    <button type="submit" class="btn btn-primary">✅ 确认预定</button>
                    <button type="reset" class="btn btn-secondary" onclick="jisuan()">🔄 重置</button>
                    <a href="<%=basePath%>qiuzhuoxinxi?action=list2" class="btn btn-back">↩️ 返回列表</a>
                </div>
            </div>
        </form>
    </div>
    
    <script>
        // 自动计算总金额
        function jisuan() {
            var meixiaoshijifei = document.getElementById("meixiaoshijifei").value;
            var zongshichang = document.getElementById("zongshichang").value;
            var zhekou = document.getElementById("zhekou").value;
            
            if (meixiaoshijifei && zongshichang && zhekou) {
                var meixiaoshijifeiNum = parseFloat(meixiaoshijifei);
                var zongshichangNum = parseFloat(zongshichang);
                var zhekouNum = parseFloat(zhekou);
                
                if (!isNaN(meixiaoshijifeiNum) && !isNaN(zongshichangNum) && !isNaN(zhekouNum)) {
                    var zongjine = meixiaoshijifeiNum * zongshichangNum * zhekouNum;
                    document.getElementById("zongjine").value = zongjine.toFixed(2);
                }
            }
        }
        
        // 页面加载时计算一次
        window.onload = function() {
            jisuan();
        };
        
        // 表单验证
        document.getElementById('bookForm').onsubmit = function(e) {
            var zongshichang = document.getElementById("zongshichang").value;
            if (!zongshichang || parseInt(zongshichang) < 1 || parseInt(zongshichang) > 24) {
                alert('请输入有效的总时长（1-24 小时）');
                e.preventDefault();
                return false;
            }
            
            jisuan(); // 提交前重新计算金额
            
            return true;
        };
    </script>
</body>
</html>
