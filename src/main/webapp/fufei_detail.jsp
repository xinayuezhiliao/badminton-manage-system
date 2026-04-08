<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>付费详情</title>
    <style>
        * { margin:0; padding:0; box-sizing:border-box; }
        body {
            font-family: "Microsoft YaHei";
            background: #f5f7fa;
            padding-top: 60px;
        }
        .container {
            max-width: 700px;
            margin: 50px auto;
            background: white;
            padding: 40px;
            border-radius: 16px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.1);
        }
        .title {
            text-align: center;
            font-size: 26px;
            color: #16a085;
            margin-bottom: 30px;
            font-weight: bold;
        }
        .item {
            display: flex;
            padding: 14px 0;
            border-bottom: 1px solid #eee;
        }
        .label {
            width: 150px;
            font-weight: bold;
            color: #555;
            font-size: 16px;
        }
        .value {
            font-size: 16px;
            color: #333;
        }
        .status {
            padding: 6px 12px;
            border-radius: 6px;
            font-weight: bold;
        }
        .paid {
            background: #d4edda;
            color: #155724;
        }
        .unpaid {
            background: #fff3cd;
            color: #856404;
        }
        .back {
            text-align: center;
            margin-top: 30px;
        }
        .back a {
            display: inline-block;
            padding: 12px 30px;
            background: #16a085;
            color: white;
            border-radius: 8px;
            text-decoration: none;
            font-weight: bold;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="title">💰 付费详情</div>

    <div class="item">
        <div class="label">订单ID：</div>
        <div class="value">${fufei.id}</div>
    </div>
    <div class="item">
        <div class="label">场地号：</div>
        <div class="value">${fufei.qiuzhuohao}</div>
    </div>
    <div class="item">
        <div class="label">每小时费用：</div>
        <div class="value">${fufei.meixiaoshijifei} 元</div>
    </div>
    <div class="item">
        <div class="label">总时长：</div>
        <div class="value">${fufei.zongshichang} 小时</div>
    </div>
    <div class="item">
        <div class="label">会员编号：</div>
        <div class="value">${fufei.huiyuanbianhao}</div>
    </div>
    <div class="item">
        <div class="label">会员姓名：</div>
        <div class="value">${fufei.xingming}</div>
    </div>
    <div class="item">
        <div class="label">会员等级：</div>
        <div class="value">${fufei.huiyuandengji}</div>
    </div>
    <div class="item">
        <div class="label">折扣：</div>
        <div class="value">${fufei.zhekou}</div>
    </div>
    <div class="item">
        <div class="label">总金额：</div>
        <div class="value" style="color:red; font-weight:bold;">${fufei.zongjine} 元</div>
    </div>
    <div class="item">
        <div class="label">支付状态：</div>
        <div class="value">
            <c:if test="${fufei.issh == '是'}">
                <span class="status paid">已支付</span>
            </c:if>
            <c:if test="${fufei.issh != '是'}">
                <span class="status unpaid">未支付</span>
            </c:if>
        </div>
    </div>
    <div class="item">
        <div class="label">创建时间：</div>
        <div class="value">${fufei.addtime}</div>
    </div>
    <div class="item">
        <div class="label">备注：</div>
        <div class="value">${fufei.beizhu}</div>
    </div>

    <div class="back">
        <a href="javascript:history.back()">← 返回</a>
    </div>
</div>

</body>
</html>