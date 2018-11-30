/*
Navicat MySQL Data Transfer

Source Server         : 127.0.0.1_3306
Source Server Version : 50528
Source Host           : 127.0.0.1:3306
Source Database       : test_cms

Target Server Type    : MYSQL
Target Server Version : 50528
File Encoding         : 65001

Date: 2017-12-26 15:14:01
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for t_cms_apps
-- ----------------------------
DROP TABLE IF EXISTS `t_cms_apps`;
CREATE TABLE `t_cms_apps` (
`id`  bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键' ,
`appid`  varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'appid' ,
`appname`  varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'app名称' ,
`timestamp`  timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '时间戳' ,
PRIMARY KEY (`id`),
UNIQUE INDEX `uk_appid` (`appid`) USING BTREE 
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
AUTO_INCREMENT=3

;

-- ----------------------------
-- Records of t_cms_apps
-- ----------------------------
BEGIN;
INSERT INTO `t_cms_apps` VALUES ('1', '100', '证太理财', '2017-09-11 18:03:06'), ('2', '102', '太牛', '2017-09-11 18:08:31');
COMMIT;

-- ----------------------------
-- Table structure for t_cms_col_from
-- ----------------------------
DROP TABLE IF EXISTS `t_cms_col_from`;
CREATE TABLE `t_cms_col_from` (
`id`  bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自动增长列' ,
`SourceID`  int(11) NULL DEFAULT NULL COMMENT '来源ID, 自定义唯一ID' ,
`Source`  varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '来源信息, 推荐JSON格式, 包含连接属性' ,
`right`  int(11) NULL DEFAULT NULL COMMENT '权限:1-网络系统, 2- 内部系统(导入等)' ,
`timestamp`  timestamp NULL DEFAULT CURRENT_TIMESTAMP ,
PRIMARY KEY (`id`),
UNIQUE INDEX `uk_sid` (`SourceID`) USING BTREE 
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
AUTO_INCREMENT=7

;

-- ----------------------------
-- Records of t_cms_col_from
-- ----------------------------
BEGIN;
INSERT INTO `t_cms_col_from` VALUES ('1', '100', 'TDX消息平台', '1', '2016-12-26 15:28:48'), ('2', '101', 'TDX资讯平台', '2', '2016-12-26 15:28:48'), ('3', '102', '太牛测试', '1', '2017-09-21 17:30:55'), ('4', '103', '测试', '1', '2017-09-22 16:09:18'), ('6', '104', '太牛重复', '1', '2017-09-25 10:56:24');
COMMIT;

-- ----------------------------
-- Table structure for t_cms_col_spec
-- ----------------------------
DROP TABLE IF EXISTS `t_cms_col_spec`;
CREATE TABLE `t_cms_col_spec` (
`id`  bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT ,
`col_spec_id`  varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '栏目方案ID' ,
`col_spec_name`  varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '栏目方案名称' ,
`col_spec_info`  varchar(2048) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '栏目方案信息' ,
`timestamp`  timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP ,
`enabled`  int(11) NULL DEFAULT 0 COMMENT '启用标识' ,
PRIMARY KEY (`id`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
AUTO_INCREMENT=1

;

-- ----------------------------
-- Records of t_cms_col_spec
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for t_cms_col_subscribe
-- ----------------------------
DROP TABLE IF EXISTS `t_cms_col_subscribe`;
CREATE TABLE `t_cms_col_subscribe` (
`id`  bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增序列' ,
`acc_type`  varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '绑定账号类型，一般为TDXID' ,
`acc_id`  varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '客户号' ,
`col_idx`  bigint(20) NOT NULL COMMENT '栏目序号' ,
`enabled`  int(11) NULL DEFAULT 1 COMMENT '是否有效' ,
`timestamp`  timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP ,
`comment`  varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`seq`  int(11) NOT NULL ,
PRIMARY KEY (`id`),
UNIQUE INDEX `ukey` (`acc_type`, `acc_id`, `col_idx`) USING BTREE 
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
AUTO_INCREMENT=1

;

-- ----------------------------
-- Records of t_cms_col_subscribe
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for t_cms_column
-- ----------------------------
DROP TABLE IF EXISTS `t_cms_column`;
CREATE TABLE `t_cms_column` (
`id`  bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增序列' ,
`col_name`  varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '栏目名称' ,
`col_id`  varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '栏目ID（外部生成的唯一序列）' ,
`col_info`  varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '栏目信息，推荐JSON字段' ,
`timestamp`  timestamp NULL DEFAULT CURRENT_TIMESTAMP ,
`subscribe_times`  int(11) NULL DEFAULT 0 COMMENT '订阅次数' ,
`unsubscribe_times`  int(11) NULL DEFAULT 0 COMMENT '退订次数' ,
`enabled`  int(11) NULL DEFAULT 1 COMMENT '当前状态，0-禁用，1-启用' ,
`linkto`  varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '连接到外部系统扫描，例如:扫描自选股, 扫描持仓股' ,
`col_from`  int(11) NULL DEFAULT NULL COMMENT '栏目来源ID, 与 t_cms_col_from.SourceID 关联' ,
`col_type`  int(11) NULL DEFAULT 1 COMMENT '栏目类型, 1-公共(仅该类型栏目可订阅), 2-私信, 4-私信并且不可删除' ,
PRIMARY KEY (`id`),
UNIQUE INDEX `uk_cid` (`col_id`, `col_from`) USING BTREE ,
UNIQUE INDEX `uk_cname` (`col_name`, `col_from`) USING BTREE 
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
AUTO_INCREMENT=126

;

-- ----------------------------
-- Records of t_cms_column
-- ----------------------------
BEGIN;
INSERT INTO `t_cms_column` VALUES ('1', '通知', 'TDXSYSCOL-TZ', '{\"intro\": \"通知\",\"price\": {\"type\": \"免费订阅\",\"val\": 0,\"category\": \"元/周\"},\"cycle\": \"\",\"tags\": []}', '2016-12-26 15:28:48', '0', '0', '1', null, '100', '4'), ('2', '活动', 'TDXSYSCOL-HD', '{\"intro\": \"活动\",\"price\": {\"type\": \"免费订阅\",\"val\": 0,\"category\": \"元/周\"},\"cycle\": \"\",\"tags\": []}', '2016-12-26 15:28:48', '0', '0', '1', null, '100', '4'), ('3', '私信', 'TDXSYSCOL-SX', '{\"intro\": \"私信\",\"price\": {\"type\": \"免费订阅\",\"val\": 0,\"category\": \"元/周\"},\"cycle\": \"\",\"tags\": []}', '2016-12-26 15:28:48', '0', '0', '1', null, '100', '2'), ('4', '自选股', 'TDXSYSCOL-ZXG', '{\"intro\": \"自选股\",\"price\": {\"type\": \"免费订阅\",\"val\": 0,\"category\": \"元/周\"},\"cycle\": \"\",\"tags\": []}', '2016-12-26 15:28:48', '0', '0', '1', 'zxg', '101', '2'), ('5', '持仓股', 'TDXSYSCOL-CCG', '{\"intro\": \"持仓股\",\"price\": {\"type\": \"免费订阅\",\"val\": 0,\"category\": \"元/周\"},\"cycle\": \"\",\"tags\": []}', '2016-12-26 15:28:48', '0', '0', '1', 'cc', '101', '2'), ('100', '中签提示', 'TDXTDXCOL-6102-5860ea6c-000', '{\"intro\": \"1\",\"price\": {\"type\": \"免费订阅\",\"val\": 0,\"category\": \"元/周\"},\"cycle\": \"1\",\"tags\": [{\"text\": \"1\",\"color\": 1}]}', '2016-12-26 18:01:16', '0', '0', '1', null, '100', '2'), ('101', '要闻', '0', '', '2017-01-16 11:00:23', '0', '0', '1', '', '101', '1'), ('102', '必读', '1', '', '2017-01-16 11:00:23', '0', '0', '1', '', '101', '1'), ('103', '热点', '2', '', '2017-01-16 11:00:23', '0', '0', '1', '', '101', '1'), ('104', '多空', '3', '', '2017-01-16 11:00:23', '0', '0', '1', '', '101', '1'), ('105', '沪深', '4', '', '2017-01-16 11:00:23', '0', '0', '1', '', '101', '1'), ('106', '宏观', '5', '', '2017-01-16 11:00:23', '0', '0', '1', '', '101', '1'), ('107', '公司', '6', '', '2017-01-16 11:00:23', '0', '0', '1', '', '101', '1'), ('108', '港股', '7', '', '2017-01-16 11:00:23', '0', '0', '1', '', '101', '1'), ('109', '海外', '8', '', '2017-01-16 11:00:23', '0', '0', '1', '', '101', '1'), ('110', '新股', '9', '', '2017-01-16 11:00:23', '0', '0', '1', '', '101', '1'), ('111', '理财', '10', '', '2017-01-16 11:00:23', '0', '0', '1', '', '101', '1'), ('112', '外汇', '11', '', '2017-01-16 11:00:23', '0', '0', '1', '', '101', '1'), ('113', '债券', '12', '', '2017-01-16 11:00:23', '0', '0', '1', '', '101', '1'), ('114', '商品', '13', '', '2017-01-16 11:00:23', '0', '0', '1', '', '101', '1'), ('115', '机构', '14', '', '2017-01-16 11:00:23', '0', '0', '1', '', '101', '1'), ('116', '产经', '15', '', '2017-01-16 11:00:23', '0', '0', '1', '', '101', '1'), ('117', '太牛栏目1', 'TDXTDXCOL-6102-59b661a2-000', '{\"intro\": \"1\",\"price\": {\"type\": \"免费订阅\",\"val\": 0,\"category\": \"元/周\"},\"cycle\": \"太牛栏目1\",\"tags\": [{\"text\": \"1\",\"color\": 1}]}', '2017-09-11 18:12:50', '0', '0', '1', null, '102', '2'), ('118', '测试栏目3', 'TDXTDXCOL-6102-59c4c45c-000', '{\"intro\": \"1\",\"price\": {\"type\": \"免费订阅\",\"val\": 0,\"category\": \"元/周\"},\"cycle\": \"1\",\"tags\": [{\"text\": \"1\",\"color\": 1}]}', '2017-09-22 16:05:48', '0', '0', '0', '', '102', '2'), ('119', '测试栏目', 'TDXTDXCOL-6102-59c4c655-000', '{\"intro\": \"1\",\"price\": {\"type\": \"免费订阅\",\"val\": 0,\"category\": \"元/周\"},\"cycle\": \"1\",\"tags\": [{\"text\": \"1\",\"color\": 1}]}', '2017-09-22 16:14:13', '0', '0', '1', '', '103', '2'), ('120', '太牛栏目2', 'TDXTDXCOL-6102-59c4d5fc-000', '{\"intro\": \"1\",\"price\": {\"type\": \"免费订阅\",\"val\": 0,\"category\": \"元/周\"},\"cycle\": \"\",\"tags\": []}', '2017-09-22 17:21:00', '0', '0', '0', '', '102', '2'), ('121', '测试栏目4', 'TDXTDXCOL-6102-59c4e183-000', '{\"intro\": \"1\",\"price\": {\"type\": \"免费订阅\",\"val\": 0,\"category\": \"元/周\"},\"cycle\": \"\",\"tags\": [{\"text\": \"1\",\"color\": 1}]}', '2017-09-22 18:10:11', '0', '0', '0', '', '102', '2'), ('122', '太牛栏目拉取', 'TDXTDXCOL-6102-59c86fea-000', '{\"intro\": \"太牛栏目拉取\",\"price\": {\"type\": \"免费订阅\",\"val\": 0,\"category\": \"元/周\"},\"cycle\": \"\",\"tags\": []}', '2017-09-25 10:54:34', '0', '0', '0', '', '102', '2'), ('123', '重复栏目', 'TDXTDXCOL-6102-59c87065-000', '{\"intro\": \"重复栏目\",\"price\": {\"type\": \"免费订阅\",\"val\": 0,\"category\": \"元/周\"},\"cycle\": \"\",\"tags\": []}', '2017-09-25 10:56:37', '0', '0', '1', '', '104', '2'), ('124', '系统消息', 'TDXTDXCOL-6102-5a338022-000', '{\"intro\": \"太牛系统消息栏目\",\"price\": {\"type\": \"免费订阅\",\"val\": 0,\"category\": \"元/周\"},\"cycle\": \"\",\"tags\": []}', '2017-12-15 15:56:18', '0', '0', '1', '', '102', '2'), ('125', '1', 'TDXTDXCOL-9003-5a41f5b9-000', '{\"intro\": \"1\",\"price\": {\"type\": \"免费订阅\",\"val\": 0,\"category\": \"元/周\"},\"cycle\": \"1\",\"tags\": [{\"text\": \"1\",\"color\": 1}]}', '2017-12-26 15:09:45', '0', '0', '1', '', '100', '2');
COMMIT;

-- ----------------------------
-- Table structure for t_cms_column_attach
-- ----------------------------
DROP TABLE IF EXISTS `t_cms_column_attach`;
CREATE TABLE `t_cms_column_attach` (
`id`  bigint(20) UNSIGNED NOT NULL COMMENT '栏目序号' ,
`comment`  varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '附属说明' ,
`var1`  varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '附属1' ,
`var2`  varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '附属2' ,
`var3`  varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '附属3' ,
`var4`  varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '附属4' ,
`var5`  varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '附属5' ,
PRIMARY KEY (`id`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci

;

-- ----------------------------
-- Records of t_cms_column_attach
-- ----------------------------
BEGIN;
INSERT INTO `t_cms_column_attach` VALUES ('101', 'V1:RECID,V2:SEQID', '3420053', '18299215', '', '', ''), ('102', 'V1:RECID,V2:SEQID', '3420302', '18299533', '', '', ''), ('103', 'V1:RECID,V2:SEQID', '3419766', '18298828', '', '', ''), ('104', 'V1:RECID,V2:SEQID', '3419958', '18299020', '', '', ''), ('105', 'V1:RECID,V2:SEQID', '3419883', '18298938', '', '', ''), ('106', 'V1:RECID,V2:SEQID', '3419960', '18299022', '', '', ''), ('107', 'V1:RECID,V2:SEQID', '3420211', '18299385', '', '', ''), ('108', 'V1:RECID,V2:SEQID', '3420666', '18299840', '', '', ''), ('109', 'V1:RECID,V2:SEQID', '3419522', '18298604', '', '', ''), ('110', 'V1:RECID,V2:SEQID', '3418846', '18297910', '', '', ''), ('111', 'V1:RECID,V2:SEQID', '3418105', '18296855', '', '', ''), ('112', 'V1:RECID,V2:SEQID', '3418898', '18297963', '', '', ''), ('113', 'V1:RECID,V2:SEQID', '3419705', '18298792', '', '', ''), ('114', 'V1:RECID,V2:SEQID', '3420053', '18299215', '', '', ''), ('115', 'V1:RECID,V2:SEQID', '3419952', '18299013', '', '', ''), ('116', 'V1:RECID,V2:SEQID', '3419956', '18299019', '', '', '');
COMMIT;

-- ----------------------------
-- Table structure for t_cms_msg_draft
-- ----------------------------
DROP TABLE IF EXISTS `t_cms_msg_draft`;
CREATE TABLE `t_cms_msg_draft` (
`id`  bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键' ,
`acc_type`  varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '账号类型' ,
`acc_id`  varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '账号' ,
`msg_draft`  mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '草稿' ,
`last_time`  datetime NULL DEFAULT NULL COMMENT '最后保存时间' ,
PRIMARY KEY (`id`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
AUTO_INCREMENT=2

;

-- ----------------------------
-- Records of t_cms_msg_draft
-- ----------------------------
BEGIN;
INSERT INTO `t_cms_msg_draft` VALUES ('1', 'TDXID', 'ROOT', '{\"message_info\": {\"column\": \"TDXSYSCOL-TZ\",\"title\": \"测试1\",\"abstract\": \"Test（01）\",\"source\": \"测试组\",\"template\": \"\",\"content\": \"这是用来测试的\",\"other\": {\"OPEN\": \"\"},\"sign\": \"\",\"img_list\": [],\"attach_list\": \"\",\"keyboarder\": null},\"sender\": {\"system\": \"CMS\",\"account\": \"TDX10275\"},\"receiver\": {\"pul\": {\"ATYPE\": \"340\",\"NAME\": \"\",\"list\": [\"13683219207\"]}},\"devices\": [\"iOS\",\"Android\",\"PC\"],\"apps\": [\"Web\"],\"push_by_task_queue\": true,\"user_feedback_required\": true,\"save_message_required\": true,\"push_timer\": {\"type\": \"0\",\"time\": \"\"}}', '2017-09-14 11:16:22');
COMMIT;

-- ----------------------------
-- Table structure for t_cms_msg_list
-- ----------------------------
DROP TABLE IF EXISTS `t_cms_msg_list`;
CREATE TABLE `t_cms_msg_list` (
`id`  bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键' ,
`msg_id`  varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '消息ID' ,
`column`  bigint(20) NOT NULL DEFAULT 0 COMMENT '栏目ID' ,
`title`  varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标题信息' ,
`source`  varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '来源' ,
`abstract`  varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '摘要' ,
`content`  text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '内容主体' ,
`msg_sign`  varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '签名信息(废弃)' ,
`template`  int(11) NULL DEFAULT NULL COMMENT '模版' ,
`msg_info`  varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '消息详细信息' ,
`img_list`  varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图片列表(依赖文件服务器, 存储文件服务器的相对地址)' ,
`attach_list`  varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '附件列表(依赖文件服务器, 存储文件服务器的相对地址)' ,
`keyboarder`  varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '录入人员' ,
`valid_time`  datetime NULL DEFAULT NULL COMMENT '生效时间' ,
`invalid_time`  datetime NULL DEFAULT NULL COMMENT '失效时间' ,
`status`  int(11) NULL DEFAULT 0 COMMENT '状态' ,
`category`  varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '栏目ID(废弃)' ,
`md5`  varchar(33) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '内容MD5校验' ,
`timestamp`  timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '时间戳' ,
PRIMARY KEY (`id`),
UNIQUE INDEX `uk_mid` (`msg_id`) USING BTREE ,
UNIQUE INDEX `uk_md5` (`md5`) USING BTREE ,
INDEX `k_column` (`column`) USING BTREE 
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
AUTO_INCREMENT=1017881

;

-- ----------------------------
-- Records of t_cms_msg_list
-- ----------------------------
BEGIN;
INSERT INTO `t_cms_msg_list` VALUES ('1', '1', '0', '111', '1', '1', '1', '11', '1', '1', '1', null, null, '2017-12-26 14:55:56', '2017-12-26 14:56:01', '0', '', null, '2017-12-26 14:57:32');
COMMIT;

-- ----------------------------
-- Table structure for t_cms_sign
-- ----------------------------
DROP TABLE IF EXISTS `t_cms_sign`;
CREATE TABLE `t_cms_sign` (
`id`  bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '签名ID' ,
`acc`  varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '管理账号' ,
`sign_title`  varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '签名标题' ,
`sign_info`  varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '签名信息' ,
`in_use`  tinyint(4) NULL DEFAULT 0 COMMENT '当前签名标志' ,
PRIMARY KEY (`id`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
AUTO_INCREMENT=1

;

-- ----------------------------
-- Records of t_cms_sign
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for t_cms_task_job
-- ----------------------------
DROP TABLE IF EXISTS `t_cms_task_job`;
CREATE TABLE `t_cms_task_job` (
`id`  bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键' ,
`job_name`  varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '定时任务名称' ,
`job_info`  mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '任务内容' ,
`job_type`  int(11) NULL DEFAULT NULL COMMENT '定时类型 4-及时生效, 1-每日某时, 2-每周某时, 3-每月某时' ,
`job_time`  datetime NULL DEFAULT NULL COMMENT '生效时间' ,
`last_time`  datetime NULL DEFAULT NULL COMMENT '最后发送时间' ,
`job_status`  int(11) NULL DEFAULT 0 COMMENT '最后触发状态 0-未发送, -1-发送失败, 1-成功' ,
`timestamp`  timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '时间戳' ,
PRIMARY KEY (`id`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
AUTO_INCREMENT=1

;

-- ----------------------------
-- Records of t_cms_task_job
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for t_cms_template
-- ----------------------------
DROP TABLE IF EXISTS `t_cms_template`;
CREATE TABLE `t_cms_template` (
`id`  bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增序列' ,
`tpl_name`  varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '模版名称' ,
`tpl_id`  varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '模版ID（外部生成的唯一序列）' ,
`tpl_info`  varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '模版信息，推荐JSON字段' ,
`source`  varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '来源' ,
`creater`  varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建者信息' ,
`enabled`  int(11) NULL DEFAULT 1 COMMENT '当前状态，0-禁用，1-启用' ,
`stamp`  timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '时间戳' ,
PRIMARY KEY (`id`),
UNIQUE INDEX `uk_tid` (`tpl_id`) USING BTREE ,
INDEX `k_tname` (`tpl_name`) USING BTREE 
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
AUTO_INCREMENT=1

;

-- ----------------------------
-- Records of t_cms_template
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for t_cms_user_stock
-- ----------------------------
DROP TABLE IF EXISTS `t_cms_user_stock`;
CREATE TABLE `t_cms_user_stock` (
`id`  bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增ID' ,
`acc_type`  varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '账号类型' ,
`acc_id`  varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '账号' ,
`stock_code`  varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '股票代码' ,
`set_code`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '市场代码' ,
`stock_name`  varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '股票名称' ,
`flag`  int(10) UNSIGNED NULL DEFAULT 0 COMMENT '订阅标志,使用开关方式, 1-2-4-8-16等等, 1: 个股公告, 2:个股新闻' ,
`last`  datetime NULL DEFAULT NULL COMMENT '最后推送日期' ,
`timestamp`  timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '时间戳' ,
PRIMARY KEY (`id`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
AUTO_INCREMENT=1

;

-- ----------------------------
-- Records of t_cms_user_stock
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for t_mom_task_list
-- ----------------------------
DROP TABLE IF EXISTS `t_mom_task_list`;
CREATE TABLE `t_mom_task_list` (
`id`  bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键' ,
`task_id`  varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '任务ID，由TS内存生成' ,
`main_id`  varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '主任务ID，任务拆分后, 以第一个任务包的任务ID做主任务ID' ,
`msg_id`  varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '发送的消息存储ID' ,
`receivers`  varchar(4096) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '接收对象的群组名称' ,
`sender`  varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '发送者' ,
`total`  int(11) NULL DEFAULT NULL COMMENT '总任务数' ,
`completed`  int(10) UNSIGNED NULL DEFAULT 0 COMMENT '已发送完成的任务数量，根据接收者数量来定' ,
`others`  varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '其它任务相关的存储信息' ,
`status`  int(11) NULL DEFAULT NULL ,
`create_time`  int(11) NULL DEFAULT NULL COMMENT '存在时间, 从创建到销毁' ,
`run_time`  int(11) NULL DEFAULT NULL COMMENT '运行时间, 从开始运行到销毁期间的时间' ,
`parse_time`  int(11) NULL DEFAULT NULL COMMENT '解析用户时间, 从开始解析用户到解析完成期间的时间' ,
`timestamp`  timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '时间戳' ,
PRIMARY KEY (`id`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
AUTO_INCREMENT=1

;

-- ----------------------------
-- Records of t_mom_task_list
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Procedure structure for p_cms_add_msg
-- ----------------------------
DROP PROCEDURE IF EXISTS `p_cms_add_msg`;
DELIMITER ;;
CREATE DEFINER=`root`@`127.0.0.1` PROCEDURE `p_cms_add_msg`(
	IN `IN_MSGID`		VARCHAR(128),
	IN `IN_COLUMN` 		VARCHAR(64),
	IN `IN_TITLE`		VARCHAR(256),
	IN `IN_SOURCE`		VARCHAR(32),
	IN `IN_ABSTRACT`	VARCHAR(512),
	IN `IN_CONTENT`		VARCHAR(4096),
	IN `IN_SIGN` 		VARCHAR(128),
	IN `IN_TEMPLATE` 	VARCHAR(64),
	IN `IN_INFO` 		VARCHAR(1024),
	IN `IN_IMG` 		VARCHAR(1024),
	IN `IN_ATTACH` 		VARCHAR(1024),
	IN `IN_KEYBOARDER`	VARCHAR(128),
	IN `IN_VALID`		DATETIME,
	IN `IN_INVALID`		DATETIME,
	OUT `err_no`		INT,
	OUT `err_msg`		VARCHAR(128)
)
    SQL SECURITY INVOKER
    COMMENT '添加消息'
p_cms_add_msg:
BEGIN
	-- 检查栏目是否存在
	SET @ColID= -1;
	SET @ColTYPE= -1;
	SET @ColFrom= 100;
	SELECT `id`, `col_type`, `col_from` INTO @ColID, @ColTYPE, @ColFrom FROM `t_cms_column` WHERE `col_id`= `IN_COLUMN`;
	IF @ColID= -1 THEN
		SET `err_no`= -1;
		SET `err_msg`= '栏目不存在';
		SELECT `err_no`, `err_msg`, @ColID AS category;
		LEAVE p_cms_add_msg;
	END IF;

	-- 检查模版是否存在
	SET @Template= -1;
	SELECT `id` INTO @Template FROM `t_cms_template` WHERE `tpl_id`= `IN_TEMPLATE`;

	SET @c_md5= MD5(CONCAT(`IN_TITLE`,'|',`IN_COLUMN`,'|',`IN_CONTENT`));
	-- 插入信息
	INSERT INTO `t_cms_msg_list` 
		( `msg_id`, `column`, `title`, `source`, `abstract`, 
		  `content`, `msg_sign`, `template`, `msg_info`, `img_list`, `attach_list`, 
		  `keyboarder`, `valid_time`, `invalid_time`, `status`, `md5`)
	VALUES 
		( `IN_MSGID`, @ColID, `IN_TITLE`, `IN_SOURCE`, `IN_ABSTRACT`, 
		  `IN_CONTENT`, `IN_SIGN`, @Template, `IN_INFO`, `IN_IMG`, `IN_ATTACH`, 
		  `IN_KEYBOARDER`, `IN_VALID`, `IN_INVALID`, 1, @c_md5)
	ON DUPLICATE KEY UPDATE `status` = 1;

	SELECT `id`,`msg_id`,`column`, CASE WHEN @ColTYPE= -1 THEN 1 ELSE @ColTYPE END AS coltype, @ColFrom AS colfrom FROM t_cms_msg_list WHERE `md5`= @c_md5;
	SET `err_no`= 0;
	SET `err_msg`= '添加信息成功';

END
;
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for p_cms_add_sign
-- ----------------------------
DROP PROCEDURE IF EXISTS `p_cms_add_sign`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `p_cms_add_sign`(
			IN `in_acc` 				VARCHAR(32),
			IN `in_sign_title` 	VARCHAR(32),
			IN `in_sign_info` 	VARCHAR(128),
			OUT `err_no` 				INT,
			OUT `err_msg` 			VARCHAR(128)
		)
    SQL SECURITY INVOKER
    COMMENT '新增签名'
p_cms_add_sign:
BEGIN
	DECLARE `_err` INT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET `_err` = 1;

	SELECT 1;
	START TRANSACTION ;
	INSERT INTO `t_cms_sign` ( `acc`, `sign_title`, `sign_info`) 
	VALUES ( `in_acc`, `in_sign_title`, `in_sign_info`);
	IF `_err`= 1 THEN
		SET `err_no`= -1;
		SET `err_msg`= '新增签名失败';
		ROLLBACK;
		LEAVE p_cms_add_sign;
	END IF;

	SET `err_no`= 0;
	SET `err_msg`= '';
	COMMIT;
END
;
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for p_cms_col_add
-- ----------------------------
DROP PROCEDURE IF EXISTS `p_cms_col_add`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `p_cms_col_add`(
			IN `in_col_name`	VARCHAR(64),
			IN `in_col_id`		VARCHAR(64),
			IN `in_col_info` 	VARCHAR(1024),
			IN `in_enabled` 	INT,
			IN `in_col_type` 	INT
		)
    SQL SECURITY INVOKER
    COMMENT '新增栏目'
BEGIN
	INSERT INTO `t_cms_column`( `col_name`, `col_id`, `col_info`, `enabled`, `col_from`, `col_type`)
	VALUES( `in_col_name`, `in_col_id`, `in_col_info`, `in_enabled`, 100, `in_col_type`) ON DUPLICATE KEY UPDATE `enabled`= `in_enabled`, `col_from`= 100, `col_type`=`in_col_type`;

	SELECT 1;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for p_cms_col_add_spec
-- ----------------------------
DROP PROCEDURE IF EXISTS `p_cms_col_add_spec`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `p_cms_col_add_spec`(
			IN `in_col_spec_id` 	VARCHAR(64),
			IN `in_col_spec_name` VARCHAR(64),
			IN `in_col_spec_info` VARCHAR(2048)
		)
    SQL SECURITY INVOKER
    COMMENT '更新栏目附属信息'
BEGIN
	INSERT INTO `t_cms_col_spec` ( `col_spec_id`, `col_spec_name`, `col_spec_info`)
	VALUES ( `in_col_spec_id`, `in_col_spec_name`, `in_col_spec_info`);

	SELECT 1;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for p_cms_col_add2
-- ----------------------------
DROP PROCEDURE IF EXISTS `p_cms_col_add2`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `p_cms_col_add2`(
			IN `in_col_name` 	VARCHAR(64),
			IN `in_col_id` 		VARCHAR(64),
			IN `in_col_info` 	VARCHAR(1024),
			IN `in_enabled` 	INT,
			IN `in_col_from` 	INT,
			IN `in_linkto` 		VARCHAR(128),
			IN `in_right`		INT,
			IN `in_col_type`	INT,
			OUT `err_no` 		INT,
			OUT `err_msg` 		VARCHAR(128)
		)
    SQL SECURITY INVOKER
    COMMENT '新增栏目2.0'
p_cms_col_add2:
BEGIN
	DECLARE `_err` INT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET `_err`= 1;
	SELECT 1;

/*
	SET @temp= NULL;
	SELECT `id` INTO @temp FROM `t_cms_col_from` WHERE `right`= `in_right` AND `SourceID`= `in_col_from`;
	IF @temp IS NULL THEN
		SET `err_no` = -1;
		SET `err_msg` = '本系统不允许添加栏目';
		LEAVE p_cms_col_add2;
	END IF;
*/

	START TRANSACTION ;
	SET @tempid= NULL, @tempname= NULL, @tempcolinfo= NULL, @templinkto= NULL, @tempcoltype= 1;
	SELECT `id`, `col_name`, `col_info`, `linkto`, `col_type` INTO @tempid, @tempname, @tempcolinfo, @templinkto, @tempcoltype FROM `t_cms_column` WHERE `col_id`= `in_col_id` AND `col_from`=`in_col_from`;
	IF @tempid IS NULL THEN
		INSERT INTO `t_cms_column`( `col_name`, `col_id`, `col_info`, `enabled`, `linkto`, `col_from`, `col_type`)
		VALUES( `in_col_name`, `in_col_id`, `in_col_info`, `in_enabled`, `in_linkto`, `in_col_from`, `in_col_type`);
	ELSE
		-- 名称
		IF @tempname!= `in_col_name` THEN
			UPDATE `t_cms_column` SET `col_name`= `in_col_name` WHERE `id`= @tempid;
		END IF;
		
		-- 栏目信息
		IF @tempcolinfo!= `in_col_info` THEN
			UPDATE `t_cms_column` SET `col_info`= `in_col_info` WHERE `id`= @tempid;
		END IF;
		
		-- 关联性
		IF @templinkto!= `in_linkto` THEN
			UPDATE `t_cms_column` SET `linkto`= `in_linkto` WHERE `id`= @tempid;
		END IF;

		-- 栏目类型
		IF @tempcoltype!= `in_col_type` THEN
			UPDATE `t_cms_column` SET `col_type`= `in_col_type` WHERE `id`= @tempid;
		END IF;		
	END IF;

	IF `_err` = 1 THEN
		SET `err_no` = -1;
		SET `err_msg` = '添加栏目失败';
		ROLLBACK;
		LEAVE p_cms_col_add2;
	END IF;
	SET `err_no` = 0;
	SET `err_msg` = '添加栏目成功';
	COMMIT;
