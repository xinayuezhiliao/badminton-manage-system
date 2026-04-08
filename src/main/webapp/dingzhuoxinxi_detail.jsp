<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.sql.*" %>
<%@ page isELIgnored="false" %>
<jsp:useBean id="connDbBean" scope="page" class="com.badminton.util.db"/>

<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>订场信息详情 - 羽毛球球馆管理系统</title>
    <link rel="stylesheet" type="text/css" href="<%=basePath%>static/css/beautify.css" />
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", "Microsoft YaHei", "微软雅黑", sans-serif;
            font-size: 14px;
            line-height: 1.6;
            color: #333;
            background-color: #f5f7fa;
            margin: 0;
            padding: 20px;
        }
        
        .page-title {
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 2px solid #e9ecef;
        }
        
        .page-title h2 {
            font-size: 20px;
            font-weight: 600;
            color: #333;
            margin: 0;
            display: flex;
            align-items: center;
        }
        
        .page-title h2::before {
            content: "";
            display: inline-block;
            width: 4px;
            height: 20px;
            background: linear-gradient(135deg, #16a085 0%, #1abc9c 100%);
            margin-right: 10px;
            border-radius: 2px;
        }
        
        .detail-container {
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 12px rgba(0, 0, 0, 0.08);
            overflow: hidden;
        }
        
        .detail-header {
            background: linear-gradient(135deg, #16a085 0%, #1abc9c 100%);
            color: #fff;
            padding: 16px 20px;
            font-size: 16px;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .detail-header::before {
            content: "📋";
            font-size: 18px;
        }
        
        .detail-body {
            padding: 25px;
        }
        
        .detail-table {
            width: 100%;
            border-collapse: collapse;
        }
        
        .detail-table th {
            width: 120px;
            padding: 14px 16px;
            background: #f8f9fa;
            text-align: right;
            font-weight: 500;
            color: #555;
            border: 1px solid #eee;
            vertical-align: middle;
        }
        
        .detail-table td {
            padding: 14px 16px;
            border: 1px solid #eee;
            color: #333;
            min-width: 150px;
        }
        
        .detail-value {
            color: #333;
            font-weight: 400;
        }
        
        .detail-actions {
            padding: 20px;
            background: #f8f9fa;
            text-align: center;
            border-top: 1px solid #eee;
        }
        
        .btn {
            display: inline-block;
            padding: 10px 28px;
            font-size: 14px;
            font-weight: 500;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: all 0.3s ease;
            margin: 0 8px;
        }
        
        .btn-primary {
            color: #fff;
            background: linear-gradient(135deg, #16a085 0%, #1abc9c 100%);
        }
        
        .btn-primary:hover {
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(22, 160, 133, 0.3);
        }
        
        .btn-secondary {
            color: #666;
            background: #fff;
            border: 1px solid #ddd;
        }
        
        .btn-secondary:hover {
            background: #f0f0f0;
        }
        
        /* 响应式设计 */
        @media screen and (max-width: 768px) {
            body {
                padding: 15px;
            }
            
            .detail-body {
                padding: 15px;
            }
            
            .detail-table th,
            .detail-table td {
                display: block;
                width: 100%;
                text-align: left;
            }
            
            .detail-table th {
                padding: 10px 15px;
                border-bottom: none;
                background: #f0f0f0;
            }
            
            .detail-table td {
                padding: 10px 15px 20px;
                border-top: none;
            }
            
            .detail-actions {
                padding: 15px;
            }
            
            .btn {
                padding: 10px 20px;
                margin: 5px;
            }
        }
        
        @media screen and (max-width: 480px) {
            body {
                padding: 10px;
            }
            
            .page-title h2 {
                font-size: 18px;
            }
            
            .detail-header {
                padding: 14px 15px;
                font-size: 15px;
            }
        }
        
        /* 打印样式 */
        @media print {
            body {
                background: #fff;
                padding: 0;
            }
            
            .detail-container {
                box-shadow: none;
                border: 1px solid #ddd;
            }
            
            .detail-actions {
                display: none;
            }
        }
    </style>
</head>
<body>
    <div class="page-title">
        <h2>订场信息详情</h2>
    </div>
    
    <div class="detail-container">
        <div class="detail-header">
            订场信息详情
        </div>
        
        <div class="detail-body">
            <table class="detail-table">
                <tr>
                    <th>场地号</th>
                    <td class="detail-value">${dingzhuoxinxi.qiuzhuohao}</td>
                    <th>每小时计费</th>
                    <td class="detail-value">${dingzhuoxinxi.meixiaoshijifei}</td>
                </tr>
                <tr>
                    <th>订场时间</th>
                    <td class="detail-value">${dingzhuoxinxi.dingzhuoshijian}</td>
                    <th>会员编号</th>
                    <td class="detail-value">${dingzhuoxinxi.huiyuanbianhao}</td>
                </tr>
                <tr>
                    <th>姓名</th>
                    <td class="detail-value">${dingzhuoxinxi.xingming}</td>
                    <th>会员等级</th>
                    <td class="detail-value">${dingzhuoxinxi.huiyuandengji}</td>
                </tr>
                <tr>
                    <th>折扣</th>
                    <td class="detail-value">${dingzhuoxinxi.zhekou}</td>
                    <th>备注</th>
                    <td class="detail-value">${dingzhuoxinxi.beizhu}</td>
                </tr>
            </table>
        </div>
        
        <div class="detail-actions">
            <button type="button" class="btn btn-secondary" onclick="history.back()">返回</button>
            <button type="button" class="btn btn-primary" onclick="window.print()">打印</button>
        </div>
    </div>
</body>
</html>
