/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50160
Source Host           : localhost:3306
Source Database       : badminton

Target Server Type    : MYSQL
Target Server Version : 50160
File Encoding         : 65001

Date: 2019-02-24 15:09:48
*/
/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80044
 Source Host           : localhost:3306
 Source Schema         : badminton

 Target Server Type    : MySQL
 Target Server Version : 80044
 File Encoding         : 65001

 Date: 03/04/2026 08:48:50
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for allusers
-- ----------------------------
DROP TABLE IF EXISTS `allusers`;
CREATE TABLE `allusers`  (
                             `id` int NOT NULL AUTO_INCREMENT,
                             `username` varchar(50) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL,
                             `pwd` varchar(50) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL,
                             `cx` varchar(50) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT '普通管理员',
                             `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                             PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = gb2312 COLLATE = gb2312_chinese_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of allusers
-- ----------------------------
INSERT INTO `allusers` VALUES (5, 'xiaoze', 'e10adc3949ba59abbe56e057f20f883e', '超级管理员', '2026-04-01 13:43:46');
INSERT INTO `allusers` VALUES (6, 'xiaopeng', 'e10adc3949ba59abbe56e057f20f883e', '超级管理员', '2026-04-01 17:15:47');
INSERT INTO `allusers` VALUES (7, 'xiaozhen', 'e10adc3949ba59abbe56e057f20f883e', '超级管理员', '2026-04-02 21:03:00');

-- ----------------------------
-- Table structure for dingzhuoxinxi
-- ----------------------------
DROP TABLE IF EXISTS `dingzhuoxinxi`;
CREATE TABLE `dingzhuoxinxi`  (
                                  `id` int NOT NULL AUTO_INCREMENT,
                                  `qiuzhuohao` varchar(50) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL,
                                  `meixiaoshijifei` varchar(50) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL,
                                  `dingzhuoshijian` varchar(50) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL,
                                  `huiyuanbianhao` varchar(50) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL,
                                  `xingming` varchar(50) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL,
                                  `huiyuandengji` varchar(50) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL,
                                  `zhekou` varchar(50) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL,
                                  `beizhu` varchar(500) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL,
                                  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = gb2312 COLLATE = gb2312_chinese_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dingzhuoxinxi
-- ----------------------------
INSERT INTO `dingzhuoxinxi` VALUES (21, '004', '25', '2026-04-01 20:18:24', '游客', '游客', '无', '1.0', '', '2026-04-01 20:18:24');
INSERT INTO `dingzhuoxinxi` VALUES (22, '005', '25', '2026-04-01 21:53:23', '1001', '小泽', '砖石', '', '', '2026-04-01 21:53:23');
INSERT INTO `dingzhuoxinxi` VALUES (23, '003', '25', '2026-04-02 10:51:18', '1001', '小泽', '砖石', '', '', '2026-04-02 10:51:18');
INSERT INTO `dingzhuoxinxi` VALUES (25, '004', '25', '2026-04-02 22:25:34', '1001', '小泽', '砖石', '0.8', '', '2026-04-02 22:25:34');

-- ----------------------------
-- Table structure for fufei
-- ----------------------------
DROP TABLE IF EXISTS `fufei`;
CREATE TABLE `fufei`  (
                          `id` int NOT NULL AUTO_INCREMENT,
                          `qiuzhuohao` varchar(50) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL,
                          `meixiaoshijifei` varchar(50) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL,
                          `zongshichang` varchar(50) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL,
                          `huiyuanbianhao` varchar(50) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL,
                          `xingming` varchar(50) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL,
                          `huiyuandengji` varchar(50) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL,
                          `zhekou` varchar(50) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL,
                          `zongjine` varchar(50) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL,
                          `beizhu` varchar(500) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL,
                          `issh` varchar(10) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT '否',
                          `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                          PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 27 CHARACTER SET = gb2312 COLLATE = gb2312_chinese_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fufei
-- ----------------------------
INSERT INTO `fufei` VALUES (23, '004', '25', '1', '游客', '游客', '无', '1.0', '25', '', '是', '2026-04-01 20:18:24');
INSERT INTO `fufei` VALUES (24, '005', '25', '1', '1001', '小泽', '砖石', '', '25.00', '', '是', '2026-04-01 21:53:23');
INSERT INTO `fufei` VALUES (25, '003', '25', '1', '1001', '小泽', '砖石', '', '25.00', '', '是', '2026-04-02 10:51:18');
INSERT INTO `fufei` VALUES (27, '004', '25', '1', '1001', '小泽', '砖石', '0.8', '20.00', '', '是', '2026-04-02 22:25:34');

-- ----------------------------
-- Table structure for huiyuanxinxi
-- ----------------------------
DROP TABLE IF EXISTS `huiyuanxinxi`;
CREATE TABLE `huiyuanxinxi`  (
                                 `id` int NOT NULL AUTO_INCREMENT,
                                 `huiyuanbianhao` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
                                 `mima` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
                                 `xingming` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
                                 `xingbie` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
                                 `huiyuandengji` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
                                 `zhekou` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
                                 `shouji` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
                                 `beizhu` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
                                 `yue` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '0' COMMENT '会员余额',
                                 `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                 PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of huiyuanxinxi
-- ----------------------------
INSERT INTO `huiyuanxinxi` VALUES (1, '1001', '1001', '小泽', '男', '砖石', '0.8', '17773091458', '帅', '80.00', '2026-04-02 19:11:10');
INSERT INTO `huiyuanxinxi` VALUES (2, '2002', '2002', '小鹏', '男', '砖石', '0.8', '18692157776', '', '100', '2026-04-02 20:27:01');

-- ----------------------------
-- Table structure for huodongxinxi
-- ----------------------------
DROP TABLE IF EXISTS `huodongxinxi`;
CREATE TABLE `huodongxinxi`  (
                                 `id` int NOT NULL AUTO_INCREMENT,
                                 `bianhao` varchar(50) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL,
                                 `biaoti` varchar(50) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL,
                                 `neirong` varchar(500) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL,
                                 `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                 PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = gb2312 COLLATE = gb2312_chinese_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of huodongxinxi
-- ----------------------------
INSERT INTO `huodongxinxi` VALUES (2, '020', '保时捷发布2014款911 GT 将于10月发售', '', '2019-02-22 23:24:07');
INSERT INTO `huodongxinxi` VALUES (3, '026', '市十一届人大六次会议', '', '2019-02-22 23:24:07');
INSERT INTO `huodongxinxi` VALUES (4, '015', '亮亮堂堂迎国庆（图）', '', '2019-02-22 23:24:07');
INSERT INTO `huodongxinxi` VALUES (5, '013', '世界艾滋病日 志愿者在行动（组图）', '', '2019-02-22 23:24:07');
INSERT INTO `huodongxinxi` VALUES (6, '001', '保时捷发布2014款911 GT 将于10月发售', '', '2019-02-22 23:24:07');
INSERT INTO `huodongxinxi` VALUES (7, '1111123', '砂进口的恢复上课的恢复健康', '奥术大师大所多三', '2019-02-24 15:05:36');

-- ----------------------------
-- Table structure for liuyanban
-- ----------------------------
DROP TABLE IF EXISTS `liuyanban`;
CREATE TABLE `liuyanban`  (
                              `id` int NOT NULL AUTO_INCREMENT,
                              `zhanghao` varchar(50) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL,
                              `zhaopian` varchar(50) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL,
                              `xingming` varchar(50) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL,
                              `liuyan` varchar(50) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL,
                              `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                              `huifu` varchar(50) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL,
                              PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = gb2312 COLLATE = gb2312_chinese_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of liuyanban
-- ----------------------------

-- ----------------------------
-- Table structure for qiuzhuoxinxi
-- ----------------------------
DROP TABLE IF EXISTS `qiuzhuoxinxi`;
CREATE TABLE `qiuzhuoxinxi`  (
                                 `id` int NOT NULL AUTO_INCREMENT,
                                 `qiuzhuohao` varchar(50) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL,
                                 `zhuangtai` varchar(50) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL,
                                 `meixiaoshijifei` varchar(50) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL,
                                 `beizhu` varchar(500) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL,
                                 `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                 PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = gb2312 COLLATE = gb2312_chinese_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qiuzhuoxinxi
-- ----------------------------
INSERT INTO `qiuzhuoxinxi` VALUES (8, '001', '空闲', '25', '', '2026-04-01 13:10:32');
INSERT INTO `qiuzhuoxinxi` VALUES (9, '002', '空闲', '25', '', '2026-04-01 13:18:33');
INSERT INTO `qiuzhuoxinxi` VALUES (10, '003', '空闲', '25', '', '2026-04-01 13:18:44');
INSERT INTO `qiuzhuoxinxi` VALUES (11, '004', '已订', '25', '', '2026-04-01 13:18:54');
INSERT INTO `qiuzhuoxinxi` VALUES (12, '005', '空闲', '25', '', '2026-04-01 13:19:01');

SET FOREIGN_KEY_CHECKS = 1;
