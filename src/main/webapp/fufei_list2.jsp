<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" import="java.sql.*" %>
<jsp:useBean id="connDbBean" scope="page" class="com.badminton.util.db"/>
<%@ page isELIgnored="false" %>

<script type="text/javascript" src="js/My97DatePicker/WdatePicker.js" charset="gb2312"></script>
<script type="text/javascript" src="js/popup.js"></script>
<script type="text/javascript" src="js/jquery-1.11.0.min.js"></script>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>我的付费 - 羽毛球球馆管理系统</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/static/css/beautify.css" />
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { 
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", "Microsoft YaHei", sans-serif; 
            background: #f5f7fa;
            min-height: 100vh;
            padding-top: 80px; /*  留出顶部导航栏空间（60px）+ 额外间距（20px） */
        }
        
        .container {
            max-width: 1400px;
            margin: 0 auto;
        }
        
        .page-header {
            background: linear-gradient(135deg, #16a085 0%, #1abc9c 100%);
            color: white;
            padding: 20px 25px;
            border-radius: 12px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.15);
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .page-header h2 {
            font-size: 24px;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .page-header h2::before {
            content: "💰";
            font-size: 32px;
        }
        
        .search-card {
            background: white;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }
        .search-title {
            font-size: 16px;
            font-weight: 600;
            color: #2c3e50;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .search-title::before {
            content: "🔍";
            font-size: 22px;
        }
        .search-form {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
            align-items: end;
        }
        .form-group {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }
        .form-group label {
            font-weight: 500;
            color: #555;
            font-size: 14px;
        }
        .form-group input {
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 14px;
            transition: all 0.3s;
        }
        .form-group input:focus {
            outline: none;
            border-color: #16a085;
            box-shadow: 0 0 0 3px rgba(22, 160, 133, 0.1);
        }
        .btn-search {
            padding: 12px 35px;
            background: linear-gradient(135deg, #3498db, #2980b9);
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 15px;
            font-weight: 600;
            transition: all 0.3s;
            height: 48px;
        }
        .btn-search:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(52,152,219,0.3);
        }
        
        .data-card {
            background: white;
            border-radius: 12px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.1);
            overflow: hidden;
            margin-bottom: 20px;
        }
        .table-container {
            overflow-x: auto;
        }
        .data-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 14px;
        }
        .data-table thead {
            background: linear-gradient(135deg, #16a085 0%, #1abc9c 100%);
            color: white;
        }
        .data-table th {
            padding: 12px 10px;
            text-align: center;
            font-weight: 600;
            font-size: 14px;
            white-space: nowrap;
        }
        .data-table td {
            padding: 12px 10px;
            text-align: center;
            border-bottom: 1px solid #eee;
            color: #333;
        }
        .data-table tbody tr {
            transition: all 0.3s;
        }
        .data-table tbody tr:nth-child(even) {
            background-color: #fafbfc;
        }
        .data-table tbody tr:hover {
            background-color: #f0f7f5;
            transform: scale(1.01);
        }
        
        .status-badge {
            display: inline-block;
            padding: 6px 14px;
            border-radius: 6px;
            font-size: 13px;
            font-weight: 600;
        }
        .status-paid {
            background: linear-gradient(135deg, #d4edda, #c3e6cb);
            color: #155724;
        }
        .status-unpaid {
            background: linear-gradient(135deg, #fff3cd, #ffeaa7);
            color: #856404;
        }
        
        .amount-cell {
            font-weight: 700;
            color: #16a085;
            font-size: 15px;
        }
        
        .summary-footer {
            background: linear-gradient(135deg, #16a085 0%, #1abc9c 100%);
            color: white;
            padding: 15px 25px;
            border-radius: 12px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 15px;
        }
        .summary-total {
            font-size: 22px;
            font-weight: 700;
        }
        
        .pagination {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin-top: 25px;
        }
        .pagination a {
            padding: 10px 20px;
            background: white;
            color: #16a085;
            border: 2px solid #16a085;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s;
        }
        .pagination a:hover {
            background: #16a085;
            color: white;
            transform: translateY(-2px);
        }
        
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #95a5a6;
        }
        .empty-state .icon {
            font-size: 80px;
            margin-bottom: 20px;
        }
        
        @media screen and (max-width: 768px) {
            body { 
                padding-top: 80px !important; /* 🔥 手机端也要留出导航栏空间 */
                padding-left: 10px;
                padding-right: 10px;
                padding-bottom: 10px;
            }
            .page-header { 
                flex-direction: column; 
                gap: 12px;
                padding: 15px 20px;
            }
            .page-header h2 {
                font-size: 20px;
            }
            .search-form { grid-template-columns: 1fr; }
            .data-table { font-size: 12px; }
            .data-table th, .data-table td { 
                padding: 10px 8px;
            }
            .summary-footer {
                flex-direction: column;
                gap: 10px;
                text-align: center;
            }
        }

    </style>
</head>
<body>
    <div class="container content-wrapper">
        <!-- 统计信息（移到顶部） -->
        <%
			String sql="select * from fufei where huiyuanbianhao='"+(String)request.getSession().getAttribute("username")+"'  ";
				
if(request.getParameter("qiuzhuohao")=="" ||request.getParameter("qiuzhuohao")==null ){}else{String nqiuzhuohao=new String(request.getParameter("qiuzhuohao").getBytes("8859_1"));if(nqiuzhuohao.contains("?")){nqiuzhuohao=request.getParameter("qiuzhuohao");}sql=sql+" and qiuzhuohao like '%"+nqiuzhuohao+"%'";}  
if(request.getParameter("meixiaoshijifei")=="" ||request.getParameter("meixiaoshijifei")==null ){}else{String nmeixiaoshijifei=new String(request.getParameter("meixiaoshijifei").getBytes("8859_1"));if(nmeixiaoshijifei.contains("?")){nmeixiaoshijifei=request.getParameter("meixiaoshijifei");}sql=sql+" and meixiaoshijifei like '%"+nmeixiaoshijifei+"%'";}
if(request.getParameter("huiyuanbianhao")=="" ||request.getParameter("huiyuanbianhao")==null ){}else{String nhuiyuanbianhao=new String(request.getParameter("huiyuanbianhao").getBytes("8859_1"));if(nhuiyuanbianhao.contains("?")){nhuiyuanbianhao=request.getParameter("huiyuanbianhao");}sql=sql+" and huiyuanbianhao like '%"+nhuiyuanbianhao+"%'";}
if(request.getParameter("xingming")=="" ||request.getParameter("xingming")==null ){}else{String nxingming=new String(request.getParameter("xingming").getBytes("8859_1"));if(nxingming.contains("?")){nxingming=request.getParameter("xingming");}sql=sql+" and xingming like '%"+nxingming+"%'";}
if(request.getParameter("huiyuandengji")=="" ||request.getParameter("huiyuandengji")==null ){}else{String nhuiyuandengji=new String(request.getParameter("huiyuandengji").getBytes("8859_1"));if(nhuiyuandengji.contains("?")){nhuiyuandengji=request.getParameter("huiyuandengji");}sql=sql+" and huiyuandengji like '%"+nhuiyuandengji+"%'";}
			sql+=" order by id desc";
double zongjinez=0;
												
			ResultSet RS_result=connDbBean.executeQuery(sql);
while(RS_result.next()){
												
						zongjinez=zongjinez+Float.valueOf(RS_result.getString("zongjine")).floatValue();

												
			 }
			%>
        
        <div class="summary-footer" style="margin-bottom: 20px;">
            <div>
                <span style="font-size: 16px;">📊 共计总金额：</span>
            </div>
            <div class="summary-total">¥<%=zongjinez%></div>
        </div>
        
        <!-- 搜索框 -->
        <div class="search-card">
            <div style="display: flex; justify-content: space-between; align-items: center;">
                <div class="search-title">我的付费记录</div>
                <a href="fufei?action=searchPage" class="btn-search" style="text-decoration: none;">🔍 付费查询</a>
            </div>
        </div>
        
        <!-- 数据表格 -->
        <div class="data-card">
            <div class="table-container">
                <table class="data-table">
                    <thead>
                        <tr>
                            <th width="50">序号</th>
                            <th>场地号</th>
                            <th>每小时计费</th>
                            <th>总时长</th>
                            <th>会员编号</th>
                            <th>姓名</th>
                            <th>会员等级</th>
                            <th>折扣</th>
                            <th>总金额</th>
                            <th width="100">支付状态</th>
                            <th width="160">添加时间</th>
                            <th width="100">操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% int i=0; %>
                        <c:forEach items="${list}" var="u">
                            <% i++; %>
                            <tr>
                                <td><%=i%></td>
                                <td>${u.qiuzhuohao}</td>
                                <td>${u.meixiaoshijifei}</td>
                                <td>${u.zongshichang}</td>
                                <td>${u.huiyuanbianhao}</td>
                                <td>${u.xingming}</td>
                                <td>${u.huiyuandengji}</td>
                                <td>${u.zhekou}</td>
                                <td class="amount-cell">¥${u.zongjine}</td>
                                <td>
                                    <c:if test="${u.issh == '是'}">
                                        <span class="status-badge status-paid">✓ 已支付</span>
                                    </c:if>
                                    <c:if test="${u.issh != '是'}">
                                        <span class="status-badge status-unpaid">○ 未支付</span>
                                    </c:if>
                                </td>
                                <td>${u.addtime}</td>
                                <td>
                                    <a href="fufei?action=detail&id=${u.id}" style="color: #16a085; text-decoration: none; font-weight: 600;">📄 详细</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
        
        <!-- 分页 -->
        <div class="pagination">
            <c:if test="${sessionScope.p==1 }">
                <c:if test="${page.page>1}">
                    <a href="fufei?action=list?page=1">首页</a>
                    <a href="fufei?action=list?page=${page.pageNo-1 }">上一页</a>
                </c:if>
                <c:if test="${page.page<page.totalPage}">
                    <a href="fufei?action=list?page=${page.pageNo+1 }">下一页</a>
                    <a href="fufei?action=list?page=${page.totalPage }">末页</a>
                </c:if>
            </c:if>
        </div>
    </div>
</body>
</html>