END
;
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for p_cms_col_edit
-- ----------------------------
DROP PROCEDURE IF EXISTS `p_cms_col_edit`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `p_cms_col_edit`(
			IN `in_col_id`		VARCHAR(64),
			IN `in_col_name`	VARCHAR(64),
			IN `in_col_info` 	VARCHAR(1024),
			IN `in_enabled` 	INT,
			IN `in_col_type` 	INT,
			OUT `err_no` 		INT,
			OUT `err_msg` 		VARCHAR(128)
		)
    SQL SECURITY INVOKER
    COMMENT '新增栏目'
p_cms_col_edit:
BEGIN
	SET @cid= -1, @c_name= NULL, @c_info= NULL, @c_enable= -1, @c_type= -1;
	SELECT `id`, `col_name`, `col_info`, `enabled`, `col_type` INTO @cid, @c_name, @c_info, @c_enable, @c_type FROM `t_cms_column` 
	WHERE `col_id`= `in_col_id` AND `col_from`= 100;

	IF @cid= -1 THEN 
		SET `err_no`= -1;
		SET `err_msg`= '栏目不存在';
		LEAVE p_cms_col_edit;
	END IF;

	IF `in_col_name`<> '' THEN
		SET @c_name= `in_col_name`;
	END IF;

	IF `in_col_info`<> '' THEN
		SET @c_info= `in_col_info`;
	END IF;

	IF `in_enabled`<> -1 THEN
		SET @c_enable= `in_enabled`;
	END IF;

	IF `in_col_type`<> -1 THEN
		SET @c_type= `in_col_type`;
	END IF;

	UPDATE `t_cms_column` SET `col_name`= @c_name, `col_info`= @c_info, `enabled`= @c_enable, `col_type`= @c_type
	WHERE `id`= @cid;

	SET `err_no`= 0;
	SET `err_msg`= '更新栏目成功';
	SELECT 1;
