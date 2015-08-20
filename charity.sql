/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50540
Source Host           : localhost:3306
Source Database       : charity

Target Server Type    : MYSQL
Target Server Version : 50540
File Encoding         : 65001

Date: 2015-08-20 21:19:55
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `event_info`
-- ----------------------------
DROP TABLE IF EXISTS `event_info`;
CREATE TABLE `event_info` (
  `id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `member_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `attend_date` datetime DEFAULT NULL,
  `donate` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of event_info
-- ----------------------------

-- ----------------------------
-- Table structure for `membership`
-- ----------------------------
DROP TABLE IF EXISTS `membership`;
CREATE TABLE `membership` (
  `id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `sex` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `phone` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cellphone` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `card_id` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `note` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_member` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `company` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `modiry_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of membership
-- ----------------------------
INSERT INTO `membership` VALUES ('402880874f48dab6014f48e172070001', '张勇', '田', null, '', '', 'zhang@gmail.com', '004', '', '', '', '', '2015-08-20 21:05:16');
INSERT INTO `membership` VALUES ('402880874f4aa72c014f4ab665ce0005', '加三', '男', null, '', '', '', '005', '', '', '', '', '2015-08-20 21:06:24');
INSERT INTO `membership` VALUES ('402881874f1b97ac014f1bab89600001', '姓名', '性别', '0171-11-08', '电话', '手机', '邮箱', '006', '备注', '会员', '住址', '单位', '2015-08-20 21:06:24');
INSERT INTO `membership` VALUES ('402880874f48dab6014f48e1e0670002', '李白', '男', null, '', '', '', '1234', '', '', '', '', '2015-08-20 21:06:24');
INSERT INTO `membership` VALUES ('402880874f4aa72c014f4aae0fae0000', '李简', '女', null, '47876666', '', '', '007', '', '', '', '', '2015-08-20 21:06:24');
INSERT INTO `membership` VALUES ('402880874f4aa72c014f4ab1e1a70001', '张繁', '女', null, '', '', '', '001', '', '是', '', '', '2015-08-20 21:06:24');
INSERT INTO `membership` VALUES ('402880874f4aa72c014f4ab36ccd0002', '王名', '男', null, '', '', '', '002', '', '否', '', '', '2015-08-20 21:06:24');
INSERT INTO `membership` VALUES ('402880874f4aa72c014f4ab3e9410003', '加一', '女', null, '', '', '', '003', '', '', '', '', '2015-08-20 21:06:24');
INSERT INTO `membership` VALUES ('402880874f4aa72c014f4ab51b070004', '加二', '男', null, '', '', '', '008', '', '', '', '', '2015-08-20 21:06:39');
INSERT INTO `membership` VALUES ('402880874f4aa72c014f4ab8dbd10006', '加油', '女', null, '', '', '', '009', '', '', '', '', '2015-08-20 21:06:42');
INSERT INTO `membership` VALUES ('402880874f4aa72c014f4ab94a830007', '随便', '女', null, '', '', '', '010', '', '', '', '', '2015-08-20 21:06:45');
INSERT INTO `membership` VALUES ('402880874f4aa72c014f4abc0e850008', '简体', '女', null, '', '', '', '011', '', '', '', '', '2015-08-20 21:06:47');
INSERT INTO `membership` VALUES ('402880874f4aa72c014f4abc70c40009', '简介', '男', null, '', '', '', '012', '', '', '', '', '2015-08-20 21:06:52');
INSERT INTO `membership` VALUES ('402880874f4acc1c014f4acf27c00000', '单名', '女', null, '', '', '', '', '', '', '', '', '2015-08-20 21:12:14');
