<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>会员首页 - 羽毛球馆</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: "Microsoft YaHei", sans-serif;
            background: #f5f7fa;
            /* 🔥 关键：不被顶部遮挡 */
            padding-top: 60px;
        }

        /* 轮播容器 */
        .carousel {
            position: relative;
            width: 100%;
            height: 500px;
            overflow: hidden;
        }

        /* 轮播图片 */
        .carousel-item {
            position: absolute;
            width: 100%;
            height: 100%;
            background-size: cover;
            background-position: center;
            opacity: 0;
            animation: slide 12s infinite;
        }

        .carousel-item:nth-child(1) {
            animation-delay: 0s;
        }
        .carousel-item:nth-child(2) {
            animation-delay: 4s;
        }
        .carousel-item:nth-child(3) {
            animation-delay: 8s;
        }

        /* 轮播动画 */
        @keyframes slide {
            0% { opacity: 0; }
            10% { opacity: 1; }
            33% { opacity: 1; }
            43% { opacity: 0; }
            100% { opacity: 0; }
        }

        /* 半透明文字 */
        .carousel-text {
            position: absolute;
            bottom: 60px;
            left: 50%;
            transform: translateX(-50%);
            color: white;
            font-size: 32px;
            font-weight: bold;
            text-shadow: 0 0 10px rgba(0,0,0,0.5);
            background: rgba(0,0,0,0.3);
            padding: 15px 30px;
            border-radius: 50px;
            white-space: nowrap;
        }

        /* 介绍区域 */
        .intro {
            max-width: 1000px;
            margin: 40px auto;
            padding: 0 20px;
            text-align: center;
        }

        .intro h2 {
            font-size: 26px;
            color: #16a085;
            margin-bottom: 20px;
        }

        .intro p {
            font-size: 17px;
            color: #444;
            line-height: 1.8;
            margin-bottom: 15px;
        }

        /* 底部标语 */
        .footer {
            text-align: center;
            padding: 30px 20px;
            color: #777;
            font-size: 14px;
            background: white;
            margin-top: 30px;
        }
    </style>
</head>

<body>

<!-- 轮播图 -->
<div class="carousel">
    <div class="carousel-item" style="background-image: url('https://img.yzcdn.cn/upload_files/2021/04/08/20210408142027-824919.jpg');">
        <div class="carousel-text">专业场地 · 舒适体验</div>
    </div>
    <div class="carousel-item" style="background-image: url('https://img.yzcdn.cn/upload_files/2021/04/08/20210408142044-120966.jpg');">
        <div class="carousel-text">在线预订 · 方便快捷</div>
    </div>
    <div class="carousel-item" style="background-image: url('https://img.yzcdn.cn/upload_files/2021/04/08/20210408142056-556111.jpg');">
        <div class="carousel-text">以球会友 · 快乐运动</div>
    </div>
</div>

<!-- 介绍内容 -->
<div class="intro">
    <h2>球馆介绍</h2>
    <p>本球馆拥有多片标准专业羽毛球场地，采用优质运动地胶，专业灯光照明，通风良好，环境舒适。</p>
    <p>会员可通过系统随时查看场地使用状态，一键预约，无需现场排队，享受便捷高效的运动预订服务。</p>
    <p>我们坚持以优质环境、贴心服务，为广大羽毛球爱好者提供专业、舒适、安全的运动空间。</p>
</div>

<!-- 底部 -->
<div class="footer">
    快乐羽球 · 健康生活 | 羽毛球馆管理系统 © 2026
</div>

</body>
</html>