END
;
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for p_cms_col_get
-- ----------------------------
DROP PROCEDURE IF EXISTS `p_cms_col_get`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `p_cms_col_get`(
			IN `in_limit_from` 	INT,
			IN `in_limit_size` 	INT,
			IN `in_col_enabled` INT,
			IN `in_simple_info` INT
		)
    SQL SECURITY INVOKER
    COMMENT '查询栏目'
BEGIN

	IF `in_simple_info`= 0 THEN
		SET @sql='SELECT `id`,`col_name`,`col_id`,`col_info`,`timestamp`,`subscribe_times`,`unsubscribe_times`,`enabled`,`linkto`,`col_from`,`col_type` FROM `t_cms_column`';
		IF `in_col_enabled`= 0 THEN
			SET @sql_str= CONCAT(@sql, ' WHERE ( `col_from`= 100 OR `col_from` IS NULL) AND `enabled`=', 0, ' ORDER BY `timestamp` LIMIT ', `in_limit_from`, ',', `in_limit_size`);
		ELSEIF `in_col_enabled`= 1 THEN
			SET @sql_str= CONCAT(@sql, ' WHERE ( `col_from`= 100 OR `col_from` IS NULL) AND `enabled`=', 1, ' ORDER BY `timestamp` LIMIT ', `in_limit_from`, ',', `in_limit_size`);
		ELSE
			SET @sql_str= CONCAT(@sql, ' WHERE ( `col_from`= 100 OR `col_from` IS NULL) ORDER BY `timestamp` LIMIT ', `in_limit_from`, ',', `in_limit_size`);
		END IF;
	ELSE
		SET @sql='SELECT `id`, `col_name`, `col_id` FROM t_cms_column';
		IF `in_col_enabled`= 0 THEN
			SET @sql_str= CONCAT(@sql, ' WHERE ( `col_from`= 100 OR `col_from` IS NULL) AND `enabled`=', 0, ' ORDER BY `timestamp` LIMIT ', `in_limit_from`, ',', `in_limit_size`);
		ELSEIF `in_col_enabled`= 1 THEN
			SET @sql_str= CONCAT(@sql, ' WHERE ( `col_from`= 100 OR `col_from` IS NULL) AND `enabled`=', 1, ' ORDER BY `timestamp` LIMIT ', `in_limit_from`, ',', `in_limit_size`);
		ELSE
			SET @sql_str= CONCAT(@sql, ' WHERE ( `col_from`= 100 OR `col_from` IS NULL) ORDER BY `timestamp` LIMIT ', `in_limit_from`, ',', `in_limit_size`);
		END IF;
	END IF;

	PREPARE STMT FROM @sql_str;
	EXECUTE STMT;
	DEALLOCATE PREPARE STMT;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for p_cms_col_get_spec
