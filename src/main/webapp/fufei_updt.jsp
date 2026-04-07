<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.badminton.entity.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>编辑付费信息</title>
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
            margin: 0 auto;
            padding: 30px 20px;
        }
        
        /* 表单卡片 */
        .form-card {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 15px rgba(0,0,0,0.1);
            overflow: hidden;
        }
        .form-header {
            background: linear-gradient(135deg, #ecf0f1, #bdc3c7);
            padding: 20px 30px;
            border-bottom: 3px solid #16a085;
        }
        .form-header h3 {
            color: #2c3e50;
            font-size: 18px;
            font-weight: 600;
        }
        .form-body {
            padding: 30px;
        }
        .form-row {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 25px;
            margin-bottom: 25px;
        }
        .form-group {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }
        .form-group.full-width {
            grid-column: 1 / -1;
        }
        .form-group label {
            font-weight: 600;
            color: #2c3e50;
            font-size: 14px;
        }
        .required {
            color: #e74c3c;
            margin-left: 3px;
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
        .form-control[readonly] {
            background: #f8f9fa;
            color: #666;
            cursor: not-allowed;
        }
        textarea.form-control {
            resize: vertical;
            min-height: 100px;
            font-family: inherit;
        }
        select.form-control {
            cursor: pointer;
        }
        .help-text {
            font-size: 13px;
            color: #7f8c8d;
            font-style: italic;
        }
        .amount-display {
            background: #e8f5e9;
            border-color: #16a085;
            color: #16a085;
            font-weight: 600;
            font-size: 16px;
        }
        
        /* 按钮区域 */
        .form-footer {
            background: #f8f9fa;
            padding: 20px 30px;
            display: flex;
            justify-content: center;
            gap: 15px;
            border-top: 1px solid #e0e0e0;
        }
        .btn {
            padding: 12px 35px;
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
        
        /* 响应式设计 */
        @media screen and (max-width: 768px) {
            .form-row {
                grid-template-columns: 1fr;
                gap: 20px;
            }
            .container {
                padding: 20px 15px;
            }
            .form-body {
                padding: 20px;
            }
        }
    </style>
</head>
<body>
    <%
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
        Fufei fee = (Fufei) request.getAttribute("fufei");
        if (fee == null) {
            response.sendRedirect("fufei?action=list");
            return;
        }
    %>
    
    <!-- 顶部标题 -->
    <div class="header">
        <h2>✏️ 编辑付费信息</h2>
    </div>
    
    <div class="container">
        <form action="<%=basePath%>fufei?action=update" method="post" id="editForm">
            <input type="hidden" name="id" value="<%=fee.getId()%>" />
            
            <div class="form-card">
                <div class="form-header">
                    <h3>📋 基本信息</h3>
                </div>
                
                <div class="form-body">
                    <div class="form-row">
                        <!-- 场地号（只读） -->
                        <div class="form-group">
                            <label>场地号</label>
                            <input type="text" name="qiuzhuohao" id="qiuzhuohao" 
                                   class="form-control" value="<%=fee.getQiuzhuohao() != null ? fee.getQiuzhuohao() : ""%>" readonly />
                            <small class="help-text">场地号不可修改</small>
                        </div>
                        
                        <!-- 每小时计费（只读） -->
                        <div class="form-group">
                            <label>每小时计费（元）</label>
                            <input type="number" name="meixiaoshijifei" id="meixiaoshijifei" 
                                   class="form-control" value="<%=fee.getMeixiaoshijifei() != null ? fee.getMeixiaoshijifei() : ""%>" readonly />
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <!-- 总时长（可编辑） -->
                        <div class="form-group">
                            <label>总时长（小时）<span class="required">*</span></label>
                            <input type="number" name="zongshichang" id="zongshichang" 
                                   class="form-control" value="<%=fee.getZongshichang() != null ? fee.getZongshichang() : "1"%>" 
                                   min="1" step="1" onchange="jisuan()" required />
                            <small class="help-text">修改时长后会自动重算金额</small>
                        </div>
                        
                        <!-- 会员编号（只读） -->
                        <div class="form-group">
                            <label>会员编号</label>
                            <input type="text" name="huiyuanbianhao" id="huiyuanbianhao" 
                                   class="form-control" value="<%=fee.getHuiyuanbianhao() != null ? fee.getHuiyuanbianhao() : ""%>" readonly />
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <!-- 姓名（只读） -->
                        <div class="form-group">
                            <label>姓名</label>
                            <input type="text" name="xingming" id="xingming" 
                                   class="form-control" value="<%=fee.getXingming() != null ? fee.getXingming() : ""%>" readonly />
                        </div>
                        
                        <!-- 会员等级（只读） -->
                        <div class="form-group">
                            <label>会员等级</label>
                            <input type="text" name="huiyuandengji" id="huiyuandengji" 
                                   class="form-control" value="<%=fee.getHuiyuandengji() != null ? fee.getHuiyuandengji() : ""%>" readonly />
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <!-- 折扣（只读） -->
                        <div class="form-group">
                            <label>折扣</label>
                            <input type="text" name="zhekou" id="zhekou" 
                                   class="form-control" value="<%=fee.getZhekou() != null ? fee.getZhekou() : "1.0"%>" readonly />
                        </div>
                        
                        <!-- 总金额（自动计算，只读） -->
                        <div class="form-group">
                            <label>总金额（元）</label>
                            <input type="text" name="zongjine" id="zongjine" 
                                   class="form-control amount-display" value="<%=fee.getZongjine() != null ? fee.getZongjine() : "0.00"%>" readonly />
                            <small class="help-text">💡 系统自动计算，无需手动填写</small>
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <!-- 是否支付（下拉选择） -->
                        <div class="form-group">
                            <label>支付状态 <span class="required">*</span></label>
                            <select name="issh" id="issh" class="form-control" required>
                                <option value="否" <%=fee.getIssh() != null && fee.getIssh().equals("否") ? "selected" : ""%>>未支付</option>
                                <option value="是" <%=fee.getIssh() != null && fee.getIssh().equals("是") ? "selected" : ""%>>已支付</option>
                            </select>
                        </div>
                        
                        <!-- 添加时间（只读） -->
                        <div class="form-group">
                            <label>添加时间</label>
                            <input type="text" name="addtime" id="addtime" 
                                   class="form-control" value="<%=fee.getAddtime() != null ? fee.getAddtime() : ""%>" readonly />
                        </div>
                    </div>
                    
                    <!-- 备注（全文本） -->
                    <div class="form-row">
                        <div class="form-group full-width">
                            <label>备注</label>
                            <textarea name="beizhu" id="beizhu" class="form-control" rows="4"><%=fee.getBeizhu() != null ? fee.getBeizhu() : ""%></textarea>
                        </div>
                    </div>
                </div>
                
                <!-- 按钮区域 -->
                <div class="form-footer">
                    <button type="submit" class="btn btn-primary">✅ 保存修改</button>
                    <button type="reset" class="btn btn-secondary">🔄 重置</button>
                    <a href="<%=basePath%>fufei?action=list" class="btn btn-secondary" style="text-decoration: none;">↩️ 返回列表</a>
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
        document.getElementById('editForm').onsubmit = function(e) {
            var zongshichang = document.getElementById("zongshichang").value;
            if (!zongshichang || parseInt(zongshichang) < 1) {
                alert('请输入有效的总时长（至少 1 小时）');
                e.preventDefault();
                return false;
            }
            
            jisuan(); // 提交前重新计算金额
            
            return true;
        };
    </script>
</body>
</html>
