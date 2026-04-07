<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.badminton.entity.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>精准查询 - 付费信息</title>
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
            max-width: 1400px;
            margin: 0 auto;
            padding: 30px 20px;
        }
        
        /* 搜索框区域 */
        .search-box {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 15px rgba(0,0,0,0.1);
            margin-bottom: 25px;
        }
        .search-form {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
            align-items: end;
        }
        .form-group {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }
        .form-group label {
            font-weight: 600;
            color: #2c3e50;
            font-size: 14px;
        }
        .search-input {
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 6px;
            font-size: 15px;
            transition: all 0.3s;
        }
        .search-input:focus {
            outline: none;
            border-color: #3498db;
            box-shadow: 0 0 0 3px rgba(52,152,219,0.1);
        }
        .search-select {
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 6px;
            font-size: 15px;
            background: white;
            cursor: pointer;
        }
        .search-btn {
            padding: 12px 35px;
            background: linear-gradient(135deg, #3498db, #2980b9);
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 15px;
            font-weight: 600;
            transition: all 0.3s;
            height: 48px;
        }
        .search-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(52,152,219,0.3);
        }
        .back-btn {
            padding: 12px 35px;
            background: #95a5a6;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            display: inline-block;
            font-size: 15px;
            font-weight: 600;
            transition: all 0.3s;
            height: 48px;
            line-height: 24px;
        }
        .back-btn:hover {
            background: #7f8c8d;
            transform: translateY(-2px);
        }
        
        /* 结果区域 */
        .result-box {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 15px rgba(0,0,0,0.1);
            overflow: hidden;
        }
        .result-header {
            background: linear-gradient(135deg, #3498db, #2980b9);
            color: white;
            padding: 20px 30px;
            font-size: 18px;
            font-weight: 600;
        }
        .result-info {
            padding: 20px 30px;
            background: #f8f9fa;
            border-bottom: 2px solid #e0e0e0;
            color: #555;
            font-size: 15px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        thead {
            background: linear-gradient(135deg, #ecf0f1, #bdc3c7);
        }
        th {
            padding: 18px 12px;
            text-align: center;
            font-weight: 600;
            color: #2c3e50;
            border-bottom: 2px solid #bdc3c7;
            font-size: 14px;
        }
        td {
            padding: 15px 12px;
            text-align: center;
            border-bottom: 1px solid #ecf0f1;
            color: #333;
            font-size: 14px;
        }
        tr:hover {
            background: #f8f9fa;
        }
        .amount-cell {
            font-weight: 600;
            color: #16a085;
            font-size: 15px;
        }
        .status-badge {
            display: inline-block;
            padding: 6px 12px;
            border-radius: 5px;
            font-size: 13px;
            font-weight: 500;
        }
        .status-paid {
            background: #d4edda;
            color: #155724;
        }
        .status-unpaid {
            background: #fff3cd;
            color: #856404;
        }
        .action-btn {
            display: inline-block;
            padding: 8px 18px;
            margin: 0 5px;
            border-radius: 5px;
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            transition: all 0.3s;
        }
        .edit-btn {
            background: #16a085;
            color: white;
        }
        .edit-btn:hover {
            background: #1abc9c;
            transform: translateY(-2px);
        }
        .delete-btn {
            background: #e74c3c;
            color: white;
        }
        .delete-btn:hover {
            background: #c0392b;
            transform: translateY(-2px);
        }
        .empty-state {
            text-align: center;
            padding: 80px 20px;
            color: #95a5a6;
        }
        .empty-state .icon {
            font-size: 80px;
            margin-bottom: 20px;
        }
        .empty-state p {
            font-size: 18px;
            margin-bottom: 25px;
        }
        .summary-footer {
            background: linear-gradient(135deg, #16a085, #1abc9c);
            color: white;
            padding: 25px 30px;
            text-align: right;
            font-size: 18px;
            font-weight: 600;
            margin-top: 20px;
            border-radius: 10px;
        }
        .summary-footer .amount {
            font-size: 28px;
            margin-left: 15px;
        }
    </style>
</head>
<body>
    <%
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
        
        // 获取搜索关键词
        String searchKeyQiu = (String) request.getAttribute("searchKeyQiu");
        String searchKeyHui = (String) request.getAttribute("searchKeyHui");
        String searchKeyIssh = (String) request.getAttribute("searchKeyIssh");
        if (searchKeyQiu == null) searchKeyQiu = "";
        if (searchKeyHui == null) searchKeyHui = "";
        if (searchKeyIssh == null) searchKeyIssh = "";
    %>
    
    <!-- 顶部标题 -->
    <div class="header">
        <h2>💰 付费信息精准查询</h2>
    </div>
    
    <div class="container">
        <!-- 搜索框 -->
        <div class="search-box">
            <form action="<%=basePath%>fufei?action=doSearch" method="post" class="search-form">
                <div class="form-group">
                    <label>场地号：</label>
                    <input type="text" name="qiuzhuohao" class="search-input" 
                           placeholder="请输入场地号（如：001、A01）" 
                           value="<%=searchKeyQiu%>" />
                </div>
                <div class="form-group">
                    <label>会员编号：</label>
                    <input type="text" name="huiyuanbianhao" class="search-input" 
                           placeholder="请输入会员编号（如：A001）" 
                           value="<%=searchKeyHui%>" />
                </div>
                <div class="form-group">
                    <label>支付状态：</label>
                    <select name="issh" class="search-select">
                        <option value="">全部</option>
                        <option value="是" <%=searchKeyIssh.equals("是") ? "selected" : ""%>>已支付</option>
                        <option value="否" <%=searchKeyIssh.equals("否") ? "selected" : ""%>>未支付</option>
                    </select>
                </div>
                <div style="display: flex; gap: 15px; grid-column: 1 / -1;">
                    <button type="submit" class="search-btn">🔍 查询</button>
                    <a href="<%=basePath%>fufei?action=list" class="back-btn">返回列表</a>
                </div>
            </form>
        </div>
        
        <!-- 结果展示 -->
        <div class="result-box">
            <%
                List<Fufei> feeList = (List<Fufei>) request.getAttribute("fufeiList");
                
                if (feeList != null && !feeList.isEmpty()) {
                    // 计算总金额
                    double totalAmount = 0;
                    for (Fufei fee : feeList) {
                        if (fee.getZongjine() != null && !fee.getZongjine().isEmpty()) {
                            try {
                                totalAmount += Double.parseDouble(fee.getZongjine());
                            } catch (NumberFormatException e) {
                                // 忽略格式错误
                            }
                        }
                    }
            %>
                <div class="result-header">
                    📋 查询结果
                </div>
                <div class="result-info">
                    🔍 搜索条件：
                    <% if (!searchKeyQiu.isEmpty()) { %>
                        场地号="<strong><%=searchKeyQiu%></strong>"
                    <% } %>
                    <% if (!searchKeyHui.isEmpty()) { %>
                        <%=searchKeyQiu.isEmpty() ? "" : " & " %>会员编号="<strong><%=searchKeyHui%></strong>"
                    <% } %>
                    <% if (!searchKeyIssh.isEmpty()) { %>
                        <%= (searchKeyQiu.isEmpty() && searchKeyHui.isEmpty()) ? "" : " & " %>支付状态="<strong>
                        <%=searchKeyIssh.equals("是") ? "已支付" : "未支付"%></strong>"
                    <% } %>
                    &nbsp;&nbsp;|&nbsp;&nbsp; 
                    📊 共找到 <strong style="color: #16a085;"><%=feeList.size()%></strong> 条记录
                </div>
                <table>
                    <thead>
                        <tr>
                            <th width="5%">序号</th>
                            <th width="10%">场地号</th>
                            <th width="9%">每小时计费</th>
                            <th width="8%">总时长</th>
                            <th width="10%">会员编号</th>
                            <th width="8%">姓名</th>
                            <th width="9%">会员等级</th>
                            <th width="7%">折扣</th>
                            <th width="10%">总金额</th>
                            <th width="8%">支付状态</th>
                            <th width="12%">添加时间</th>
                            <th width="14%">操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            for (int j = 0; j < feeList.size(); j++) {
                                Fufei u = feeList.get(j);
                                if (u == null) continue;
                        %>
                        <tr>
                            <td><%=(j+1)%></td>
                            <td><%=u.getQiuzhuohao() != null ? u.getQiuzhuohao() : ""%></td>
                            <td><%=u.getMeixiaoshijifei() != null ? u.getMeixiaoshijifei() : ""%></td>
                            <td><%=u.getZongshichang() != null ? u.getZongshichang() : ""%></td>
                            <td><%=u.getHuiyuanbianhao() != null ? u.getHuiyuanbianhao() : ""%></td>
                            <td><%=u.getXingming() != null ? u.getXingming() : ""%></td>
                            <td><%=u.getHuiyuandengji() != null ? u.getHuiyuandengji() : ""%></td>
                            <td><%=u.getZhekou() != null ? u.getZhekou() : ""%></td>
                            <td class="amount-cell"><%=u.getZongjine() != null ? u.getZongjine() : ""%></td>
                            <td>
                                <% if ("是".equals(u.getIssh())) { %>
                                <span class="status-badge status-paid">已支付</span>
                                <% } else { %>
                                <span class="status-badge status-unpaid">未支付</span>
                                <% } %>
                            </td>
                            <td><%=u.getAddtime() != null ? u.getAddtime() : ""%></td>
                            <td>
                                <% if (u.getId() != null) { %>
                                <a href="<%=basePath%>fufei?action=toUpdate&id=<%=u.getId()%>" 
                                   class="action-btn edit-btn">编辑</a>
                                <a href="<%=basePath%>fufei?action=delete&id=<%=u.getId()%>" 
                                   class="action-btn delete-btn" 
                                   onclick="return confirm('确定要删除吗？')">删除</a>
                                <% } %>
                            </td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
                
                <!-- 统计总金额 -->
                <div class="summary-footer">
                    💰 当前查询结果总金额：<span class="amount">¥<%=String.format("%.2f", totalAmount)%></span>
                </div>
            <%
                } else {
            %>
                <div class="empty-state">
                    <div class="icon">😕</div>
                    <p>未找到符合条件的付费信息</p>
                    <p style="font-size: 15px; color: #7f8c8d;">请检查输入的场地号、会员编号或支付状态是否正确，或尝试其他关键词</p>
                </div>
            <%
                }
            %>
        </div>
    </div>
</body>
</html>