-- ----------------------------
DROP PROCEDURE IF EXISTS `p_cms_col_get_spec`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `p_cms_col_get_spec`(
			IN `in_col_spec_id` VARCHAR(64)
		)
    SQL SECURITY INVOKER
    COMMENT '查询订阅栏目'
BEGIN
	SELECT `col_spec_name`, `col_spec_info` FROM `t_cms_col_spec`
	WHERE `col_spec_id`= `in_col_spec_id` LIMIT 1;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for p_cms_col_get_spec_list
-- ----------------------------
DROP PROCEDURE IF EXISTS `p_cms_col_get_spec_list`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `p_cms_col_get_spec_list`(
			IN `in_limit_from` INT,
			IN `in_limit_size` INT
		)
    SQL SECURITY INVOKER
    COMMENT '查询栏目方案'
BEGIN
	SET @sql='SELECT * FROM `t_cms_col_spec` ORDER BY `id` LIMIT ';
	SET @sql_str= CONCAT( @sql, `in_limit_from`, ',', in_limit_size);

	PREPARE STMT FROM @sql_str;
  EXECUTE STMT;
  DEALLOCATE PREPARE STMT;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for p_cms_col_get_subscribe
-- ----------------------------
DROP PROCEDURE IF EXISTS `p_cms_col_get_subscribe`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `p_cms_col_get_subscribe`(
		IN `in_acc_type` 	VARCHAR(64),
		IN `in_acc_id` 		VARCHAR(256),
		IN `in_col_from` 	INT
	)
    SQL SECURITY INVOKER
    COMMENT '查询订阅栏目'
BEGIN
	IF `in_col_from` IS NULL OR `in_col_from`< 0 THEN
		SELECT tccs.`seq`, tcc.`col_id`, tcc.`col_from`, tcc.`id` as category, tccs.`enabled`, tcc.`col_name`, tcc.`col_info` from `t_cms_col_subscribe` tccs LEFT JOIN `t_cms_column` tcc ON tccs.`col_idx`= tcc.`id` WHERE tccs.`acc_type`= `in_acc_type` AND tccs.`acc_id`= `in_acc_id` AND tcc.`enabled`= 1 ORDER BY tccs.`seq` ASC;
	ELSE
		SELECT tccs.`seq`, tcc.`col_id`, tcc.`col_from`, tcc.`id` as category, tccs.`enabled`, tcc.`col_name`, tcc.`col_info` from `t_cms_col_subscribe` tccs LEFT JOIN `t_cms_column` tcc ON tccs.`col_idx`= tcc.`id` WHERE tccs.`acc_type`= `in_acc_type` AND tccs.`acc_id`= `in_acc_id` AND tcc.`enabled`= 1 AND tcc.`col_from`= `in_col_from` ORDER BY tccs.`seq` ASC;
	END IF;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for p_cms_col_get2
-- ----------------------------
DROP PROCEDURE IF EXISTS `p_cms_col_get2`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `p_cms_col_get2`(
		IN `in_limit_from` 	INT,
		IN `in_limit_size` 	INT,
		IN `in_col_enabled` INT,
		IN `in_col_from` 		INT,
		IN `in_simple_info` INT
	)
    SQL SECURITY INVOKER
    COMMENT '查询栏目2.0'
