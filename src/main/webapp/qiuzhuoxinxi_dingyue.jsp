<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.badminton.entity.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>管理员预定场地</title>
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
        .form-control[readonly] {
            background-color: #f8f9fa;
            cursor: not-allowed;
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
    </style>
</head>
<body>
    <%
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
        
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
        }
    %>
    
    <!-- 顶部标题 -->
    <div class="header">
        <h2>🏟️ 管理员预定场地</h2>
    </div>
    
    <div class="container">
        <form action="<%=basePath%>qiuzhuoxinxi?action=dingyue" method="post" id="bookForm">
            <input type="hidden" name="qiuzhuoid" value="<%=id != null ? id : ""%>" />
            
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
                                   class="form-control" value="<%=meixiaoshijifei != null && !meixiaoshijifei.isEmpty() ? meixiaoshijifei : "50"%>" 
                                   min="1" step="1" onchange="jisuan()" />
                            <small class="help-text">可根据实际情况调整，修改后会自动重算金额</small>
                        </div>
                    </div>
                    
                    <!-- 时间和会员信息 -->
                    <div class="form-row">
                        <div class="form-group">
                            <label>总时长（小时） <span class="required">*</span></label>
                            <input type="number" name="zongshichang" id="zongshichang" 
                                   class="form-control" value="1" min="1" step="1"
                                   required onblur="jisuan()" onchange="jisuan()" />
                            <small class="help-text">请输入预定时长</small>
                            <div id="error-zongshichang" class="error-msg"></div>
                        </div>
                        
                        <div class="form-group">
                            <label>订场时间</label>
                            <input type="text" name="dingzhuoshijian" id="dingzhuoshijian" 
                                   class="form-control" value="<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date())%>" readonly />
                            <small class="help-text">时间自动生成，无需填写</small>
                        </div>
                    </div>
                    
                    <!-- 会员信息 -->
                    <div class="form-row">
                        <div class="form-group">
                            <label>会员编号</label>
                            <input type="text" name="huiyuanbianhao" id="huiyuanbianhao" 
                                   class="form-control" placeholder="不填默认为游客" />
                            <small class="help-text">非会员可留空</small>
                        </div>
                        
                        <div class="form-group">
                            <label>姓名</label>
                            <input type="text" name="xingming" id="xingming" 
                                   class="form-control" placeholder="不填默认为游客" />
                        </div>
                    </div>
                    
                    <!-- 等级和折扣 -->
                    <div class="form-row">
                        <div class="form-group">
                            <label>会员等级</label>
                            <select name="huiyuandengji" id="huiyuandengji" 
                                    class="form-control" onchange="jisuan()">
                                <option value="无">无</option>
                                <option value="普通">普通</option>
                                <option value="黄金">黄金</option>
                                <option value="铂金">铂金</option>
                                <option value="砖石">砖石</option>
                            </select>
                        </div>
                        
                        <div class="form-group">
                            <label>折扣 <span style="color: #7f8c8d; font-weight: normal;">（1.0 表示无折扣，0.8 表示 8 折）</span></label>
                            <input type="number" name="zhekou" id="zhekou" 
                                   class="form-control" value="1.0" min="0.1" max="1.0" step="0.1"
                                   onblur="jisuan()" onchange="jisuan()" />
                        </div>
                    </div>
                    
                    <!-- 金额和支付状态 -->
                    <div class="form-row">
                        <div class="form-group">
                            <label>总金额（元）</label>
                            <input type="number" name="zongjine" id="zongjine" 
                                   class="form-control" readonly placeholder="自动计算" />
                            <small class="help-text">金额根据时长和折扣自动计算</small>
                        </div>
                        
                        <div class="form-group">
                            <label>是否支付</label>
                            <select name="issh" id="issh" class="form-control">
                                <option value="否">否</option>
                                <option value="是">是</option>
                            </select>
                        </div>
                    </div>
                    
                    <!-- 备注 -->
                    <div class="form-group">
                        <label>备注</label>
                        <textarea name="beizhu" id="beizhu" class="form-control" 
                                  placeholder="请输入备注信息（可选）"></textarea>
                    </div>
                    
                    <!-- 按钮区域 -->
                    <div class="form-actions">
                        <a href="<%=basePath%>qiuzhuoxinxi?action=list" class="btn btn-back">返回列表</a>
                        <button type="submit" class="btn btn-primary">✅ 确认预定</button>
                        <button type="reset" class="btn btn-secondary">🔄 重置</button>
                    </div>
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
        
        // 验证总时长
        function checkZongshichang() {
            var obj = document.getElementById("zongshichang");
            var errorDiv = document.getElementById("error-zongshichang");
            var value = obj.value.trim();
            
            if (!value || value === "") {
                errorDiv.textContent = "请输入总时长";
                errorDiv.style.display = "block";
                return false;
            } else if (parseFloat(value) <= 0) {
                errorDiv.textContent = "总时长必须大于 0";
                errorDiv.style.display = "block";
                return false;
            } else {
                errorDiv.style.display = "none";
                return true;
            }
        }
        
        // 表单提交前验证
        document.getElementById("bookForm").onsubmit = function() {
            return checkZongshichang();
        };
        
        // 页面加载时计算一次
        window.onload = function() {
            jisuan();
        };
    </script>
</body>
</html>
