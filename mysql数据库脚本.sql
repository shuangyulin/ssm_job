-- phpMyAdmin SQL Dump
-- version 3.0.1.1
-- http://www.phpmyadmin.net
--
-- 服务器版本: 5.1.29
-- PHP 版本: 5.2.6

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

-- --------------------------------------------------------

-- ----------------------------
-- Table structure for `admin`
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `username` varchar(20) NOT NULL DEFAULT '',
  `password` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_admin
-- ----------------------------
INSERT INTO `admin` VALUES ('a', 'a'); 

CREATE TABLE IF NOT EXISTS `t_userInfo` (
  `user_name` varchar(30)  NOT NULL COMMENT 'user_name',
  `password` varchar(30)  NOT NULL COMMENT '登录密码',
  `name` varchar(20)  NOT NULL COMMENT '姓名',
  `gender` varchar(4)  NOT NULL COMMENT '性别',
  `birthDate` varchar(20)  NULL COMMENT '出生日期',
  `userPhoto` varchar(60)  NOT NULL COMMENT '学生照片',
  `xl` varchar(20)  NOT NULL COMMENT '学历',
  `telephone` varchar(20)  NOT NULL COMMENT '联系电话',
  `email` varchar(50)  NOT NULL COMMENT '邮箱',
  `address` varchar(80)  NULL COMMENT '家庭地址',
  `jianliFile` varchar(60)  NOT NULL COMMENT '简历文件',
  `smrzzl` varchar(60)  NOT NULL COMMENT '实名认证资料',
  `shzt` varchar(20)  NOT NULL COMMENT '审核状态',
  `regTime` varchar(20)  NULL COMMENT '注册时间',
  PRIMARY KEY (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `t_company` (
  `companyUserName` varchar(30)  NOT NULL COMMENT 'companyUserName',
  `password` varchar(20)  NOT NULL COMMENT '登录密码',
  `qyjb` varchar(20)  NOT NULL COMMENT '信用级别',
  `companyName` varchar(20)  NOT NULL COMMENT '企业名称',
  `gszch` varchar(20)  NOT NULL COMMENT '工商注册号',
  `yyzz` varchar(60)  NOT NULL COMMENT '营业执照',
  `gsxz` varchar(20)  NOT NULL COMMENT '公司性质',
  `gsgm` varchar(20)  NOT NULL COMMENT '公司规模',
  `gghy` varchar(20)  NOT NULL COMMENT '公司行业',
  `lxr` varchar(20)  NOT NULL COMMENT '联系人',
  `lxdh` varchar(20)  NOT NULL COMMENT '联系电话',
  `companyDesc` varchar(8000)  NOT NULL COMMENT '公司介绍',
  `address` varchar(80)  NOT NULL COMMENT '公司地址',
  `shzt` varchar(20)  NOT NULL COMMENT '审核状态',
  PRIMARY KEY (`companyUserName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `t_jobType` (
  `jobTypeId` int(11) NOT NULL AUTO_INCREMENT COMMENT '职位类型id',
  `jobTypeName` varchar(20)  NOT NULL COMMENT '职位类别名称',
  `jobTypeDesc` varchar(800)  NOT NULL COMMENT '职位类别描述',
  PRIMARY KEY (`jobTypeId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_job` (
  `jobId` int(11) NOT NULL AUTO_INCREMENT COMMENT '职位id',
  `jobTypeObj` int(11) NOT NULL COMMENT '职位类别',
  `jobName` varchar(40)  NOT NULL COMMENT '职位名称',
  `jobDesc` varchar(8000)  NOT NULL COMMENT '职位描述',
  `salary` varchar(50)  NOT NULL COMMENT '工作薪酬',
  `zprs` int(11) NOT NULL COMMENT '招聘人数',
  `xlyq` varchar(20)  NOT NULL COMMENT '学历要求',
  `yxqx` varchar(30)  NOT NULL COMMENT '有效期限',
  `gzqy` varchar(20)  NOT NULL COMMENT '工作区域',
  `gzdz` varchar(80)  NOT NULL COMMENT '工作地址',
  `viewNum` int(11) NOT NULL COMMENT '浏览次数',
  `companyObj` varchar(30)  NOT NULL COMMENT '发布企业',
  `addTime` varchar(20)  NULL COMMENT '发布时间',
  PRIMARY KEY (`jobId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_delivery` (
  `deliveryId` int(11) NOT NULL AUTO_INCREMENT COMMENT '投递id',
  `jobObj` int(11) NOT NULL COMMENT '应聘职位',
  `userObj` varchar(30)  NOT NULL COMMENT '应聘人',
  `deliveryTime` varchar(20)  NULL COMMENT '投递时间',
  `handleTime` varchar(20)  NULL COMMENT '处理时间',
  `clzt` varchar(20)  NOT NULL COMMENT '处理状态',
  `tzxx` varchar(800)  NOT NULL COMMENT '通知信息',
  `gzpj` varchar(500)  NOT NULL COMMENT '工作评价',
  PRIMARY KEY (`deliveryId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_jobRecord` (
  `recordId` int(11) NOT NULL AUTO_INCREMENT COMMENT '记录id',
  `title` varchar(60)  NOT NULL COMMENT '标题',
  `content` varchar(8000)  NOT NULL COMMENT '内容',
  `userObj` varchar(30)  NOT NULL COMMENT '记录人',
  `recordDate` varchar(20)  NULL COMMENT '记录时间',
  PRIMARY KEY (`recordId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_leaveword` (
  `leaveWordId` int(11) NOT NULL AUTO_INCREMENT COMMENT '留言id',
  `leaveTitle` varchar(80)  NOT NULL COMMENT '留言标题',
  `leaveContent` varchar(2000)  NOT NULL COMMENT '留言内容',
  `userObj` varchar(30)  NOT NULL COMMENT '留言人',
  `leaveTime` varchar(20)  NULL COMMENT '留言时间',
  `replyContent` varchar(1000)  NULL COMMENT '管理回复',
  `replyTime` varchar(20)  NULL COMMENT '回复时间',
  PRIMARY KEY (`leaveWordId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_notice` (
  `noticeId` int(11) NOT NULL AUTO_INCREMENT COMMENT '公告id',
  `title` varchar(80)  NOT NULL COMMENT '标题',
  `content` varchar(5000)  NOT NULL COMMENT '公告内容',
  `publishDate` varchar(20)  NULL COMMENT '发布时间',
  PRIMARY KEY (`noticeId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_webLink` (
  `linkId` int(11) NOT NULL AUTO_INCREMENT COMMENT '记录id',
  `webName` varchar(50)  NOT NULL COMMENT '网站名称',
  `webLogo` varchar(60)  NOT NULL COMMENT '网站Logo',
  `webAddress` varchar(80)  NOT NULL COMMENT '网站地址',
  PRIMARY KEY (`linkId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

ALTER TABLE t_job ADD CONSTRAINT FOREIGN KEY (jobTypeObj) REFERENCES t_jobType(jobTypeId);
ALTER TABLE t_job ADD CONSTRAINT FOREIGN KEY (companyObj) REFERENCES t_company(companyUserName);
ALTER TABLE t_delivery ADD CONSTRAINT FOREIGN KEY (jobObj) REFERENCES t_job(jobId);
ALTER TABLE t_delivery ADD CONSTRAINT FOREIGN KEY (userObj) REFERENCES t_userInfo(user_name);
ALTER TABLE t_jobRecord ADD CONSTRAINT FOREIGN KEY (userObj) REFERENCES t_userInfo(user_name);
ALTER TABLE t_leaveword ADD CONSTRAINT FOREIGN KEY (userObj) REFERENCES t_userInfo(user_name);