BEGIN

	IF `in_simple_info`= 0 THEN
		SET @sql='SELECT `id`,`col_name`,`col_id`,`col_info`,`timestamp`,`subscribe_times`,`unsubscribe_times`,`enabled`,`linkto`,`col_from`,`col_type` FROM `t_cms_column`';
		IF `in_col_enabled`= 0 THEN
			SET @sql_str= CONCAT(@sql, ' WHERE `enabled`=', 0, ' AND `col_from`= ', `in_col_from`, ' ORDER BY `timestamp` LIMIT ', `in_limit_from`, ',', `in_limit_size`);
		ELSEIF `in_col_enabled`= 1 THEN
			SET @sql_str= CONCAT(@sql, ' WHERE `enabled`=', 1, ' AND `col_from`= ', `in_col_from`, ' ORDER BY `timestamp` LIMIT ', `in_limit_from`, ',', `in_limit_size`);
		ELSE
			SET @sql_str= CONCAT(@sql, ' WHERE `col_from`= ', `in_col_from`, ' ORDER BY `timestamp` LIMIT ', `in_limit_from`, ',', `in_limit_size`);
		END IF;
	ELSE
		SET @sql='SELECT `id`, `col_name`, `col_id`, `col_from` FROM t_cms_column';
		IF `in_col_enabled`= 0 THEN
			SET @sql_str= CONCAT(@sql, ' WHERE `enabled`=', 0, ' AND `col_from`= ', `in_col_from`, ' ORDER BY `timestamp` LIMIT ', `in_limit_from`, ',', `in_limit_size`);
		ELSEIF `in_col_enabled`= 1 THEN
			SET @sql_str= CONCAT(@sql, ' WHERE `enabled`=', 1, ' AND `col_from`= ', `in_col_from`, ' ORDER BY `timestamp` LIMIT ', `in_limit_from`, ',', `in_limit_size`);
		ELSE
			SET @sql_str= CONCAT(@sql, ' WHERE `col_from`= ', `in_col_from`, ' ORDER BY `timestamp` LIMIT ', `in_limit_from`, ',', `in_limit_size`);
		END IF;
	END IF;

	PREPARE STMT FROM @sql_str;
	EXECUTE STMT;
	DEALLOCATE PREPARE STMT;

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for p_cms_col_remove
-- ----------------------------
DROP PROCEDURE IF EXISTS `p_cms_col_remove`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `p_cms_col_remove`(
			IN `in_col_from`	INT,
			IN `in_col_id` 		VARCHAR(64),
			IN `in_right`			INT,
			OUT `err_no`			INT,
			OUT `err_msg`			VARCHAR(128)
		)
    SQL SECURITY INVOKER
    COMMENT '删除栏目'
p_cms_col_remove:
BEGIN

	DECLARE `_err` INT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET `_err`= 1;
	SELECT 1;

	SET @temp= NULL;
	SELECT `id` INTO @temp FROM `t_cms_col_from` WHERE `right`= `in_right` AND `SourceID`= `in_col_from`;
	IF @temp IS NULL THEN
		SET `err_no` = -1;
		SET `err_msg` = '本系统不允许删除栏目';
		LEAVE p_cms_col_remove;
	END IF;

	START TRANSACTION ;
	IF `in_col_id` IS NULL OR `in_col_id`= '' THEN
		DELETE FROM `t_cms_column` WHERE `col_from`= `in_col_from`;
	ELSE
		DELETE FROM `t_cms_column` WHERE `col_from`= `in_col_from` AND `col_id`= `in_col_id`;
	END IF;

	IF `_err`= 1 THEN
		SET `err_no` = -1;
		SET `err_msg` = '删除栏目失败';
		ROLLBACK;
		LEAVE p_cms_col_remove;
	END IF;
	SET `err_no` = 0;
	SET `err_msg` = '';
	COMMIT;
END
;
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for p_cms_col_subscribe
-- ----------------------------
DROP PROCEDURE IF EXISTS `p_cms_col_subscribe`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `p_cms_col_subscribe`(
			IN `in_acc_type`	VARCHAR(64),
			IN `in_acc_id` 		VARCHAR(256),
			IN `in_col_id` 		VARCHAR(64),
			IN `in_comment` 	VARCHAR(128),
			IN `in_seq` 			VARCHAR(11),
			OUT `err_no` 			INT,
			OUT `err_msg` 		VARCHAR(128)
		)
    SQL SECURITY INVOKER
    COMMENT '创建新的绑定关系，同时将相关的项目绑定计数自增1'
p_cms_col_subscribe:
BEGIN
	# 添加订阅关系
	DECLARE `_err` INT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET `_err` = 1;
	SELECT 1;

	SET @id = null;
	SELECT tcc.`id` INTO @id FROM `t_cms_column` tcc where tcc.`col_id`= `in_col_id` AND `col_from`= 100;
	IF @id IS NULL THEN
		SET `err_no`= -1;
		SET `err_msg`= '栏目ID不存在';
		LEAVE p_cms_col_subscribe;
	END IF;

	IF `in_seq` IS NULL OR `in_seq`= '' THEN
		SET `err_no`= -1;
		SET `err_msg`= '订阅序列错误';
		LEAVE p_cms_col_subscribe;
	END IF;

	SET @seq= CONVERT( `in_seq`, signed);

	INSERT INTO `t_cms_col_subscribe`( `acc_type`, `acc_id`, `col_idx`, `comment`, `enabled`, `seq`)
	VALUES( `in_acc_type`, `in_acc_id`, @id, `in_comment`, 1, @seq)
	ON DUPLICATE KEY UPDATE `comment`= `in_comment`, `enabled`= 1, `seq`= @seq;

	# 订阅次数增加1
	UPDATE `t_cms_column` SET `subscribe_times`= `subscribe_times`+ 1
	WHERE `col_id`= `in_col_id`;

	IF `_err`= 1 THEN
		SET `err_no`= -1;
		SET `err_msg`= '订阅PROC异常';
		ROLLBACK;
		LEAVE p_cms_col_subscribe;
	END IF;

	COMMIT;

	SET `err_no`= 0;
	SET `err_msg`= '订阅成功';
END
;
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for p_cms_col_subscribe2
-- ----------------------------
DROP PROCEDURE IF EXISTS `p_cms_col_subscribe2`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `p_cms_col_subscribe2`(
			IN `in_acc_type` varchar(64),
			IN `in_acc_id` varchar(256),
			IN `in_col_id` varchar(64),
			IN `in_comment` varchar(128),
			IN `in_seq` VARCHAR(11),
			IN `in_col_from` int(20),
			OUT `err_no` INT,
			OUT `err_msg` VARCHAR(128)
		)
    SQL SECURITY INVOKER
    COMMENT '栏目订阅2.0 创建新的绑定关系，同时将相关的项目绑定计数自增1'
p_cms_col_subscribe2:
BEGIN
	# 添加订阅关系
	DECLARE `_err` int DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET `_err` = 1;
	SELECT 1;

	SET @id = NULL;
	SELECT tcc.`id` INTO @id FROM `t_cms_column` tcc WHERE tcc.`col_id`= `in_col_id` AND `col_from`= `in_col_from`;
	IF @id IS NULL THEN
		SET `err_no`= -1;
		SET `err_msg`= '栏目ID不存在';
		LEAVE p_cms_col_subscribe2;
	END IF;

	IF `in_seq` IS NULL OR `in_seq`= '' THEN
		SET `in_seq`= '0';
	END IF;

	SET @seq = convert( `in_seq`,signed);

	INSERT INTO t_cms_col_subscribe(`acc_type`, `acc_id`, `col_idx`, `comment`,`enabled`,`seq`)
	VALUES( `in_acc_type`, `in_acc_id`, @id, `in_comment`, 1,@seq)
	ON DUPLICATE KEY UPDATE `comment` = `in_comment`,`enabled`= 1,`seq`= @seq;

	# 订阅次数增加1
	UPDATE `t_cms_column` SET `subscribe_times`= `subscribe_times`+ 1 WHERE `id`= @id;

	IF `_err`= 1 THEN
		SET `err_no`= -1;
		SET `err_msg`= '订阅PROC异常';
		ROLLBACK;
		LEAVE p_cms_col_subscribe2;
	END IF;

	COMMIT;

	SET `err_no`= 0;
	SET `err_msg`='订阅成功';
END
;
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for p_cms_col_unsubscribe
-- ----------------------------
DROP PROCEDURE IF EXISTS `p_cms_col_unsubscribe`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `p_cms_col_unsubscribe`(
		IN `in_acc_type` 	VARCHAR(64),
		IN `in_acc_id` 		VARCHAR(256),
		IN `in_col_id` 		VARCHAR(64),
		IN `in_col_from`	int(20),
		IN `in_comment` 	VARCHAR(128),
		IN `in_seq` 		VARCHAR(11),
		OUT `err_no` INT,
		OUT `err_msg` VARCHAR(128)
	)
    SQL SECURITY INVOKER
    COMMENT '取消订阅'
p_cms_col_unsubscribe:
BEGIN
	SET @seq = CONVERT( `in_seq`, signed);

	SET @id = NULL;
	SELECT tcc.`id` INTO @id FROM `t_cms_column` tcc WHERE tcc.`col_id`= `in_col_id` AND `col_from`= `in_col_from`;
	IF @id IS NULL THEN
		SET `err_no`= -1;
		SET `err_msg`= '栏目ID不存在';
		LEAVE p_cms_col_unsubscribe;
	END IF;

	UPDATE `t_cms_col_subscribe` SET `enabled`=0, `comment`= `in_comment`, `seq`= @seq
	WHERE `acc_id`= `in_acc_id` AND `acc_type`= in_acc_type AND `enabled`= 1 AND `col_idx`= @id;


	# 取消订阅次数增加1
	UPDATE `t_cms_column` SET `unsubscribe_times`= `unsubscribe_times`+1 WHERE `id`= @id;

	SELECT 1;
END
;
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for p_cms_colatt_add
-- ----------------------------
DROP PROCEDURE IF EXISTS `p_cms_colatt_add`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `p_cms_colatt_add`(
			IN `in_col_from` 	INT,
			IN `in_col_id` 		VARCHAR(64),
			IN `in_comment` 	VARCHAR(128),
			IN `in_var1` 			VARCHAR(64),
			IN `in_var2` 			VARCHAR(64),
			IN `in_var3` 			VARCHAR(64),
			IN `in_var4` 			VARCHAR(64),
			IN `in_var5` 			VARCHAR(64),
			OUT `err_no` 			INT,
			OUT `err_msg` 		VARCHAR(128)
		)
    SQL SECURITY INVOKER
    COMMENT '更新栏目附属信息'
p_cms_colatt_add:
BEGIN
	DECLARE `_err` INT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET `_err`= 1;
	SELECT 1;
	
	SET @id= NULL;
	SELECT `id` INTO @id FROM `t_cms_column` WHERE `col_id`= `in_col_id` AND `col_from`= `in_col_from`;
	IF @id IS NULL THEN
		SET `err_no` = -1;
		SET `err_msg` = '无该栏目';
		LEAVE p_cms_colatt_add;
	END IF;
	
	SET @temp= NULL;
	SELECT `id` INTO @temp FROM `t_cms_column_attach` WHERE `id`=@id;
	IF @temp IS NULL THEN
		INSERT INTO `t_cms_column_attach`( `id`, `comment`, `var1`, `var2`, `var3`, `var4`, `var5`)
		VALUES( @id, `in_comment`, `in_var1`, `in_var2`, `in_var3`, `in_var4`, `in_var5`);
	ELSE
		IF `in_comment` IS NOT NULL AND `in_comment`!= '' THEN
			UPDATE `t_cms_column_attach` SET `comment`= `in_comment` WHERE `id`= @id;
		END IF;
		
		IF `in_var1` IS NOT NULL AND `in_var1`!= '' THEN
			UPDATE `t_cms_column_attach` SET `var1`= `in_var1` WHERE `id`= @id;
		END IF;
		
		IF `in_var2` IS NOT NULL AND `in_var2`!= '' THEN
			UPDATE `t_cms_column_attach` SET `var2`= `in_var2` WHERE `id`= @id;
		END IF;
		
		IF `in_var3` IS NOT NULL AND `in_var3`!= '' THEN
			UPDATE `t_cms_column_attach` SET `var3`= `in_var3` WHERE `id`= @id;
		END IF;
		
		IF `in_var4` IS NOT NULL AND `in_var4`!= '' THEN
			UPDATE `t_cms_column_attach` SET `var4`= `in_var4` WHERE `id`= @id;
		END IF;
		
		IF `in_var5` IS NOT NULL AND `in_var5`!= '' THEN
			UPDATE `t_cms_column_attach` SET `var5`= `in_var5` WHERE `id`= @id;
		END IF;
	END IF;
	
	
	IF `_err`= 1 THEN
		SET `err_no` = -1;
		SET `err_msg` = '更新栏目附属信息失败';
		ROLLBACK;
		LEAVE p_cms_colatt_add;
	END IF;
	COMMIT;
	SET `err_no`= 0;
	SET `err_msg`= '更新栏目附属属性成功';
END
;
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for p_cms_colatt_get
-- ----------------------------
DROP PROCEDURE IF EXISTS `p_cms_colatt_get`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `p_cms_colatt_get`(
			IN `in_col_from` INT
		)
    SQL SECURITY INVOKER
    COMMENT '获取栏目附属信息'
BEGIN
	SELECT tcc.`id` AS category, tcc.`col_id`, tcc.`col_name`, tcca.`var1`, tcca.`var2` FROM `t_cms_column` tcc 
		LEFT JOIN `t_cms_column_attach` tcca ON tcc.`id`= tcca.`id` 
		WHERE tcc.`col_from`= `in_col_from`;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for p_cms_colfrom_get
-- ----------------------------
DROP PROCEDURE IF EXISTS `p_cms_colfrom_get`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `p_cms_colfrom_get`(
			IN `in_sourceid` int(20)
		)
    SQL SECURITY INVOKER
    COMMENT '获取栏目类别信息'
BEGIN
	SELECT `SourceID`, `Source`, `right` FROM t_cms_col_from;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for p_cms_del_app
-- ----------------------------
DROP PROCEDURE IF EXISTS `p_cms_del_app`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `p_cms_del_app`(
	IN `in_appid` 			VARCHAR(64)
)
    SQL SECURITY INVOKER
    COMMENT '删除app定义'
BEGIN
	-- DELETE FROM `t_cms_apps` WHERE `appid`= `in_appid`;
	DELETE FROM `t_cms_col_from` WHERE `SourceID`= `in_appid`;

	# 避免C代码调用错误
	SELECT 1;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for p_cms_del_sign
-- ----------------------------
DROP PROCEDURE IF EXISTS `p_cms_del_sign`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `p_cms_del_sign`(
			IN `in_id` 		BIGINT,
			IN `in_acc` 	VARCHAR(32),
			OUT `err_no`	INT,
			OUT `err_msg` VARCHAR(128)
		)
    SQL SECURITY INVOKER
    COMMENT '删除签名'
p_cms_del_sign:
BEGIN
	DECLARE `_err` INT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET `_err`= 1;

	SELECT 1;

	SET @temp= NULL;
	SELECT `id` INTO @temp FROM `t_cms_sign` WHERE `id`= `in_id`;
	IF @temp IS NULL THEN
		SET `err_no`= -1;
		SET `err_msg`= '签名已删除';
		LEAVE p_cms_del_sign;
	END IF;

	START TRANSACTION ;
	DELETE FROM `t_cms_sign` WHERE `id`= `in_id` AND `acc`= `in_acc`;

	IF `_err`= 1 THEN
		SET `err_no`= -1;
		SET `err_msg`= '删除签名失败';
		ROLLBACK;
		LEAVE p_cms_del_sign;
	END IF;

	SET `err_no`= 0;
	SET `err_msg`= '';
	COMMIT;
END
;
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for p_cms_draft_del
-- ----------------------------
DROP PROCEDURE IF EXISTS `p_cms_draft_del`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `p_cms_draft_del`(
	IN `in_id` 						BIGINT,
	IN `in_acc_type` 			VARCHAR(32),
  	IN `in_acc_id` 				VARCHAR(64)
)
    SQL SECURITY INVOKER
    COMMENT '读取上次草稿信息'
BEGIN
		DELETE FROM `t_cms_msg_draft` WHERE `id`= `in_id` AND `acc_id`= `in_acc_id` AND `acc_type`= `in_acc_type`;
	
		# 避免C代码调用错误
		SELECT 1;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for p_cms_draft_load
-- ----------------------------
DROP PROCEDURE IF EXISTS `p_cms_draft_load`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `p_cms_draft_load`(
	IN `in_id` 					BIGINT,
	IN `in_acc_type` 			VARCHAR(32),
  	IN `in_acc_id` 				VARCHAR(64)
)
    SQL SECURITY INVOKER
    COMMENT '读取上次草稿信息'
BEGIN
	IF `in_id` IS NULL OR `in_id`<= 0 THEN
		SELECT `id`, `msg_draft`, `last_time` FROM `t_cms_msg_draft` WHERE `acc_id`= `in_acc_id` AND `acc_type`= `in_acc_type`;
	ELSE
		SELECT `id`, `msg_draft`, `last_time` FROM `t_cms_msg_draft` WHERE `id`= `in_id` AND `acc_id`= `in_acc_id` AND `acc_type`= `in_acc_type`;
	END IF;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for p_cms_draft_save
-- ----------------------------
DROP PROCEDURE IF EXISTS `p_cms_draft_save`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `p_cms_draft_save`(
	IN `in_id` 				BIGINT,
	IN `in_acc_type` 		VARCHAR(32),
  	IN `in_acc_id` 			VARCHAR(64),
	IN `in_draft`			MEDIUMTEXT
)
    SQL SECURITY INVOKER
    COMMENT '保存草稿'
BEGIN
	IF `in_id` IS NULL OR `in_id`<= 0 THEN
			INSERT INTO `t_cms_msg_draft` ( `acc_type`, `acc_id`, `msg_draft`, `last_time`)
			VALUES ( `in_acc_type`, `in_acc_id`, `in_draft`, NOW());
	ELSE
			UPDATE `t_cms_msg_draft` SET `msg_draft`= `in_draft`, `last_time`=NOW() WHERE `id`= `in_id`;
	END IF;

	# 避免C代码调用错误
	SELECT 1;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for p_cms_edit_sign
-- ----------------------------
DROP PROCEDURE IF EXISTS `p_cms_edit_sign`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `p_cms_edit_sign`(
			IN `in_id` 					BIGINT,
			IN `in_acc` 				VARCHAR(32),
			IN `in_sign_title` 	VARCHAR(32),
			IN `in_sign_info` 	VARCHAR(128),
			OUT `err_no` 				INT,
			OUT `err_msg` 			VARCHAR(128)
		)
    SQL SECURITY INVOKER
    COMMENT '编辑签名'
p_cms_edit_sign:
BEGIN
	DECLARE `_err` INT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET `_err`= 1;

	SELECT 1;

	START TRANSACTION ;
	UPDATE `t_cms_sign` SET `sign_title`= `in_sign_title`, `sign_info`= `in_sign_info` WHERE `id`= `in_id` AND `acc`= `in_acc`;
	IF `_err`= 1 THEN
		SET `err_no`= -1;
		SET `err_msg`= '编辑签名失败';
		ROLLBACK;
		LEAVE p_cms_edit_sign;
	END IF;

	SET `err_no`= 0;
	SET `err_msg`= '';
	COMMIT;
END
;
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for p_cms_get_apps
-- ----------------------------
DROP PROCEDURE IF EXISTS `p_cms_get_apps`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `p_cms_get_apps`(
	IN `in_appid` 			VARCHAR(64)
)
    SQL SECURITY INVOKER
    COMMENT '获取app定义'
BEGIN
/*
	IF `in_appid` IS NULL OR `in_appid`= '' THEN
		SELECT `id`,`appid`,`appname`,`timestamp` FROM `t_cms_apps`;
	ELSE
		SELECT `id`,`appid`,`appname`,`timestamp` FROM `t_cms_apps` WHERE `appid`= `in_appid`;
	END IF;
*/
	IF `in_appid` IS NULL OR `in_appid`= '' THEN
		SELECT `id`,`SourceID`,`Source`,`timestamp` FROM `t_cms_col_from`;
	ELSE
		SELECT `id`,`SourceID`,`Source`,`timestamp` FROM `t_cms_col_from` WHERE `SourceID`= `in_appid`;
	END IF;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for p_cms_get_msglist
-- ----------------------------
DROP PROCEDURE IF EXISTS `p_cms_get_msglist`;
DELIMITER ;;
CREATE DEFINER=`root`@`127.0.0.1` PROCEDURE `p_cms_get_msglist`(
	IN `IN_COLUMN` 		VARCHAR(64),
	INOUT `IO_POS`		INT,
	IN `IN_SIZE`		INT,
	OUT `O_COLTYPE`		INT,
	OUT `err_no`		INT,
	OUT `err_msg`		VARCHAR(128)
)
    SQL SECURITY INVOKER
    COMMENT '获取消息列表'
p_cms_get_msglist:
BEGIN
	IF `IO_POS`< 0 THEN
		SET `IO_POS`= 0;
	END IF;
	-- 检查栏目是否存在
	SET @ColID= -1;
	SET O_COLTYPE= -1;
	SELECT `id`, `col_type` INTO @ColID, O_COLTYPE FROM `t_cms_column` WHERE `col_id`= `IN_COLUMN`;
	IF @ColID= -1 THEN
		SET `err_no`= -1;
		SET `err_msg`= '栏目不存在';
		SELECT `err_no`, `err_msg`, @ColID AS category;
		LEAVE p_cms_get_msglist;
	END IF;

	IF O_COLTYPE<> 1 THEN
		SELECT '' AS 'msg_id','' AS 'title','' AS 'abstract','1970-01-01 00:00:00' AS 'timestamp','' AS 'column', 0 AS 'read_flag' ;
		SET `err_no`= 0;
		SET `err_msg`= '用户私有信息';
		LEAVE p_cms_get_msglist;
	END IF;

	-- 获取消息
	IF `IN_SIZE`<= 0 THEN
	SET @sql=CONCAT('SELECT COUNT(cml.`msg_id`) AS \'count\'
			FROM `t_cms_msg_list` AS cml INNER JOIN `t_cms_column` AS cc ON cml.`column`= cc.`id` 
			WHERE cc.`col_id`= \'',`IN_COLUMN`, '\' AND cml.`status`= 1');
	ELSE
	SET @sql=CONCAT('SELECT cml.`msg_id`,cml.`title`,cml.`abstract`,cml.`timestamp`,cc.`col_id`, 1 AS \'read_flag\' 
			FROM `t_cms_msg_list` AS cml INNER JOIN `t_cms_column` AS cc ON cml.`column`= cc.`id` 
			WHERE cc.`col_id`= \'',`IN_COLUMN`, '\' AND cml.`status`= 1 ORDER BY cml.`timestamp` DESC LIMIT ', `IO_POS`, ',', `IN_SIZE`);
	END IF;

	PREPARE STMT FROM @sql;
	EXECUTE STMT;
	DEALLOCATE PREPARE STMT;

	IF `IN_SIZE`<= 0 THEN
		SET `IO_POS`= 0;
	ELSE
		SET `IO_POS`= `IO_POS`+ found_rows();
	END IF;

	SET `err_no`= 0;
	SET `err_msg`= '获取消息列表成功';
END
;
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for p_cms_new_app
-- ----------------------------
DROP PROCEDURE IF EXISTS `p_cms_new_app`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `p_cms_new_app`(
	IN `in_appid` 			VARCHAR(64),
	IN `in_appname` 		VARCHAR(64)
)
    SQL SECURITY INVOKER
    COMMENT '增加/更新app定义'
BEGIN
	-- INSERT INTO `t_cms_apps` ( `appid`, `appname`) VALUES ( `in_appid`, `in_appname`) ON DUPLICATE KEY UPDATE `appname`= `in_appname`;

	INSERT INTO `t_cms_col_from` ( `SourceID`, `Source`, `right`) VALUES ( `in_appid`, `in_appname`, 1) ON DUPLICATE KEY UPDATE `Source`= `in_appname`;

	# 避免C代码调用错误
	SELECT 1;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for p_cms_query_sign
-- ----------------------------
DROP PROCEDURE IF EXISTS `p_cms_query_sign`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `p_cms_query_sign`(
			IN `in_acc` 	VARCHAR(32),
			OUT `err_no` 	INT,
			OUT `err_msg` VARCHAR(128)
		)
    SQL SECURITY INVOKER
    COMMENT '查询用户签名'
p_cms_query_sign:
BEGIN
	DECLARE `_err` INT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET `_err`= 1;

	SELECT tcs.`id`, tcs.`sign_title`, tcs.`sign_info`, tcs.`in_use` FROM `t_cms_sign` tcs 
	WHERE tcs.`acc`= `in_acc`;

	IF `_err` = 1 THEN
		SET `err_no`= -1;
		SET `err_msg`= '查询签名失败';
		LEAVE p_cms_query_sign;
	END IF;

	SET `err_no`= 0;
	SET `err_msg`= '';
	COMMIT;
END
;
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for p_cms_set_cur_sign
-- ----------------------------
DROP PROCEDURE IF EXISTS `p_cms_set_cur_sign`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `p_cms_set_cur_sign`(
			IN `in_id` 		BIGINT,
			IN `in_acc` 	VARCHAR(32),
			OUT `err_no` 	INT,
			OUT `err_msg` VARCHAR(128)
		)
    SQL SECURITY INVOKER
    COMMENT '设置当前签名'
p_cms_set_cur_sign:
BEGIN
	DECLARE `_err` INT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET `_err`= 1;
	
	SELECT 1;
	
	START TRANSACTION ;
	UPDATE `t_cms_sign` SET `in_use`= 0 WHERE `acc`= `in_acc`;
	UPDATE `t_cms_sign` SET `in_use`= 1 WHERE `id`= `in_id` AND `acc`= `in_acc`;
	
	IF `_err`= 1 THEN
		SET `err_no`= -1;
		SET `err_msg`= '设置当前签名失败';
		ROLLBACK;
		LEAVE p_cms_set_cur_sign;
	END IF;
	SET `err_no`= 0;
	SET `err_msg`= '';
	COMMIT;
END
;
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for p_cms_stock_get_subscribe
-- ----------------------------
DROP PROCEDURE IF EXISTS `p_cms_stock_get_subscribe`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `p_cms_stock_get_subscribe`(
			IN `in_acc_type` 	VARCHAR(32),
			IN `in_acc_id` 		VARCHAR(64),
			IN `in_flag` 			VARCHAR(64)
		)
    SQL SECURITY INVOKER
    COMMENT '查询已订阅股票'
BEGIN
	SELECT `id`, `stock_code`, `set_code`, `stock_name`, `flag` FROM `t_cms_user_stock` 
	WHERE `acc_type`= `in_acc_type` AND `acc_id`= `in_acc_id` AND `flag`&`in_flag`<> 0;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for p_cms_stock_subscribe
-- ----------------------------
DROP PROCEDURE IF EXISTS `p_cms_stock_subscribe`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `p_cms_stock_subscribe`(
			IN `in_acc_type` 		VARCHAR(32),
			IN `in_acc_id` 			VARCHAR(64),
			IN `in_stock_code` 	VARCHAR(64),
			IN `in_set_code` 		VARCHAR(10),
			IN `in_stock_name` 	VARCHAR(64),
			IN `in_sub_flag` 		INT,
			IN `in_unsub_flag` 	INT,
			OUT `err_no` 				INT,
			OUT `err_msg` 			VARCHAR(128)
		)
    SQL SECURITY INVOKER
    COMMENT '订阅/退订股票'
p_cms_stock_subscribe:
BEGIN
	DECLARE `_err` INT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET `_err`= 1;

	IF `in_sub_flag` IS NULL OR `in_sub_flag`< 0 THEN
		SET `in_sub_flag`= 0;
	END IF;
	
	IF `in_unsub_flag` IS NULL OR `in_unsub_flag`< 0 THEN
		SET `in_unsub_flag`= 0;
	END IF;

	START TRANSACTION ;
	-- 订阅栏目
	SET @temp= NULL;
	SELECT `id` INTO @temp FROM `t_cms_user_stock` WHERE `acc_type`= `in_acc_type` AND `acc_id`= `in_acc_id` AND `stock_code`= `in_stock_code` AND `set_code`= `in_set_code`;
	IF @temp IS NULL THEN
		INSERT INTO `t_cms_user_stock`( `acc_type`, `acc_id`, `stock_code`, `set_code`, `stock_name`, `flag`, `last`) 
		VALUES( `in_acc_type`, `in_acc_id`, `in_stock_code`, `in_set_code`, `in_stock_name`, `in_sub_flag`, NOW());
	ELSE
		IF in_sub_flag> 0 THEN
			UPDATE `t_cms_user_stock` SET `flag`= `flag`|`in_sub_flag`, `stock_name`= `in_stock_name` 
			WHERE `acc_type`= `in_acc_type` AND `acc_id`= `in_acc_id` AND `stock_code`= `in_stock_code` AND `set_code`= `in_set_code`;
		END IF;
	END IF;
	-- 退订栏目
	IF in_unsub_flag> 0 THEN
		UPDATE `t_cms_user_stock` SET `flag`= `flag`- (`flag`&`in_unsub_flag`), `stock_name`= `in_stock_name` 
		WHERE `acc_type`= `in_acc_type` AND `acc_id`= `in_acc_id` AND `stock_code`= `in_stock_code` AND `set_code`= `in_set_code`;
	END IF;

	IF `_err`= 1 THEN
		SET `err_no`= -1;
		SET `err_msg`= '订阅股票失败';
		ROLLBACK;
		LEAVE p_cms_stock_subscribe;
	END IF;
	SET `err_no`= 0;
	SET `err_msg`= '';
	COMMIT;
END
;
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for p_cms_task_job_del
-- ----------------------------
DROP PROCEDURE IF EXISTS `p_cms_task_job_del`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `p_cms_task_job_del`(
			IN `in_id` 			BIGINT
		)
    SQL SECURITY INVOKER
    COMMENT '删除定时任务'
BEGIN
		DELETE FROM `t_cms_task_job` WHERE `id`= `in_id`;

	# 避免C代码调用错误
	SELECT 1;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for p_cms_task_job_get
-- ----------------------------
DROP PROCEDURE IF EXISTS `p_cms_task_job_get`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `p_cms_task_job_get`(
			IN `in_id` 			BIGINT
		)
    SQL SECURITY INVOKER
    COMMENT '查询定时任务'
BEGIN

	# 避免C代码调用错误
	IF `in_id`<= 0 THEN
		SELECT `id`, `job_name`, `job_info`, `job_type`, `job_time`, `last_time`, `job_status`, `timestamp` FROM	`t_cms_task_job`;
	ELSE
		SELECT `id`, `job_name`, `job_info`, `job_type`, `job_time`, `last_time`, `job_status`, `timestamp` FROM	`t_cms_task_job` WHERE `id`= `in_id`;
	END IF;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for p_cms_task_job_gettoday
-- ----------------------------
DROP PROCEDURE IF EXISTS `p_cms_task_job_gettoday`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `p_cms_task_job_gettoday`(
			IN `in_resv` 			BIGINT
		)
    SQL SECURITY INVOKER
    COMMENT '查询当日定时任务'
BEGIN
		SET @nowtime= NOW();
		SELECT `id`, `job_name`, `job_info`, `job_type`, `job_time`, `last_time`, `job_status`, `timestamp` 
			FROM `t_cms_task_job` WHERE `job_type`= 1 
				AND TO_DAYS( `job_time`)<= TO_DAYS(@nowtime) 
				AND (`job_status`=0 OR `job_status` IS NULL)
				AND ( HOUR( @nowtime)>= HOUR(`job_time`) AND MINUTE( @nowtime)>= MINUTE(`job_time`) AND SECOND( @nowtime)>= SECOND(`job_time`) )
		UNION ALL
		SELECT `id`, `job_name`, `job_info`, `job_type`, `job_time`, `last_time`, `job_status`, `timestamp` 
			FROM `t_cms_task_job` WHERE `job_type`= 4 
				AND ( `last_time` IS NULL OR TO_DAYS( `last_time`) IS NULL OR TO_DAYS( `last_time`)<> TO_DAYS(@nowtime))
				AND ( HOUR( @nowtime)>= HOUR(`job_time`) AND MINUTE( @nowtime)>= MINUTE(`job_time`) AND SECOND( @nowtime)>= SECOND(`job_time`) )
		UNION ALL
		SELECT `id`, `job_name`, `job_info`, `job_type`, `job_time`, `last_time`, `job_status`, `timestamp` 
			FROM `t_cms_task_job` WHERE `job_type`= 2 
				AND DAYOFWEEK( `job_time`)= DAYOFWEEK( @nowtime) 
				AND TO_DAYS( `job_time`)<= TO_DAYS(@nowtime) 
				AND ( `last_time` IS NULL OR TO_DAYS( `last_time`) IS NULL OR TO_DAYS( `last_time`)<> TO_DAYS(@nowtime))
				AND ( HOUR( @nowtime)>= HOUR(`job_time`) AND MINUTE( @nowtime)>= MINUTE(`job_time`) AND SECOND( @nowtime)>= SECOND(`job_time`) )
		UNION ALL
		SELECT `id`, `job_name`, `job_info`, `job_type`, `job_time`, `last_time`, `job_status`, `timestamp` 
			FROM `t_cms_task_job` WHERE `job_type`= 3 
				AND DAYOFMONTH( `job_time`)= DAYOFMONTH( @nowtime) 
				AND TO_DAYS( `job_time`)<= TO_DAYS(@nowtime) 
				AND ( `last_time` IS NULL OR TO_DAYS( `last_time`) IS NULL OR TO_DAYS( `last_time`)<> TO_DAYS(@nowtime))
				AND ( HOUR( @nowtime)>= HOUR(`job_time`) AND MINUTE( @nowtime)>= MINUTE(`job_time`) AND SECOND( @nowtime)>= SECOND(`job_time`) );

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for p_cms_task_job_new
-- ----------------------------
DROP PROCEDURE IF EXISTS `p_cms_task_job_new`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `p_cms_task_job_new`(
	IN `in_job_name` 				VARCHAR(64),
	IN `in_job_info` 				MEDIUMTEXT,
	IN `in_job_type` 				INT,
	IN `in_job_time` 				DATETIME
)
    SQL SECURITY INVOKER
    COMMENT '新建定时任务'
BEGIN
		INSERT INTO `t_cms_task_job` ( `job_name`, `job_info`, `job_type`, `job_time`, `last_time`, `job_status`)
		VALUES ( `in_job_name`, `in_job_info`, `in_job_type`, `in_job_time`, NULL, 0);

	# 避免C代码调用错误
	SELECT 1;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for p_cms_task_job_pushed
-- ----------------------------
DROP PROCEDURE IF EXISTS `p_cms_task_job_pushed`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `p_cms_task_job_pushed`(
			IN `in_jobid` 			BIGINT
		)
    SQL SECURITY INVOKER
    COMMENT '定时任务推送成功'
BEGIN
	UPDATE `t_cms_task_job` SET `last_time`= NOW(), `job_status`= 1 WHERE `id`= `in_jobid`;
	SELECT 1;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for p_cms_update_col
-- ----------------------------
DROP PROCEDURE IF EXISTS `p_cms_update_col`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `p_cms_update_col`(
			IN `in_col_id` 		VARCHAR(64),
			IN `in_col_name` 	VARCHAR(128),
			IN `in_col_info` 	VARCHAR(1024),
			OUT `err_no` 			INT,
			OUT `err_msg` 		VARCHAR(128)
		)
    SQL SECURITY INVOKER
    COMMENT '更新栏目信息'
p_cms_update_col:
BEGIN
	DECLARE `_err` INT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET `_err`= 1;

	SET @col_name= NULL, @col_info= NULL;
	SELECT `col_name`, `col_info` into @col_name, @col_info FROM `t_cms_column` WHERE `col_id`= `in_col_id` LIMIT 1;
	IF `in_col_name` IS NULL THEN
		SET @col_name= `in_col_name`;
	END IF;
	IF `in_col_info` IS NULL THEN
		SET @col_info= `in_col_info`;
	END IF;

	UPDATE `t_cms_column` SET `col_name`= @col_name, `col_info`= @col_info WHERE `col_id`= `in_col_id`;

	IF `_err`= 1 THEN
		SET `err_no`= -1;
		SET `err_msg`= '更新栏目失败';
		ROLLBACK;
		LEAVE p_cms_update_col;
	END IF;
	SET `err_no`= 0;
	SET `err_msg`= '';
	COMMIT;
END
;
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for tdx_sys_new_col
-- ----------------------------
DROP PROCEDURE IF EXISTS `tdx_sys_new_col`;
DELIMITER ;;
CREATE DEFINER=`root`@`127.0.0.1` PROCEDURE `tdx_sys_new_col`(
  IN `IN_TABLENAME` VARCHAR(128),
  IN `IN_COLNAME`   VARCHAR(128),
  IN `IN_TYPEANDDEF`  VARCHAR(1024),
  IN `IN_COMMENT`    VARCHAR(1024)
)
BEGIN
  IF NOT EXISTS ( SELECT `COLUMN_NAME` FROM `information_schema`.`COLUMNS` WHERE 
                    `TABLE_SCHEMA`=DATABASE() AND `TABLE_NAME` = `IN_TABLENAME` AND `COLUMN_NAME` = `IN_COLNAME`)
  THEN
    SET @stmt=CONCAT( 'ALTER TABLE ', `IN_TABLENAME`, ' ADD COLUMN ', `IN_COLNAME`, ' ', `IN_TYPEANDDEF`);
    IF `IN_COMMENT` IS NOT NULL AND `IN_COMMENT`<> '' THEN
      SET @stmt= CONCAT( @stmt, ' COMMENT \'', `IN_COMMENT`, '\'');
    END IF;

    PREPARE st FROM @stmt;
      EXECUTE st;
    DEALLOCATE PREPARE st;
  END IF;    
END
;;
DELIMITER ;

-- ----------------------------
-- Auto increment value for t_cms_apps
-- ----------------------------
ALTER TABLE `t_cms_apps` AUTO_INCREMENT=3;

-- ----------------------------
-- Auto increment value for t_cms_col_from
-- ----------------------------
ALTER TABLE `t_cms_col_from` AUTO_INCREMENT=7;

-- ----------------------------
-- Auto increment value for t_cms_col_spec
-- ----------------------------
ALTER TABLE `t_cms_col_spec` AUTO_INCREMENT=1;

-- ----------------------------
-- Auto increment value for t_cms_col_subscribe
-- ----------------------------
ALTER TABLE `t_cms_col_subscribe` AUTO_INCREMENT=1;

-- ----------------------------
-- Auto increment value for t_cms_column
-- ----------------------------
ALTER TABLE `t_cms_column` AUTO_INCREMENT=126;

-- ----------------------------
-- Auto increment value for t_cms_msg_draft
-- ----------------------------
ALTER TABLE `t_cms_msg_draft` AUTO_INCREMENT=2;

-- ----------------------------
-- Auto increment value for t_cms_msg_list
-- ----------------------------
ALTER TABLE `t_cms_msg_list` AUTO_INCREMENT=1017881;

-- ----------------------------
-- Auto increment value for t_cms_sign
-- ----------------------------
ALTER TABLE `t_cms_sign` AUTO_INCREMENT=1;

-- ----------------------------
-- Auto increment value for t_cms_task_job
-- ----------------------------
ALTER TABLE `t_cms_task_job` AUTO_INCREMENT=1;

-- ----------------------------
-- Auto increment value for t_cms_template
-- ----------------------------
ALTER TABLE `t_cms_template` AUTO_INCREMENT=1;

-- ----------------------------
-- Auto increment value for t_cms_user_stock
-- ----------------------------
ALTER TABLE `t_cms_user_stock` AUTO_INCREMENT=1;

-- ----------------------------
-- Auto increment value for t_mom_task_list
-- ----------------------------
ALTER TABLE `t_mom_task_list` AUTO_INCREMENT=1;
