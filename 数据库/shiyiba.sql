/*
Navicat MySQL Data Transfer

Source Server         : KONG
Source Server Version : 50505
Source Host           : localhost:3306
Source Database       : shiyiba

Target Server Type    : MYSQL
Target Server Version : 50505
File Encoding         : 65001

Date: 2019-10-11 18:06:22
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for `activity`
-- ----------------------------
DROP TABLE IF EXISTS `activity`;
CREATE TABLE `activity` (
  `activity_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '商铺活动id',
  `activity_name` varchar(255) NOT NULL COMMENT '商铺活动名称',
  `activity_price` double NOT NULL COMMENT '商铺活动条件',
  `activity_jieshao` varchar(255) DEFAULT NULL COMMENT '商铺活动条件介绍',
  `activity_shop_id` int(11) NOT NULL COMMENT '商铺id(外键)',
  PRIMARY KEY (`activity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of activity
-- ----------------------------

-- ----------------------------
-- Table structure for `address`
-- ----------------------------
DROP TABLE IF EXISTS `address`;
CREATE TABLE `address` (
  `address_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '地址编号',
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `user_address` varchar(255) NOT NULL COMMENT '用户收获地址',
  `address_name` varchar(255) NOT NULL COMMENT '收货人姓名',
  `address_phone` varchar(255) NOT NULL COMMENT '联系电话',
  `address_xiangxi` varchar(255) NOT NULL COMMENT '详细地址',
  `address_default` int(11) NOT NULL DEFAULT 0 COMMENT '默认地址【0为不默认1为默认】',
  PRIMARY KEY (`address_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of address
-- ----------------------------

-- ----------------------------
-- Table structure for `admin_record`
-- ----------------------------
DROP TABLE IF EXISTS `admin_record`;
CREATE TABLE `admin_record` (
  `record_id` int(11) NOT NULL COMMENT '后台操作记录id',
  `record_name` varchar(255) NOT NULL COMMENT '操作记录人的名称',
  `record_mokuai` varchar(255) NOT NULL COMMENT '操作的模块',
  `record_xingwei` varchar(255) NOT NULL COMMENT '操作的行为',
  `record_time` varchar(255) NOT NULL COMMENT '操作的时间',
  `record_miaoshu` varchar(255) NOT NULL COMMENT '操作的描述',
  `shop_id` int(11) NOT NULL COMMENT '商铺id',
  `record_user` varchar(255) NOT NULL COMMENT '操作用户',
  PRIMARY KEY (`record_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of admin_record
-- ----------------------------

-- ----------------------------
-- Table structure for `cart`
-- ----------------------------
DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart` (
  `cart_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '购物车编号',
  `user_id` int(11) NOT NULL COMMENT '用户编号',
  `cart_type` int(11) NOT NULL COMMENT '购物车种类【0为租赁，1为购买】',
  `cart_type2` int(11) NOT NULL COMMENT '购物类型【0为商品列表，1为DIY列表】',
  `commodity_id` int(11) NOT NULL COMMENT '购物商品编号',
  `cart_size` varchar(255) NOT NULL COMMENT '购物商品大小',
  `cart_count` int(11) NOT NULL COMMENT '商品数量',
  `cart_color` varchar(255) NOT NULL COMMENT '购买商品颜色',
  `cart_price` double NOT NULL COMMENT '购买商品金额',
  `cart_jieshao` varchar(255) DEFAULT NULL COMMENT '购买商品介绍',
  `cart_zhuangshi` varchar(255) DEFAULT '' COMMENT '购买商品装饰',
  `cart_zujin` double DEFAULT NULL COMMENT '购买商品租金',
  `cart_yajin` double(255,0) DEFAULT NULL COMMENT '购买商品押金',
  `cart_zuli_day` varchar(255) DEFAULT '' COMMENT '租赁购物时间',
  `cart_tupian` varchar(255) NOT NULL COMMENT '购物商品图片',
  `cart_name` varchar(255) NOT NULL COMMENT '购买商品名称',
  `cart_zu_time` varchar(255) DEFAULT NULL COMMENT '租赁的开始时间',
  `cart_zu_overtime` varchar(255) DEFAULT NULL COMMENT '租赁结束时间',
  PRIMARY KEY (`cart_id`,`commodity_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cart
-- ----------------------------
INSERT INTO cart VALUES ('1', '1', '1', '0', '15', '量身定制', '1', '红色', '4999', null, '', null, null, '', 'http://shop.nuotisi.com:81/lifu/R17L2T179/order/2.jpg,', '云纹流苏鱼尾中式礼服', null, null);
INSERT INTO cart VALUES ('2', '1', '0', '0', '15', '量身定制', '1', '红色', '4999', null, '', '1000', '3000', '1', 'http://shop.nuotisi.com:81/lifu/R17L2T179/order/2.jpg,', '云纹流苏鱼尾中式礼服', '2018-12-12', '2018-12-13');
INSERT INTO cart VALUES ('3', '2', '1', '0', '2', '均码', '1', '米色', '6999', null, '', null, null, '', 'http://shop.nuotisi.com:81/hunsha/R18H2T210/order/2.jpg,', 'V领披肩鱼尾气质礼服', null, null);
INSERT INTO cart VALUES ('4', '2', '0', '0', '2', '均码', '1', '米色', '6999', null, '', '1400', '5000', '1', 'http://shop.nuotisi.com:81/hunsha/R18H2T210/order/2.jpg,', 'V领披肩鱼尾气质礼服', '2018-12-12', '2018-12-13');

-- ----------------------------
-- Table structure for `commodity`
-- ----------------------------
DROP TABLE IF EXISTS `commodity`;
CREATE TABLE `commodity` (
  `commodity_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '商品编号',
  `commodity_name` varchar(255) NOT NULL COMMENT '商品名称',
  `commodity_genre` int(11) NOT NULL COMMENT '商品种类【0为女1为男】',
  `commodity_type` int(11) NOT NULL COMMENT '商品类型',
  `commodity_brand_id` int(11) DEFAULT NULL COMMENT '商品品牌',
  `commodity_money` double NOT NULL COMMENT '商品金额',
  `commodity_rent` double DEFAULT NULL COMMENT '租金金额',
  `commodity_cash_pledge` double DEFAULT NULL COMMENT '押金金额',
  `commodity_picture_address` varchar(255) NOT NULL COMMENT '商品图片地址',
  `commoity_video` varchar(255) DEFAULT NULL,
  `commoity_amount` int(11) NOT NULL COMMENT '商品库存数量',
  `commoity_shop` int(11) NOT NULL COMMENT '商家店铺',
  `commodity_category_id` int(11) NOT NULL COMMENT '商品的品类',
  `commodity_islease` int(11) DEFAULT NULL COMMENT '租赁状态 【0为不可租赁 1为可租赁】',
  PRIMARY KEY (`commodity_id`),
  KEY `index_name` (`commodity_name`)
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of commodity
-- ----------------------------
INSERT INTO commodity VALUES ('1', '透纱气质蕾丝婚纱', '0', '2', '1', '6999', '1400', '5000', 'http://shop.nuotisi.com:81/hunsha/R18H5T202/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/hunsha/R18H5T202/sPmp4/test.mp4,', '1', '1', '2', null);
INSERT INTO commodity VALUES ('2', 'V领披肩鱼尾气质礼服', '0', '2', '1', '6999', '1400', '5000', 'http://shop.nuotisi.com:81/hunsha/R18H2T210/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/hunsha/R18H2T210/sPmp4/test.mp4,', '1', '1', '2', null);
INSERT INTO commodity VALUES ('3', 'V领披肩鱼尾优雅婚纱', '0', '2', '1', '5999', '1200', '4000', 'http://shop.nuotisi.com:81/hunsha/R18H1T201/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/hunsha/R18H1T201/sPmp4/test.mp4,', '1', '1', '2', null);
INSERT INTO commodity VALUES ('4', '抹胸浪漫荷叶边鱼尾婚纱', '0', '2', '1', '6999', '1400', '5000', 'http://shop.nuotisi.com:81/hunsha/R18H1T226/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/hunsha/R18H1T226/sPmp4/test.mp4,', '1', '1', '2', null);
INSERT INTO commodity VALUES ('5', '一字肩浪漫蕾丝婚纱', '0', '2', '1', '5999', '1200', '4000', 'http://shop.nuotisi.com:81/hunsha/R18H3T196/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/hunsha/R18H3T196/sPmp4/test.mp4,', '1', '1', '2', null);
INSERT INTO commodity VALUES ('6', 'V领浪漫荷叶袖婚纱', '0', '2', '1', '3999', '800', '3000', 'http://shop.nuotisi.com:81/hunsha/R18H3T223/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/hunsha/R18H3T223/sPmp4/test.mp4,', '1', '1', '2', null);
INSERT INTO commodity VALUES ('7', '一字领披肩鱼尾婚纱', '0', '2', '1', '5999', '1200', '4000', 'http://shop.nuotisi.com:81/hunsha/R18H3T222/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/hunsha/R18H3T222/sPmp4/test.mp4,', '1', '1', '2', null);
INSERT INTO commodity VALUES ('8', 'V领露背两件式婚纱', '0', '2', '1', '3999', '800', '3000', 'http://shop.nuotisi.com:81/hunsha/R18H2T242/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/hunsha/R18H2T242/sPmp4/test.mp4,', '1', '1', '2', null);
INSERT INTO commodity VALUES ('9', '森系浪漫荷叶边礼服', '0', '1', '2', '1999', '400', '1500', 'http://shop.nuotisi.com:81/lvpai/R1806B14/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/lvpai/R1806B14/sPmp4/R1806B14.mp4,', '1', '1', '1', null);
INSERT INTO commodity VALUES ('10', '时尚牛仔拼接小礼服', '0', '1', '2', '1399', '300', '1000', 'http://shop.nuotisi.com:81/lvpai/R1806A54/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/lvpai/R1806A54/sPmp4/R1806A54.mp4,', '1', '1', '1', null);
INSERT INTO commodity VALUES ('11', '浪漫荷叶边雪纺礼服', '0', '1', '2', '1399', '300', '1000', 'http://shop.nuotisi.com:81/lvpai/E5524/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/lvpai/E5524/sPmp4/E5524.mp4,', '1', '1', '1', null);
INSERT INTO commodity VALUES ('12', '简约一字肩小拖礼服', '0', '1', '2', '1399', '300', '1000', 'http://shop.nuotisi.com:81/lvpai/R1806A55/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/lvpai/R1806A55/sPmp4/R1806A55.mp4,', '1', '1', '1', null);
INSERT INTO commodity VALUES ('13', '浪漫灯笼袖白纱小礼服', '0', '1', '2', '1999', '400', '1500', 'http://shop.nuotisi.com:81/lvpai/R1806A59/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/lvpai/R1806A59/sPmp4/R1806A59.mp4,', '1', '1', '1', null);
INSERT INTO commodity VALUES ('14', '气质红色V领礼服', '0', '1', '2', '1399', '300', '1000', 'http://shop.nuotisi.com:81/lvpai/R1806A64/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/lvpai/R1806A64/sPmp4/R1806A64.mp4,', '1', '1', '1', null);
INSERT INTO commodity VALUES ('15', 'V领缎面蕾丝礼服', '0', '1', '2', '1999', '400', '1500', 'http://shop.nuotisi.com:81/lvpai/R1806A74/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/lvpai/R1806A74/sPmp4/R1806A74.mp4,', '1', '1', '1', null);
INSERT INTO commodity VALUES ('16', '深V吊带3D印花礼服', '0', '1', '2', '1999', '400', '1500', 'http://shop.nuotisi.com:81/lvpai/R1806A77/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/lvpai/R1806A77/sPmp4/R1806A77.mp4,', '1', '1', '1', null);
INSERT INTO commodity VALUES ('17', '迷人吊带抹胸礼服', '0', '1', '2', '1399', '1699', '1000', 'http://shop.nuotisi.com:81/lvpai/R1806D17/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/lvpai/R1806D17/sPmp4/R1806D17.mp4,', '1', '1', '1', null);
INSERT INTO commodity VALUES ('18', '浪漫交叉领褶皱礼服', '0', '1', '2', '1399', '300', '1000', 'http://shop.nuotisi.com:81/lvpai/R1806E07/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/lvpai/R1806E07/sPmp4/R1806E07.mp4,', '1', '1', '1', null);
INSERT INTO commodity VALUES ('19', '唯美蕾丝白纱礼服', '0', '1', '2', '1999', '400', '1500', 'http://shop.nuotisi.com:81/lvpai/R1806F11/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/lvpai/R1806F11/sPmp4/R1806F11.mp4,', '1', '1', '1', null);
INSERT INTO commodity VALUES ('20', '红色抹胸珠绣拖尾礼服', '0', '1', '2', '2399', '500', '1500', 'http://shop.nuotisi.com:81/lvpai/R1807A87/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/lvpai/R1807A87/sPmp4/R1807A87.mp4,', '1', '1', '1', null);
INSERT INTO commodity VALUES ('21', '神秘星空礼服裙', '0', '1', '2', '1999', '400', '1500', 'http://shop.nuotisi.com:81/lvpai/R1807F32/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/lvpai/R1807F32/sPmp4/R1807F32.mp4,', '1', '1', '1', null);
INSERT INTO commodity VALUES ('22', '气质斜肩礼服', '0', '1', '2', '1999', '400', '1000', 'http://shop.nuotisi.com:81/lvpai/R1807F16/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/lvpai/R1807F16/sPmp4/R1807F16.mp4,', '1', '1', '1', null);
INSERT INTO commodity VALUES ('23', '优雅抹胸小礼服', '0', '1', '2', '1399', '300', '1000', 'http://shop.nuotisi.com:81/lvpai/R1806E11/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/lvpai/R1806E11/sPmp4/R1806E11.mp4,', '1', '1', '1', null);
INSERT INTO commodity VALUES ('24', '优雅浪漫抹胸鱼尾拖尾礼服', '0', '1', '2', '2999', '600', '2000', 'http://shop.nuotisi.com:81/lvpai/E5632-1/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/lvpai/E5632-1/sPmp4/E5632-1.mp4,', '1', '1', '1', null);
INSERT INTO commodity VALUES ('25', '唯美吊带一字肩礼服', '0', '1', '2', '999', '200', '500', 'http://shop.nuotisi.com:81/lvpai/R1805A39/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/lvpai/R1805A39/sPmp4/R1805A39.mp4,', '1', '1', '1', null);
INSERT INTO commodity VALUES ('26', '唯美露背连衣裙', '0', '1', '2', '999', '200', '500', 'http://shop.nuotisi.com:81/lvpai/R1805A43/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/lvpai/R1805A43/sPmp4/R1805A43.mp4,', '1', '1', '1', null);
INSERT INTO commodity VALUES ('27', '森系深V拖尾礼服', '0', '1', '2', '1699', '300', '1000', 'http://shop.nuotisi.com:81/lvpai/R1805B07/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/lvpai/R1805B07/sPmp4/R1805B07.mp4,', '1', '1', '1', null);
INSERT INTO commodity VALUES ('28', '优雅浪漫蕾丝礼服', '0', '1', '2', '2399', '500', '1500', 'http://shop.nuotisi.com:81/lvpai/R1806B17/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/lvpai/R1806B17/sPmp4/R1806B17.mp4,', '1', '1', '1', null);
INSERT INTO commodity VALUES ('29', '森系单肩拖尾礼服', '0', '1', '2', '1699', '300', '1000', 'http://shop.nuotisi.com:81/lvpai/R1806D21/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/lvpai/R1806D21/sPmp4/R1806D21.mp4,', '1', '1', '1', null);
INSERT INTO commodity VALUES ('30', '俏皮撞色抹胸褶皱礼服', '0', '1', '2', '1399', '300', '1000', 'http://shop.nuotisi.com:81/lvpai/R1806F07/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/lvpai/R1806F07/sPmp4/R1806F07.mp4,', '1', '1', '1', null);
INSERT INTO commodity VALUES ('31', '俏皮抹胸白纱礼服', '0', '1', '2', '1399', '300', '1000', 'http://shop.nuotisi.com:81/lvpai/R1806G07/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/lvpai/R1806G07/sPmp4/R1806G07.mp4,', '1', '1', '1', null);
INSERT INTO commodity VALUES ('32', '不对称褶皱礼服', '0', '1', '2', '1699', '300', '1300', 'http://shop.nuotisi.com:81/lvpai/S5768-4/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/lvpai/S5768-4/sPmp4/S5768-4.mp4,', '1', '1', '1', null);
INSERT INTO commodity VALUES ('33', '森系仙气礼服', '0', '1', '2', '1999', '400', '1500', 'http://shop.nuotisi.com:81/lvpai/R1806D14/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/lvpai/R1806D14/sPmp4/R1806D14.mp4,', '1', '1', '1', null);
INSERT INTO commodity VALUES ('34', '性感深V吊带拖尾礼服', '0', '1', '2', '1399', '300', '1000', 'http://shop.nuotisi.com:81/lvpai/L18L2Q012/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/lvpai/L18L2Q012/sPmp4/R1806C24 L18L2Q012.mp4,', '1', '1', '1', null);
INSERT INTO commodity VALUES ('35', '修身显瘦蕾丝长裙', '0', '1', '2', '2999', '600', '2000', 'http://shop.nuotisi.com:81/lvpai/R1804B06/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/lvpai/R1804B06/sPmp4/R1804B06.mp4,', '1', '1', '1', null);
INSERT INTO commodity VALUES ('36', '性感吊带不规则连衣裙', '0', '1', '2', '1999', '400', '1500', 'http://shop.nuotisi.com:81/lvpai/R1808G11/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/lvpai/R1808G11/sPmp4/R1808G11.mp4,', '1', '1', '1', null);
INSERT INTO commodity VALUES ('37', '性感飘逸开叉礼服', '0', '1', '2', '1399', '300', '1000', 'http://shop.nuotisi.com:81/lvpai/E5809/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/lvpai/E5809/sPmp4/E5809.mp4,', '1', '1', '1', null);
INSERT INTO commodity VALUES ('38', '性感不对称礼服', '0', '1', '2', '1399', '300', '1000', 'http://shop.nuotisi.com:81/lvpai/R1806E09/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/lvpai/R1806E09/sPmp4/R1806E09.mp4,', '1', '1', '1', null);
INSERT INTO commodity VALUES ('39', '优雅浪漫荷叶边礼服', '0', '1', '2', '1399', '300', '1000', 'http://shop.nuotisi.com:81/lvpai/R1806A56/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/lvpai/R1806A56/sPmp4/R1806A56.mp4,', '1', '1', '1', null);
INSERT INTO commodity VALUES ('40', '抹胸吊带条纹礼服', '0', '1', '2', '1399', '300', '1000', 'http://shop.nuotisi.com:81/lvpai/R1806B12/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/lvpai/R1806B12/sPmp4/R1806B12.mp4,', '1', '1', '1', null);
INSERT INTO commodity VALUES ('41', '性感蝴蝶结一字肩礼服', '0', '1', '2', '1399', '300', '1000', 'http://shop.nuotisi.com:81/lvpai/R1808F24/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/lvpai/R1808F24/sPmp4/R1808F24.mp4,', '1', '1', '1', null);
INSERT INTO commodity VALUES ('42', '神秘性感吊带礼服', '0', '1', '2', '999', '200', '500', 'http://shop.nuotisi.com:81/lvpai/R1808F25/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/lvpai/R1808F25/sPmp4/R1808F25.mp4,', '1', '1', '1', null);
INSERT INTO commodity VALUES ('43', '森系唯美荷叶边礼服', '0', '1', '2', '1399', '300', '1000', 'http://shop.nuotisi.com:81/lvpai/R1807A85/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/lvpai/R1807A85/sPmp4/R1807A85.mp4,', '1', '1', '1', null);
INSERT INTO commodity VALUES ('44', '唯美抹胸撞色礼服', '0', '1', '2', '1399', '300', '1000', 'http://shop.nuotisi.com:81/lvpai/R1806D10/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/lvpai/R1806D10/sPmp4/R1806D10.mp4,', '1', '1', '1', null);
INSERT INTO commodity VALUES ('45', '浪漫典雅泡泡袖礼服', '0', '1', '2', '1999', '400', '1500', 'http://shop.nuotisi.com:81/lvpai/R1806C18/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/lvpai/R1806C18/sPmp4/R1806C18.mp4,', '1', '1', '1', null);
INSERT INTO commodity VALUES ('46', '不对称修身一字肩礼服', '0', '1', '2', '1999', '400', '1000', 'http://shop.nuotisi.com:81/lvpai/R1809A120/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/lvpai/R1809A120/sPmp4/R1809A120.mp4,', '1', '1', '1', null);
INSERT INTO commodity VALUES ('47', '优雅抹胸吊带礼服', '0', '1', '2', '1699', '300', '1000', 'http://shop.nuotisi.com:81/lvpai/R1807F14/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/lvpai/R1807F14/sPmp4/R1807F14.mp4,', '1', '1', '1', null);
INSERT INTO commodity VALUES ('48', '性感撞色一字肩礼服', '0', '1', '2', '1999', '400', '1500', 'http://shop.nuotisi.com:81/lvpai/R1808F21/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/lvpai/R1808F21/sPmp4/R1808F21.mp4,', '1', '1', '1', null);
INSERT INTO commodity VALUES ('49', '森系抹胸吊带礼服', '0', '1', '2', '1999', '400', '1500', 'http://shop.nuotisi.com:81/lvpai/R1806E12/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/lvpai/R1806E12/sPmp4/R1806E12.mp4,', '1', '1', '1', null);
INSERT INTO commodity VALUES ('50', '性感撞色鱼尾礼服', '0', '1', '2', '1999', '400', '1000', 'http://shop.nuotisi.com:81/lvpai/R1809D36/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/lvpai/R1809D36/sPmp4/R1809D36.mp4,', '1', '1', '1', null);
INSERT INTO commodity VALUES ('51', '手绘抹胸吊带礼服', '0', '1', '2', '1399', '300', '1000', 'http://shop.nuotisi.com:81/lvpai/R1809E23/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/lvpai/R1809E23/sPmp4/R1809E23.mp4,', '1', '1', '1', null);
INSERT INTO commodity VALUES ('52', '简约性感鱼尾拖尾礼服', '0', '1', '2', '1699', '300', '1300', 'http://shop.nuotisi.com:81/lvpai/R1810A126/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/lvpai/R1810A126/sPmp4/R1810A126.mp4,', '1', '1', '1', null);
INSERT INTO commodity VALUES ('53', '单肩不规则修身礼服', '0', '1', '2', '1699', '300', '1300', 'http://shop.nuotisi.com:81/lvpai/S5454-5/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/lvpai/S5454-5/sPmp4/S5454-5.mp4,', '1', '1', '1', null);
INSERT INTO commodity VALUES ('54', '优雅一字肩修身礼服', '0', '1', '2', '1399', '300', '1000', 'http://shop.nuotisi.com:81/lvpai/S5864-1/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/lvpai/S5864-1/sPmp4/S5864-1.mp4,', '1', '1', '1', null);
INSERT INTO commodity VALUES ('55', '性感浪漫荷叶边婚纱', '0', '1', '2', '2999', '600', '2000', 'http://shop.nuotisi.com:81/lvpai/R1806B13/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/lvpai/R1806B13/sPmp4/R1806B13.mp4,', '1', '1', '1', null);
INSERT INTO commodity VALUES ('56', '一字肩鱼尾婚纱', '0', '1', '2', '899', '200', '500', 'http://shop.nuotisi.com:81/lvpai/L18B2D006/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/lvpai/L18B2D006/sPmp4/R1806F10  L18B2D006.mp4,', '1', '1', '1', null);
INSERT INTO commodity VALUES ('57', '背心小V领婚纱', '0', '1', '2', '999', '200', '500', 'http://shop.nuotisi.com:81/lvpai/L18B2D019/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/lvpai/L18B2D019/sPmp4/L18B2D019.mp4,', '1', '1', '1', null);
INSERT INTO commodity VALUES ('58', '一字肩灯笼袖婚纱', '0', '1', '2', '1399', '300', '1000', 'http://shop.nuotisi.com:81/lvpai/L18H1T013/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/lvpai/L18H1T013/sPmp4/L18H1T013.mp4,', '1', '1', '1', null);
INSERT INTO commodity VALUES ('59', '抹胸荷叶边婚纱', '0', '1', '2', '1399', '300', '1000', 'http://shop.nuotisi.com:81/lvpai/L18H2T002/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/lvpai/L18H2T002/sPmp4/R1806D19 L18H2T002.mp4,', '1', '1', '1', null);
INSERT INTO commodity VALUES ('60', '背心领透纱礼服', '0', '1', '2', '1699', '400', '1000', 'http://shop.nuotisi.com:81/lvpai/L18H2T020/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/lvpai/L18H2T020/sPmp4/R1806A57  L18H2T020.mp4,', '1', '1', '1', null);
INSERT INTO commodity VALUES ('61', '深V灯笼袖唯美礼服', '0', '1', '2', '1999', '400', '1500', 'http://shop.nuotisi.com:81/lvpai/L18H5T023/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/lvpai/L18H5T023/sPmp4/R1806A45  L18H5T023.mp4,', '1', '1', '1', null);
INSERT INTO commodity VALUES ('62', '抹胸蕾丝婚纱', '0', '1', '2', '1399', '300', '1000', 'http://shop.nuotisi.com:81/lvpai/L18L2Q012/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/lvpai/L18L2Q012/sPmp4/R1806C24 L18L2Q012.mp4,', '1', '1', '1', null);
INSERT INTO commodity VALUES ('63', '唯美立体化V领礼服', '0', '1', '2', '1999', '400', '1500', 'http://shop.nuotisi.com:81/lvpai/L18L2T011/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/lvpai/L18L2T011/sPmp4/R1806C25  L18L2T011.mp4,', '1', '1', '1', null);
INSERT INTO commodity VALUES ('64', '深V小拖尾婚纱', '0', '1', '2', '1399', '300', '1000', 'http://shop.nuotisi.com:81/lvpai/L18L2T027/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/lvpai/L18L2T027/sPmp4/L18L2T027.mp4,', '1', '1', '1', null);
INSERT INTO commodity VALUES ('65', '优雅性感披肩礼服', '0', '4', '1', '3999', '800', '2500', 'http://shop.nuotisi.com:81/lifu/R17L2Q039/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/lifu/R17L2Q039/sPmp4/S2988R17L2Q039.mp4,', '1', '1', '4', null);
INSERT INTO commodity VALUES ('66', '复古优雅礼服', '0', '4', '1', '3999', '600', '2500', 'http://shop.nuotisi.com:81/lifu/R17L2Q012/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/lifu/R17L2Q012/sPmp4/R17L2Q012S2989.mp4,', '1', '1', '4', null);
INSERT INTO commodity VALUES ('67', '珠绣浪漫鱼尾礼服', '0', '4', '1', '5999', '1000', '4000', 'http://shop.nuotisi.com:81/lifu/R17L2Q036/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/lifu/R17L2Q036/sPmp4/R17L2Q036S6333.mp4,', '1', '1', '4', null);
INSERT INTO commodity VALUES ('68', '贵气优雅鱼尾裙', '0', '4', '1', '4999', '800', '3000', 'http://shop.nuotisi.com:81/lifu/R17L2Q134/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/lifu/R17L2Q134/sPmp4/R17L2Q134S5743-1.mp4,', '1', '1', '4', null);
INSERT INTO commodity VALUES ('69', '性感精致深V礼服', '0', '4', '1', '2999', '600', '2000', 'http://shop.nuotisi.com:81/lifu/R1807A96/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/lifu/R1807A96/sPmp4/R1807A96.mp4,', '1', '1', '4', null);
INSERT INTO commodity VALUES ('70', '金典大气立体花礼服', '0', '4', '1', '2999', '600', '2000', 'http://shop.nuotisi.com:81/lifu/R1808A03/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/lifu/R1808A03/sPmp4/R1808A03.mp4,', '1', '1', '4', null);
INSERT INTO commodity VALUES ('71', '优雅立体蕾丝一字肩礼服', '0', '4', '1', '2999', '600', '2000', 'http://shop.nuotisi.com:81/lifu/R1808A105/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/lifu/R1808A105/sPmp4/R1808A105.mp4,', '1', '1', '4', null);
INSERT INTO commodity VALUES ('72', '浪漫不规则一字肩礼服', '0', '4', '1', '2999', '600', '2000', 'http://shop.nuotisi.com:81/lifu/R1808A109/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/lifu/R1808A109/sPmp4/R1808A109.mp4,', '1', '1', '4', null);
INSERT INTO commodity VALUES ('73', '优雅显瘦一字肩蕾丝礼服', '0', '4', '1', '3999', '800', '3000', 'http://shop.nuotisi.com:81/lifu/S5881/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/lifu/S5881/sPmp4/S5881.mp4,', '1', '1', '4', null);
INSERT INTO commodity VALUES ('74', '优雅复古拖尾礼服', '0', '4', '1', '5999', '1200', '4000', 'http://shop.nuotisi.com:81/lifu/R1804A26/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/lifu/R1804A26/sPmp4/R1804A26.mp4,', '1', '1', '4', null);
INSERT INTO commodity VALUES ('75', '一字肩显瘦蕾丝礼服', '0', '4', '1', '5999', '1000', '3000', 'http://shop.nuotisi.com:81/lifu/E2257-2/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/lifu/E2257-2/sPmp4/E2257-2.mp4,', '1', '1', '4', null);
INSERT INTO commodity VALUES ('76', '性感一字肩鱼尾礼服', '0', '4', '1', '3999', '800', '3000', 'http://shop.nuotisi.com:81/lifu/R1807A91/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/lifu/R1807A91/sPmp4/R1807A91.mp4,', '1', '1', '4', null);
INSERT INTO commodity VALUES ('77', '性感削肩开叉礼服', '0', '4', '1', '2999', '600', '2000', 'http://shop.nuotisi.com:81/lifu/S5862-1/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/lifu/S5862-1/sPmp4/S5862-1.mp4,', '1', '1', '4', null);
INSERT INTO commodity VALUES ('78', '云纹流苏鱼尾中式礼服', '0', '4', '1', '3999', '800', '2500', 'http://shop.nuotisi.com:81/lifu/R17L2Q185/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/lifu/R17L2Q185/sPmp4/test.mp4,', '1', '1', '4', null);
INSERT INTO commodity VALUES ('79', '云纹流苏鱼尾中式礼服', '0', '4', '1', '4999', '1000', '3000', 'http://shop.nuotisi.com:81/lifu/R17L2T179/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/lifu/R17L2T179/sPmp4/test.mp4,', '1', '1', '4', null);
INSERT INTO commodity VALUES ('80', '金典大气秀和服', '0', '5', '1', '3999', '800', '3000', 'http://shop.nuotisi.com:81/jiayi/S5857/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/jiayi/S5857/sPmp4/2F200S5857.mp4,', '1', '1', '5', null);
INSERT INTO commodity VALUES ('81', '贵气大方秀和服', '0', '5', '1', '6999', '1400', '5000', 'http://shop.nuotisi.com:81/jiayi/R17X5D073/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/jiayi/R17X5D073/sPmp4/2F02R17X5D073.mp4,', '1', '1', '5', null);
INSERT INTO commodity VALUES ('82', '精致优雅龙凤褂', '0', '5', '1', '3999', '800', '3000', 'http://shop.nuotisi.com:81/jiayi/R17X5D072/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/jiayi/R17X5D072/sPmp4/2F03R17X5D072.mp4,', '1', '1', '5', null);
INSERT INTO commodity VALUES ('83', '金典复古秀和服', '0', '5', '1', '13999', '2800', '8000', 'http://shop.nuotisi.com:81/jiayi/R18H5Q233/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/jiayi/R18H5Q233/sPmp4/F5193-2 R18H5Q233.mp4,', '1', '1', '5', null);
INSERT INTO commodity VALUES ('84', '端庄贵气秀和服', '0', '5', '1', '15999', '3200', '9000', 'http://shop.nuotisi.com:81/jiayi/R1802A01/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/jiayi/R1802A01/sPmp4/R1802A01.mp4,', '1', '1', '5', null);
INSERT INTO commodity VALUES ('85', '典雅精致秀和服', '0', '5', '1', '2999', '600', '2000', 'http://shop.nuotisi.com:81/jiayi/R1803A06/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/jiayi/R1803A06/sPmp4/R1803A06.mp4,', '1', '1', '5', null);
INSERT INTO commodity VALUES ('86', '优雅贵气秀和服', '0', '5', '1', '18880', '3800', '12000', 'http://shop.nuotisi.com:81/jiayi/R18X5D182/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/jiayi/R18X5D182/sPmp4/S5904R18X5D182.mp4,', '1', '1', '5', null);
INSERT INTO commodity VALUES ('87', '金典端庄秀和服', '0', '5', '1', '6999', '1400', '5000', 'http://shop.nuotisi.com:81/jiayi/S5907/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/jiayi/S5907/sPmp4/S5907.mp4,', '1', '1', '5', null);
INSERT INTO commodity VALUES ('88', '典雅秀气秀和服', '0', '5', '1', '10999', '2000', '6000', 'http://shop.nuotisi.com:81/jiayi/R18X5Q234/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/jiayi/R18X5Q234/sPmp4/S5908R18X5Q234.mp4,', '1', '1', '5', null);
INSERT INTO commodity VALUES ('89', '端庄金典秀和服', '0', '5', '1', '3999', '800', '3000', 'http://shop.nuotisi.com:81/jiayi/R17X5Q671/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/jiayi/R17X5Q671/sPmp4/X0004R17X5Q671.mp4,', '1', '1', '5', null);
INSERT INTO commodity VALUES ('90', '精致贵气秀和服', '0', '5', '1', '9999', '2000', '6000', 'http://shop.nuotisi.com:81/jiayi/X5Q1201/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/jiayi/X5Q1201/sPmp4/X5Q1201.mp4,', '1', '1', '5', null);
INSERT INTO commodity VALUES ('91', '优雅高端秀和服', '0', '5', '1', '13999', '2800', '8000', 'http://shop.nuotisi.com:81/jiayi/R18X5Q181/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/jiayi/R18X5Q181/sPmp4/X5T1224R18X5Q181.mp4,', '1', '1', '5', null);
INSERT INTO commodity VALUES ('92', '隆重大气秀和服', '0', '5', '1', '18999', '3800', '12000', 'http://shop.nuotisi.com:81/jiayi/R18X5T183/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/jiayi/R18X5T183/sPmp4/2F04R18X5T183.mp4,', '1', '1', '5', null);
INSERT INTO commodity VALUES ('93', '典雅端庄秀和服', '0', '5', '1', '2999', '600', '2000', 'http://shop.nuotisi.com:81/jiayi/R1803A06/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/jiayi/R1803A06/sPmp4/R1803A06.mp4,', '1', '1', '5', null);
INSERT INTO commodity VALUES ('94', '端庄大气拖尾秀禾服', '0', '5', '1', '6999', '1400', '5000', 'http://shop.nuotisi.com:81/jiayi/S5907/lunbo/1.jpg,', 'http://shop.nuotisi.com:81/jiayi/S5907/sPmp4/S5907.mp4,', '1', '1', '5', null);

-- ----------------------------
-- Table structure for `commodity_brand`
-- ----------------------------
DROP TABLE IF EXISTS `commodity_brand`;
CREATE TABLE `commodity_brand` (
  `brand_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '品牌id',
  `brand_name` varchar(255) NOT NULL COMMENT '品牌名字',
  `brand_identification` int(11) DEFAULT NULL COMMENT '品牌标识符',
  `shop_id` int(11) NOT NULL COMMENT '商铺id',
  `brand_logo` varchar(255) DEFAULT NULL COMMENT '品牌logo',
  `brand_number` varchar(255) DEFAULT NULL COMMENT '品牌编号',
  `brand_status` int(11) DEFAULT NULL COMMENT '品牌状态【0为未启用 1为启用】',
  `brand_source` varchar(255) DEFAULT NULL COMMENT '品牌来源',
  `brand_style` varchar(255) DEFAULT NULL COMMENT '品牌风格',
  `brand_pinlei_id` int(11) DEFAULT NULL COMMENT '品牌品类（类型）外键',
  `brand_create_time` varchar(255) DEFAULT NULL COMMENT '品牌创建时间',
  `brand_create_username` varchar(255) DEFAULT NULL COMMENT '品牌创建人',
  `brand_update_time` varchar(255) DEFAULT NULL COMMENT '品牌修改时间',
  `brand_update_username` varchar(255) DEFAULT NULL COMMENT '品牌修改人',
  PRIMARY KEY (`brand_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of commodity_brand
-- ----------------------------
INSERT INTO commodity_brand VALUES ('1', '蔡美月', null, '1', null, null, null, null, null, null, null, null, null, null);
INSERT INTO commodity_brand VALUES ('2', '罗亚', null, '1', null, null, null, null, null, null, null, null, null, null);

-- ----------------------------
-- Table structure for `commodity_category`
-- ----------------------------
DROP TABLE IF EXISTS `commodity_category`;
CREATE TABLE `commodity_category` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '品类的id',
  `category_name` varchar(255) NOT NULL COMMENT '品类的名字',
  `shop_id` int(11) NOT NULL COMMENT '商铺id',
  `category_brand_id` int(11) NOT NULL COMMENT '品牌id（外键）',
  `category_create_time` varchar(255) NOT NULL COMMENT '品类创建时间',
  `commotidy_type_id` int(11) NOT NULL COMMENT '主类别id(外键)',
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of commodity_category
-- ----------------------------
INSERT INTO commodity_category VALUES ('2', '旅拍', '1', '1', '2019-01-14 15:17:09', '1');
INSERT INTO commodity_category VALUES ('3', '婚纱', '1', '1', '2019-01-14 15:18:19', '1');
INSERT INTO commodity_category VALUES ('4', '婚纱', '1', '2', '2019-01-14 15:20:45', '1');

-- ----------------------------
-- Table structure for `commodity_color`
-- ----------------------------
DROP TABLE IF EXISTS `commodity_color`;
CREATE TABLE `commodity_color` (
  `color_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '颜色id',
  `commodity_id` int(11) NOT NULL COMMENT '商品id',
  `color_name` varchar(255) NOT NULL COMMENT '颜色名称',
  `color_picture` varchar(255) DEFAULT NULL COMMENT '颜色对应的商品图片',
  PRIMARY KEY (`color_id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of commodity_color
-- ----------------------------
INSERT INTO commodity_color VALUES ('1', '1', '米色', null);
INSERT INTO commodity_color VALUES ('2', '4', '浅香槟', null);
INSERT INTO commodity_color VALUES ('3', '6', '香槟', null);
INSERT INTO commodity_color VALUES ('4', '8', '米白', null);
INSERT INTO commodity_color VALUES ('5', '10', '米色,牛仔蓝', null);
INSERT INTO commodity_color VALUES ('6', '12', '灰色', null);
INSERT INTO commodity_color VALUES ('7', '14', '红色', null);
INSERT INTO commodity_color VALUES ('8', '16', '彩色', null);
INSERT INTO commodity_color VALUES ('9', '17', '秋香绿,橙色', null);
INSERT INTO commodity_color VALUES ('10', '21', '黑色', null);
INSERT INTO commodity_color VALUES ('11', '22', '浅粉色', null);
INSERT INTO commodity_color VALUES ('12', '26', '黄色', null);
INSERT INTO commodity_color VALUES ('13', '29', '香槟色', null);
INSERT INTO commodity_color VALUES ('14', '32', '杏色', null);
INSERT INTO commodity_color VALUES ('15', '36', '祖母绿', null);
INSERT INTO commodity_color VALUES ('16', '40', '白色', null);
INSERT INTO commodity_color VALUES ('17', '41', '兰色', null);
INSERT INTO commodity_color VALUES ('18', '43', '天蓝色', null);
INSERT INTO commodity_color VALUES ('19', '44', '暗红色', null);
INSERT INTO commodity_color VALUES ('20', '45', '粉色', null);
INSERT INTO commodity_color VALUES ('21', '48', '紫色', null);
INSERT INTO commodity_color VALUES ('22', '49', '浅绿色', null);
INSERT INTO commodity_color VALUES ('23', '53', '枚红色', null);
INSERT INTO commodity_color VALUES ('24', '63', '花色', null);
INSERT INTO commodity_color VALUES ('25', '64', '酒红色', null);
INSERT INTO commodity_color VALUES ('26', '94', '正红色', null);

-- ----------------------------
-- Table structure for `commodity_size`
-- ----------------------------
DROP TABLE IF EXISTS `commodity_size`;
CREATE TABLE `commodity_size` (
  `size_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '商品大小id',
  `size_name` char(10) NOT NULL COMMENT '商品大小名称',
  `size_goumai_count` int(11) NOT NULL COMMENT '商品购买大小库存数量',
  `size_lease_count` int(11) DEFAULT NULL COMMENT '商品租赁大小库存数量',
  `commodity_id` int(11) NOT NULL COMMENT '商品id(外键)',
  PRIMARY KEY (`size_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of commodity_size
-- ----------------------------

-- ----------------------------
-- Table structure for `commodity_type`
-- ----------------------------
DROP TABLE IF EXISTS `commodity_type`;
CREATE TABLE `commodity_type` (
  `type_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '商品类型id',
  `type_name` varchar(255) NOT NULL COMMENT '商品类型名称',
  `type_fengmian` varchar(255) NOT NULL COMMENT '商品类型封面',
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of commodity_type
-- ----------------------------
INSERT INTO commodity_type VALUES ('1', '旅拍', '');
INSERT INTO commodity_type VALUES ('2', '婚纱', '');
INSERT INTO commodity_type VALUES ('3', 'DIY定制', '');
INSERT INTO commodity_type VALUES ('4', '礼服', 'xxx');
INSERT INTO commodity_type VALUES ('5', '嫁衣', 'xxx');

-- ----------------------------
-- Table structure for `cooperation_shop`
-- ----------------------------
DROP TABLE IF EXISTS `cooperation_shop`;
CREATE TABLE `cooperation_shop` (
  `per_shop_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '合作商编号',
  `shop_id` int(11) NOT NULL COMMENT '商家id',
  `per_shop_name` varchar(255) NOT NULL COMMENT '合作商店铺名字',
  `per_shop_adress` varchar(255) NOT NULL COMMENT '合作商地址',
  `per_shop_phone` varchar(255) NOT NULL COMMENT '合作商电话',
  `per_shop_user_name` varchar(255) NOT NULL COMMENT '合作商创办人',
  PRIMARY KEY (`per_shop_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cooperation_shop
-- ----------------------------

-- ----------------------------
-- Table structure for `cparameters`
-- ----------------------------
DROP TABLE IF EXISTS `cparameters`;
CREATE TABLE `cparameters` (
  `p_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '参数编号',
  `p_commodit_id` int(11) NOT NULL COMMENT '商品编号',
  `p_stylenumber` varchar(255) NOT NULL COMMENT '商品款号',
  `p_style` varchar(255) NOT NULL COMMENT '商品风格',
  `p_textyre` varchar(255) NOT NULL COMMENT '商品材质',
  `p_thickness` varchar(255) DEFAULT NULL COMMENT '商品厚薄',
  `p_size` varchar(255) DEFAULT NULL COMMENT '商品大小',
  `p_introduce` varchar(255) DEFAULT NULL COMMENT '商品介绍',
  `p_publicity_picture` varchar(255) NOT NULL COMMENT '商品宣传图',
  `p_detailsfigure` varchar(255) NOT NULL COMMENT '商品详情图',
  `p_color` int(11) NOT NULL COMMENT '商品颜色',
  `p_maintain` varchar(255) DEFAULT NULL COMMENT '商品保养方法',
  `p_season` varchar(255) DEFAULT NULL COMMENT '商品使用季节',
  `p_throng` varchar(255) DEFAULT NULL COMMENT '商品试用人群',
  `p_scene` varchar(255) DEFAULT NULL COMMENT '商品试用场景',
  `p_numberofplies` varchar(255) DEFAULT '' COMMENT '商品层数',
  `p_weight` varchar(255) DEFAULT NULL COMMENT '商品的重量',
  `p_length` varchar(255) DEFAULT '' COMMENT '商品的长度',
  `p_washing` varchar(255) DEFAULT NULL COMMENT '商品洗涤说明',
  `p_maidian` varchar(255) DEFAULT NULL COMMENT '商品买点',
  `p_gongyi` varchar(255) DEFAULT NULL COMMENT '商品工艺',
  `P_inspiration` varchar(255) DEFAULT NULL COMMENT '商品的设计灵感',
  `P_chengqun` varchar(255) DEFAULT NULL COMMENT '商品撑群',
  `p_order_tupian` varchar(255) DEFAULT '' COMMENT '商品订单图',
  `p_zidinyi` varchar(1000) DEFAULT '' COMMENT '自定义参数列表',
  PRIMARY KEY (`p_id`)
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cparameters
-- ----------------------------
INSERT INTO cparameters VALUES ('1', '1', 'R18H5T202', '米瑞士网、米蕾丝', '圆领包肩设计，精致的立体蕾丝颈饰，蕾丝珠绣设计，让婚纱立体感十足；高腰设计，A型大拖摆，尽显女王范，高贵典雅，美丽大方。', '适中', '均码', '婚礼、宴会、摄影', 'http://shop.nuotisi.com:81/hunsha/R18H5T202/FM/3.jpg,', 'http://shop.nuotisi.com:81/hunsha/R18H5T202/XQ/X1.jpg,http://shop.nuotisi.com:81/hunsha/R18H5T202/XQ/X2.jpg,', '1', '有', '9.0', '212.0', '5kg', '圆领包肩设计，精致的立体蕾丝颈饰，蕾丝珠绣，后背镂空设计。', '', '精美手工贴花，纯手工缝珠，精细车工缝制', '量身定制', '另附量身定制单', '都适用', '1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\n4.\n14.存放于阴凉干燥的地方。', '1.可手洗、干洗，不可机洗。\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\n3.不可漂白。\n13.可低温熨烫。', 'http://shop.nuotisi.com:81/hunsha/R18H5T202/order/2.jpg,', '{\"厚薄\":\"适中\",\"适用场景\":\"5kg\",\"层数\":\"圆领包肩设计，精致的立体蕾丝颈饰，蕾丝珠绣，后背镂空设计。\",\"适用人群\":\"212.0\",\"卖点\":\"另附量身定制单\",\"设计灵感\":\"1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\\n4.\\n14.存放于阴凉干燥的地方。\",\"特点\":\"婚礼、宴会、摄影\",\"重量\":\"\",\"尺寸\":\"均码\",\"长度\":\"精美手工贴花，纯手工缝珠，精细车工缝制\",\"洗涤方法\":\"量身定制\",\"保养\":\"有\",\"适用季节\":\"9.0\",\"工艺\":\"都适用\",\"撑群\":\"1.可手洗、干洗，不可机洗。\\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\\n3.不可漂白。\\n13.可低温熨烫。\"}');
INSERT INTO cparameters VALUES ('2', '2', 'R18H2T210', '素雅缎', '优雅性感的大V领，鱼尾设计展现迷人曲线，搭配气质披肩更加迷人。', '适中', '均码', '婚礼、宴会、摄影', 'http://shop.nuotisi.com:81/hunsha/R18H2T210/FM/3.jpg,', 'http://shop.nuotisi.com:81/hunsha/R18H2T210/XQ/X1.jpg,http://shop.nuotisi.com:81/hunsha/R18H2T210/XQ/X2.jpg,', '1', '无', '2.0', '212.0', '1.65kg', '迷人的鱼尾裙摆镂空加上蕾丝，大气的披肩排列精美蕾丝。', '', '纯手工缝珠，精美手工贴花，精细车工缝制', '量身定制', '另附量身定制单', '都适用', '1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\n4.\n34.存放于阴凉干燥的地方。', '1.可手洗、干洗，不可机洗。\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\n3.不可漂白。\n33.可低温熨烫。', 'http://shop.nuotisi.com:81/hunsha/R18H2T210/order/2.jpg,', '{\"厚薄\":\"适中\",\"适用场景\":\"1.65kg\",\"层数\":\"迷人的鱼尾裙摆镂空加上蕾丝，大气的披肩排列精美蕾丝。\",\"适用人群\":\"212.0\",\"卖点\":\"另附量身定制单\",\"设计灵感\":\"1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\\n4.\\n34.存放于阴凉干燥的地方。\",\"特点\":\"婚礼、宴会、摄影\",\"重量\":\"\",\"尺寸\":\"均码\",\"长度\":\"纯手工缝珠，精美手工贴花，精细车工缝制\",\"洗涤方法\":\"量身定制\",\"保养\":\"无\",\"适用季节\":\"2.0\",\"工艺\":\"都适用\",\"撑群\":\"1.可手洗、干洗，不可机洗。\\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\\n3.不可漂白。\\n33.可低温熨烫。\"}');
INSERT INTO cparameters VALUES ('3', '3', 'R18H1T201', '素雅缎', '迷人的抹胸鱼尾裙，加上蕾丝透纱披肩，更加性感优雅。', '适中', '均码', '婚礼、宴会、摄影', 'http://shop.nuotisi.com:81/hunsha/R18H1T201/FM/3.jpg,', 'http://shop.nuotisi.com:81/hunsha/R18H1T201/XQ/X1.jpg,http://shop.nuotisi.com:81/hunsha/R18H1T201/XQ/X2.jpg,', '1', '无', '2.0', '195.0', '1.5kg', '披肩自然流线型垂褶，排列点缀精美蕾丝。', '', '纯手工缝珠，精美手工贴花，精细车工缝制', '量身定制', '另附量身定制单', '都适用', '1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\n4.\n36.存放于阴凉干燥的地方。', '1.可手洗、干洗，不可机洗。\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\n3.不可漂白。\n35.可低温熨烫。', 'http://shop.nuotisi.com:81/hunsha/R18H1T201/order/2.jpg,', '{\"厚薄\":\"适中\",\"适用场景\":\"1.5kg\",\"层数\":\"披肩自然流线型垂褶，排列点缀精美蕾丝。\",\"适用人群\":\"195.0\",\"卖点\":\"另附量身定制单\",\"设计灵感\":\"1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\\n4.\\n36.存放于阴凉干燥的地方。\",\"特点\":\"婚礼、宴会、摄影\",\"重量\":\"\",\"尺寸\":\"均码\",\"长度\":\"纯手工缝珠，精美手工贴花，精细车工缝制\",\"洗涤方法\":\"量身定制\",\"保养\":\"无\",\"适用季节\":\"2.0\",\"工艺\":\"都适用\",\"撑群\":\"1.可手洗、干洗，不可机洗。\\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\\n3.不可漂白。\\n35.可低温熨烫。\"}');
INSERT INTO cparameters VALUES ('4', '4', 'R18H1T226', '蕾丝面料', '不规则荷叶边搭配浪漫的抹胸鱼尾，更加优雅浪漫，裙摆点缀精美的蕾丝、钉珠更加唯美。', '适中', '均码', '婚礼、宴会、摄影', 'http://shop.nuotisi.com:81/hunsha/R18H1T226/FM/3.jpg,', 'http://shop.nuotisi.com:81/hunsha/R18H1T226/XQ/X1.jpg,http://shop.nuotisi.com:81/hunsha/R18H1T226/XQ/X2.jpg,', '2', '无', '17.0', '186.0', '1.95kg', '不规则的荷裙摆边点缀蕾丝。', '', '纯手工缝珠，精美手工贴花，精细车工缝制', '量身定制', '另附量身定制单', '都适用', '1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\n4.\n38.存放于阴凉干燥的地方。', '1.可手洗、干洗，不可机洗。\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\n3.不可漂白。\n37.可低温熨烫。', 'http://shop.nuotisi.com:81/hunsha/R18H1T226/order/2.jpg,', '{\"厚薄\":\"适中\",\"适用场景\":\"1.95kg\",\"层数\":\"不规则的荷裙摆边点缀蕾丝。\",\"适用人群\":\"186.0\",\"卖点\":\"另附量身定制单\",\"设计灵感\":\"1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\\n4.\\n38.存放于阴凉干燥的地方。\",\"特点\":\"婚礼、宴会、摄影\",\"重量\":\"\",\"尺寸\":\"均码\",\"长度\":\"纯手工缝珠，精美手工贴花，精细车工缝制\",\"洗涤方法\":\"量身定制\",\"保养\":\"无\",\"适用季节\":\"17.0\",\"工艺\":\"都适用\",\"撑群\":\"1.可手洗、干洗，不可机洗。\\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\\n3.不可漂白。\\n37.可低温熨烫。\"}');
INSERT INTO cparameters VALUES ('5', '5', 'R18H3T196', '瑞士网、蕾丝面料', '唯美的一字肩连透纱，点缀精美蕾丝、钉珠，后背镂空设计，更加迷人。', '适中', '均码', '婚礼、宴会、摄影', 'http://shop.nuotisi.com:81/hunsha/R18H3T196/FM/3.jpg,', 'http://shop.nuotisi.com:81/hunsha/R18H3T196/XQ/X1.jpg,http://shop.nuotisi.com:81/hunsha/R18H3T196/XQ/X2.jpg,', '1', '有', '8.0', '230.0', '3.5kg', '一字肩与透纱拼接，点缀蕾丝。', '', '纯手工缝珠，精美手工贴花，精细车工缝制', '量身定制', '另附量身定制单', '都适用', '1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\n4.\n40.存放于阴凉干燥的地方。', '1.可手洗、干洗，不可机洗。\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\n3.不可漂白。\n39.可低温熨烫。', 'http://shop.nuotisi.com:81/hunsha/R18H3T196/order/2.jpg,', '{\"厚薄\":\"适中\",\"适用场景\":\"3.5kg\",\"层数\":\"一字肩与透纱拼接，点缀蕾丝。\",\"适用人群\":\"230.0\",\"卖点\":\"另附量身定制单\",\"设计灵感\":\"1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\\n4.\\n40.存放于阴凉干燥的地方。\",\"特点\":\"婚礼、宴会、摄影\",\"重量\":\"\",\"尺寸\":\"均码\",\"长度\":\"纯手工缝珠，精美手工贴花，精细车工缝制\",\"洗涤方法\":\"量身定制\",\"保养\":\"有\",\"适用季节\":\"8.0\",\"工艺\":\"都适用\",\"撑群\":\"1.可手洗、干洗，不可机洗。\\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\\n3.不可漂白。\\n39.可低温熨烫。\"}');
INSERT INTO cparameters VALUES ('6', '6', 'R18H3T223', '香槟软网', '浪漫的V领，加上飘逸的荷叶袖，上身点缀精美的蕾丝，更加唯美浪漫。', '适中', '均码', '婚礼、宴会、摄影', 'http://shop.nuotisi.com:81/hunsha/R18H3T223/FM/3.jpg,', 'http://shop.nuotisi.com:81/hunsha/R18H3T223/XQ/X1.jpg,http://shop.nuotisi.com:81/hunsha/R18H3T223/XQ/X2.jpg,', '3', '无', '4.0', '187.0', '0.55kg', '上身点缀精美蕾丝，不规则荷叶边设计。', '', '纯手工缝珠，精美手工贴花，精细车工缝制', '量身定制', '另附量身定制单', '都适用', '1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\n4.\n43.存放于阴凉干燥的地方。', '1.可手洗、干洗，不可机洗。\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\n3.不可漂白。\n42.可低温熨烫。', 'http://shop.nuotisi.com:81/hunsha/R18H3T223/order/2.jpg,', '{\"厚薄\":\"适中\",\"适用场景\":\"0.55kg\",\"层数\":\"上身点缀精美蕾丝，不规则荷叶边设计。\",\"适用人群\":\"187.0\",\"卖点\":\"另附量身定制单\",\"设计灵感\":\"1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\\n4.\\n43.存放于阴凉干燥的地方。\",\"特点\":\"婚礼、宴会、摄影\",\"重量\":\"\",\"尺寸\":\"均码\",\"长度\":\"纯手工缝珠，精美手工贴花，精细车工缝制\",\"洗涤方法\":\"量身定制\",\"保养\":\"无\",\"适用季节\":\"4.0\",\"工艺\":\"都适用\",\"撑群\":\"1.可手洗、干洗，不可机洗。\\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\\n3.不可漂白。\\n42.可低温熨烫。\"}');
INSERT INTO cparameters VALUES ('7', '7', 'R18H3T222', '瑞士网、素雅缎', '优雅的一字肩，精美的蕾丝花边包裹着身躯，搭配飘逸的披肩，更加优雅迷人。', '适中', '均码', '婚礼、宴会、摄影', 'http://shop.nuotisi.com:81/hunsha/R18H3T222/FM/3.jpg,', 'http://shop.nuotisi.com:81/hunsha/R18H3T222/XQ/X1.jpg,http://shop.nuotisi.com:81/hunsha/R18H3T222/XQ/X2.jpg,', '1', '无', '', '230.0', '', '蕾丝花边勾勒曲线，搭配飘逸的披肩。', '', '纯手工缝珠，精美手工贴花，精细车工缝制', '量身定制', '另附量身定制单', '都适用', '1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\n4.\n63.存放于阴凉干燥的地方。', '1.可手洗、干洗，不可机洗。\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\n3.不可漂白。\n62.可低温熨烫。', 'http://shop.nuotisi.com:81/hunsha/R18H3T222/order/2.jpg,', '{\"厚薄\":\"适中\",\"适用场景\":\"\",\"层数\":\"蕾丝花边勾勒曲线，搭配飘逸的披肩。\",\"适用人群\":\"230.0\",\"卖点\":\"另附量身定制单\",\"设计灵感\":\"1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\\n4.\\n63.存放于阴凉干燥的地方。\",\"特点\":\"婚礼、宴会、摄影\",\"重量\":\"\",\"尺寸\":\"均码\",\"长度\":\"纯手工缝珠，精美手工贴花，精细车工缝制\",\"洗涤方法\":\"量身定制\",\"保养\":\"无\",\"适用季节\":\"\",\"工艺\":\"都适用\",\"撑群\":\"1.可手洗、干洗，不可机洗。\\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\\n3.不可漂白。\\n62.可低温熨烫。\"}');
INSERT INTO cparameters VALUES ('8', '8', 'R18H2T242', '香槟瑞士网、蕾丝面料', '柔美贴肤的蕾丝与V领露背的结合，勾勒出优美线条。活动外裙增加整体造型感，让原本的修身里裙廓形更多变。整件婚纱极轻的分量使它非常适合外出旅拍。', '适中', '均码', '', 'http://shop.nuotisi.com:81/hunsha/R18H2T242/FM/3.jpg,', 'http://shop.nuotisi.com:81/hunsha/R18H2T242/XQ/X1.jpg,http://shop.nuotisi.com:81/hunsha/R18H2T242/XQ/X2.jpg,', '4', '无', '6.0', '195.0', '1.2kg', '蕾丝与薄纱结合，腰间抽褶木耳边点缀，连接薄纱裙摆。', '', '纯手工抓褶，精美手工贴花，精细车工缝制', '量身定制', '另附量身定制单', '都适用', '1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\n4.\n81.存放于阴凉干燥的地方。', '1.可手洗、干洗，不可机洗。\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\n3.不可漂白。\n80.可低温熨烫。', 'http://shop.nuotisi.com:81/hunsha/R18H2T242/order/2.jpg,', '{\"厚薄\":\"适中\",\"适用场景\":\"1.2kg\",\"层数\":\"蕾丝与薄纱结合，腰间抽褶木耳边点缀，连接薄纱裙摆。\",\"适用人群\":\"195.0\",\"卖点\":\"另附量身定制单\",\"设计灵感\":\"1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\\n4.\\n81.存放于阴凉干燥的地方。\",\"特点\":\"\",\"重量\":\"\",\"尺寸\":\"均码\",\"长度\":\"纯手工抓褶，精美手工贴花，精细车工缝制\",\"洗涤方法\":\"量身定制\",\"保养\":\"无\",\"适用季节\":\"6.0\",\"工艺\":\"都适用\",\"撑群\":\"1.可手洗、干洗，不可机洗。\\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\\n3.不可漂白。\\n80.可低温熨烫。\"}');
INSERT INTO cparameters VALUES ('9', '9', 'R1806B14', '荷叶边、蝴蝶结、贴花', '米软网、6555米蕾丝、T1616米蕾丝', '适中', '均码', '无', 'http://shop.nuotisi.com:81/lvpai/R1806B14/FM/3.jpg,', 'http://shop.nuotisi.com:81/lvpai/R1806B14/XQ/X1.jpg,http://shop.nuotisi.com:81/lvpai/R1806B14/XQ/X2.jpg,', '1', '1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\n4.\n5.存放于阴凉干燥的地方。', '四季通用', '都适用', '摄影', '5.0', '432.0', '147.0', '1.可手洗、干洗，不可机洗。\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\n3.不可漂白。\n4.可低温熨烫。', null, null, null, null, 'http://shop.nuotisi.com:81/lvpai/R1806B14/order/2.jpg,', '{\"厚薄\":\"适中\",\"重量\":\"432.0\",\"适用场景\":\"摄影\",\"尺寸\":\"均码\",\"层数\":\"5.0\",\"长度\":\"147.0\",\"洗涤方法\":\"1.可手洗、干洗，不可机洗。\\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\\n3.不可漂白。\\n4.可低温熨烫。\",\"保养\":\"1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\\n4.\\n5.存放于阴凉干燥的地方。\",\"适用人群\":\"都适用\",\"适用季节\":\"四季通用\"}');
INSERT INTO cparameters VALUES ('10', '10', 'R1806A54', '拼接、蝴蝶结、纱', '牛仔、米美国网纱，压煞雪纺', '适中', '均码', '无', 'http://shop.nuotisi.com:81/lvpai/R1806A54/FM/3.jpg,', 'http://shop.nuotisi.com:81/lvpai/R1806A54/XQ/X1.jpg,http://shop.nuotisi.com:81/lvpai/R1806A54/XQ/X2.jpg,', '5', '1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\n4.\n6.存放于阴凉干燥的地方。', '四季通用', '都适用', '摄影', '2.0', '400.0', '152.0', '1.可手洗、干洗，不可机洗。\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\n3.不可漂白。\n5.可低温熨烫。', null, null, null, null, 'http://shop.nuotisi.com:81/lvpai/R1806A54/order/2.jpg,', '{\"厚薄\":\"适中\",\"重量\":\"400.0\",\"适用场景\":\"摄影\",\"尺寸\":\"均码\",\"层数\":\"2.0\",\"长度\":\"152.0\",\"洗涤方法\":\"1.可手洗、干洗，不可机洗。\\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\\n3.不可漂白。\\n5.可低温熨烫。\",\"保养\":\"1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\\n4.\\n6.存放于阴凉干燥的地方。\",\"适用人群\":\"都适用\",\"适用季节\":\"四季通用\"}');
INSERT INTO cparameters VALUES ('11', '11', 'E5524', '荷叶边、褶皱、不规则', '米软网、米仿真丝雪纺', '适中', '均码', '无', 'http://shop.nuotisi.com:81/lvpai/E5524/FM/3.jpg,', 'http://shop.nuotisi.com:81/lvpai/E5524/XQ/X1.jpg,http://shop.nuotisi.com:81/lvpai/E5524/XQ/X2.jpg,', '1', '1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\n4.\n7.存放于阴凉干燥的地方。', '四季通用', '都适用', '摄影', '4.0', '147.0', '802.0', '1.可手洗、干洗，不可机洗。\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\n3.不可漂白。\n6.可低温熨烫。', null, null, null, null, 'http://shop.nuotisi.com:81/lvpai/E5524/order/2.jpg,', '{\"厚薄\":\"适中\",\"重量\":\"147.0\",\"适用场景\":\"摄影\",\"尺寸\":\"均码\",\"层数\":\"4.0\",\"长度\":\"802.0\",\"洗涤方法\":\"1.可手洗、干洗，不可机洗。\\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\\n3.不可漂白。\\n6.可低温熨烫。\",\"保养\":\"1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\\n4.\\n7.存放于阴凉干燥的地方。\",\"适用人群\":\"都适用\",\"适用季节\":\"四季通用\"}');
INSERT INTO cparameters VALUES ('12', '12', 'R1806A55', '一字肩、前短后长', '灰色厚缎', '适中', '均码', '无', 'http://shop.nuotisi.com:81/lvpai/R1806A55/FM/3.jpg,', 'http://shop.nuotisi.com:81/lvpai/R1806A55/XQ/X1.jpg,http://shop.nuotisi.com:81/lvpai/R1806A55/XQ/X2.jpg,', '6', '1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\n4.\n9.存放于阴凉干燥的地方。', '四季通用', '都适用', '摄影', '1.0', '1363.0', '110.0', '1.可手洗、干洗，不可机洗。\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\n3.不可漂白。\n8.可低温熨烫。', null, null, null, null, 'http://shop.nuotisi.com:81/lvpai/R1806A55/order/2.jpg,', '{\"厚薄\":\"适中\",\"重量\":\"1363.0\",\"适用场景\":\"摄影\",\"尺寸\":\"均码\",\"层数\":\"1.0\",\"长度\":\"110.0\",\"洗涤方法\":\"1.可手洗、干洗，不可机洗。\\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\\n3.不可漂白。\\n8.可低温熨烫。\",\"保养\":\"1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\\n4.\\n9.存放于阴凉干燥的地方。\",\"适用人群\":\"都适用\",\"适用季节\":\"四季通用\"}');
INSERT INTO cparameters VALUES ('13', '13', 'R1806A59', '灯笼袖、白纱、蝴蝶结', '网纱', '适中', '均码', '无', 'http://shop.nuotisi.com:81/lvpai/R1806A59/FM/3.jpg,', 'http://shop.nuotisi.com:81/lvpai/R1806A59/XQ/X1.jpg,http://shop.nuotisi.com:81/lvpai/R1806A59/XQ/X2.jpg,', '1', '1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\n4.\n10.存放于阴凉干燥的地方。', '四季通用', '都适用', '摄影', '3.0', '491.0', '150.0', '1.可手洗、干洗，不可机洗。\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\n3.不可漂白。\n9.可低温熨烫。', null, null, null, null, 'http://shop.nuotisi.com:81/lvpai/R1806A59/order/2.jpg,', '{\"厚薄\":\"适中\",\"重量\":\"491.0\",\"适用场景\":\"摄影\",\"尺寸\":\"均码\",\"层数\":\"3.0\",\"长度\":\"150.0\",\"洗涤方法\":\"1.可手洗、干洗，不可机洗。\\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\\n3.不可漂白。\\n9.可低温熨烫。\",\"保养\":\"1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\\n4.\\n10.存放于阴凉干燥的地方。\",\"适用人群\":\"都适用\",\"适用季节\":\"四季通用\"}');
INSERT INTO cparameters VALUES ('14', '14', 'R1806A64', '深V、露背', '暗红395缎、浅香槟软网', '适中', '均码', '无', 'http://shop.nuotisi.com:81/lvpai/R1806A64/FM/3.jpg,', 'http://shop.nuotisi.com:81/lvpai/R1806A64/XQ/X1.jpg,http://shop.nuotisi.com:81/lvpai/R1806A64/XQ/X2.jpg,http://shop.nuotisi.com:81/lvpai/R1806A64/XQ/X3.jpg,', '7', '1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\n4.\n11.存放于阴凉干燥的地方。', '四季通用', '都适用', '婚礼、宴会、摄影', '2.0', '1268.0', '147.0', '1.可手洗、干洗，不可机洗。\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\n3.不可漂白。\n10.可低温熨烫。', null, null, null, null, 'http://shop.nuotisi.com:81/lvpai/R1806A64/order/2.jpg,', '{\"厚薄\":\"适中\",\"重量\":\"1268.0\",\"适用场景\":\"婚礼、宴会、摄影\",\"尺寸\":\"均码\",\"层数\":\"2.0\",\"长度\":\"147.0\",\"洗涤方法\":\"1.可手洗、干洗，不可机洗。\\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\\n3.不可漂白。\\n10.可低温熨烫。\",\"保养\":\"1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\\n4.\\n11.存放于阴凉干燥的地方。\",\"适用人群\":\"都适用\",\"适用季节\":\"四季通用\"}');
INSERT INTO cparameters VALUES ('15', '15', 'R1806A74', 'V领、蕾丝、腰带', '缎面', '适中', '均码', '无', 'http://shop.nuotisi.com:81/lvpai/R1806A74/FM/3.jpg,', 'http://shop.nuotisi.com:81/lvpai/R1806A74/XQ/X1.jpg,http://shop.nuotisi.com:81/lvpai/R1806A74/XQ/X2.jpg,', '1', '1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\n4.\n12.存放于阴凉干燥的地方。', '四季通用', '都适用', '摄影', '2.0', '1033.0', '147.0', '1.可手洗、干洗，不可机洗。\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\n3.不可漂白。\n11.可低温熨烫。', null, null, null, null, 'http://shop.nuotisi.com:81/lvpai/R1806A74/order/2.jpg,', '{\"厚薄\":\"适中\",\"重量\":\"1033.0\",\"适用场景\":\"摄影\",\"尺寸\":\"均码\",\"层数\":\"2.0\",\"长度\":\"147.0\",\"洗涤方法\":\"1.可手洗、干洗，不可机洗。\\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\\n3.不可漂白。\\n11.可低温熨烫。\",\"保养\":\"1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\\n4.\\n12.存放于阴凉干燥的地方。\",\"适用人群\":\"都适用\",\"适用季节\":\"四季通用\"}');
INSERT INTO cparameters VALUES ('16', '16', 'R1806A77', '吊带深V、前短后长、3D印花', '米美国软网、印花雪纺纱', '适中', '均码', '无', 'http://shop.nuotisi.com:81/lvpai/R1806A77/FM/3.jpg,', 'http://shop.nuotisi.com:81/lvpai/R1806A77/XQ/X1.jpg,http://shop.nuotisi.com:81/lvpai/R1806A77/XQ/X2.jpg,', '8', '1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\n4.\n13.存放于阴凉干燥的地方。', '四季通用', '都适用', '摄影', '3.0', '410.0', '147.0', '1.可手洗、干洗，不可机洗。\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\n3.不可漂白。\n12.可低温熨烫。', null, null, null, null, 'http://shop.nuotisi.com:81/lvpai/R1806A77/order/2.jpg,', '{\"厚薄\":\"适中\",\"重量\":\"410.0\",\"适用场景\":\"摄影\",\"尺寸\":\"均码\",\"层数\":\"3.0\",\"长度\":\"147.0\",\"洗涤方法\":\"1.可手洗、干洗，不可机洗。\\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\\n3.不可漂白。\\n12.可低温熨烫。\",\"保养\":\"1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\\n4.\\n13.存放于阴凉干燥的地方。\",\"适用人群\":\"都适用\",\"适用季节\":\"四季通用\"}');
INSERT INTO cparameters VALUES ('17', '17', 'R1806D17', '丝绒、纱、蕾丝', '网纱 丝绒', '适中', '均码', '无', 'http://shop.nuotisi.com:81/lvpai/R1806D17/FM/3.jpg,', 'http://shop.nuotisi.com:81/lvpai/R1806D17/XQ/X1.jpg,http://shop.nuotisi.com:81/lvpai/R1806D17/XQ/X2.jpg,', '9', '1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\n4.\n16.存放于阴凉干燥的地方。', '四季通用', '都适用', '摄影', '3.0', '526.0', '147.0', '1.可手洗、干洗，不可机洗。\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\n3.不可漂白。\n15.可低温熨烫。', null, null, null, null, 'http://shop.nuotisi.com:81/lvpai/R1806D17/order/2.jpg,', '{\"厚薄\":\"适中\",\"重量\":\"526.0\",\"适用场景\":\"摄影\",\"尺寸\":\"均码\",\"层数\":\"3.0\",\"长度\":\"147.0\",\"洗涤方法\":\"1.可手洗、干洗，不可机洗。\\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\\n3.不可漂白。\\n15.可低温熨烫。\",\"保养\":\"1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\\n4.\\n16.存放于阴凉干燥的地方。\",\"适用人群\":\"都适用\",\"适用季节\":\"四季通用\"}');
INSERT INTO cparameters VALUES ('18', '18', 'R1806E07', '交叉领、褶皱', '网纱 蕾丝 ', '适中', '均码', '无', 'http://shop.nuotisi.com:81/lvpai/R1806E07/FM/3.jpg,', 'http://shop.nuotisi.com:81/lvpai/R1806E07/XQ/X1.jpg,http://shop.nuotisi.com:81/lvpai/R1806E07/XQ/X2.jpg,', '1', '1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\n4.\n17.存放于阴凉干燥的地方。', '四季通用', '都适用', '婚礼、宴会、摄影', '2.0', '686.0', '147.0', '1.可手洗、干洗，不可机洗。\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\n3.不可漂白。\n16.可低温熨烫。', null, null, null, null, 'http://shop.nuotisi.com:81/lvpai/R1806E07/order/2.jpg,', '{\"厚薄\":\"适中\",\"重量\":\"686.0\",\"适用场景\":\"婚礼、宴会、摄影\",\"尺寸\":\"均码\",\"层数\":\"2.0\",\"长度\":\"147.0\",\"洗涤方法\":\"1.可手洗、干洗，不可机洗。\\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\\n3.不可漂白。\\n16.可低温熨烫。\",\"保养\":\"1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\\n4.\\n17.存放于阴凉干燥的地方。\",\"适用人群\":\"都适用\",\"适用季节\":\"四季通用\"}');
INSERT INTO cparameters VALUES ('19', '19', 'R1806F11', '纱、蕾丝', '加强米软网、米瑞士网、米里布，蕾丝花朵', '适中', '均码', '无', 'http://shop.nuotisi.com:81/lvpai/R1806F11/FM/3.jpg,', 'http://shop.nuotisi.com:81/lvpai/R1806F11/XQ/X1.jpg,http://shop.nuotisi.com:81/lvpai/R1806F11/XQ/X2.jpg,', '1', '1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\n4.\n18.存放于阴凉干燥的地方。', '四季通用', '都适用', '摄影', '4.0', '530.0', '147.0', '1.可手洗、干洗，不可机洗。\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\n3.不可漂白。\n17.可低温熨烫。', null, null, null, null, 'http://shop.nuotisi.com:81/lvpai/R1806F11/order/2.jpg,', '{\"厚薄\":\"适中\",\"重量\":\"530.0\",\"适用场景\":\"摄影\",\"尺寸\":\"均码\",\"层数\":\"4.0\",\"长度\":\"147.0\",\"洗涤方法\":\"1.可手洗、干洗，不可机洗。\\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\\n3.不可漂白。\\n17.可低温熨烫。\",\"保养\":\"1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\\n4.\\n18.存放于阴凉干燥的地方。\",\"适用人群\":\"都适用\",\"适用季节\":\"四季通用\"}');
INSERT INTO cparameters VALUES ('20', '20', 'R1807A87', '蕾丝、珠绣、纱', '暗红软网、暗红条纹纱、大红细纱、大红硬缎、大红里布', '适中', '均码', '无', 'http://shop.nuotisi.com:81/lvpai/R1807A87/FM/3.jpg,', 'http://shop.nuotisi.com:81/lvpai/R1807A87/XQ/X1.jpg,http://shop.nuotisi.com:81/lvpai/R1807A87/XQ/X2.jpg,', '7', '1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\n4.\n19.存放于阴凉干燥的地方。', '四季通用', '都适用', '摄影', '6.0', '1403.0', '152.0', '1.可手洗、干洗，不可机洗。\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\n3.不可漂白。\n18.可低温熨烫。', null, null, null, null, 'http://shop.nuotisi.com:81/lvpai/R1807A87/order/2.jpg,', '{\"厚薄\":\"适中\",\"重量\":\"1403.0\",\"适用场景\":\"摄影\",\"尺寸\":\"均码\",\"层数\":\"6.0\",\"长度\":\"152.0\",\"洗涤方法\":\"1.可手洗、干洗，不可机洗。\\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\\n3.不可漂白。\\n18.可低温熨烫。\",\"保养\":\"1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\\n4.\\n19.存放于阴凉干燥的地方。\",\"适用人群\":\"都适用\",\"适用季节\":\"四季通用\"}');
INSERT INTO cparameters VALUES ('21', '21', 'R1807F32', '手绘、纱、星空、建筑', '黑色瑞士网、黑色里布', '适中', '均码', '无', 'http://shop.nuotisi.com:81/lvpai/R1807F32/FM/3.jpg,', 'http://shop.nuotisi.com:81/lvpai/R1807F32/XQ/X1.jpg,http://shop.nuotisi.com:81/lvpai/R1807F32/XQ/X2.jpg,', '10', '1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\n4.\n22.存放于阴凉干燥的地方。', '四季通用', '都适用', '婚礼、宴会、摄影', '4.0', '800.0', '148.0', '1.可手洗、干洗，不可机洗。\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\n3.不可漂白。\n21.可低温熨烫。', null, null, null, null, 'http://shop.nuotisi.com:81/lvpai/R1807F32/order/2.jpg,', '{\"厚薄\":\"适中\",\"重量\":\"800.0\",\"适用场景\":\"婚礼、宴会、摄影\",\"尺寸\":\"均码\",\"层数\":\"4.0\",\"长度\":\"148.0\",\"洗涤方法\":\"1.可手洗、干洗，不可机洗。\\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\\n3.不可漂白。\\n21.可低温熨烫。\",\"保养\":\"1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\\n4.\\n22.存放于阴凉干燥的地方。\",\"适用人群\":\"都适用\",\"适用季节\":\"四季通用\"}');
INSERT INTO cparameters VALUES ('22', '22', 'R1807F16', '斜肩、不规则、蕾丝', '网纱 蕾丝 ', '适中', '均码', '无', 'http://shop.nuotisi.com:81/lvpai/R1807F16/FM/3.jpg,', 'http://shop.nuotisi.com:81/lvpai/R1807F16/XQ/X1.jpg,http://shop.nuotisi.com:81/lvpai/R1807F16/XQ/X2.jpg,', '11', '1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\n4.\n23.存放于阴凉干燥的地方。', '四季通用', '都适用', '婚礼、宴会、摄影', '5.0', '1100.0', '150.0', '1.可手洗、干洗，不可机洗。\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\n3.不可漂白。\n22.可低温熨烫。', null, null, null, null, 'http://shop.nuotisi.com:81/lvpai/R1807F16/order/2.jpg,', '{\"厚薄\":\"适中\",\"重量\":\"1100.0\",\"适用场景\":\"婚礼、宴会、摄影\",\"尺寸\":\"均码\",\"层数\":\"5.0\",\"长度\":\"150.0\",\"洗涤方法\":\"1.可手洗、干洗，不可机洗。\\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\\n3.不可漂白。\\n22.可低温熨烫。\",\"保养\":\"1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\\n4.\\n23.存放于阴凉干燥的地方。\",\"适用人群\":\"都适用\",\"适用季节\":\"四季通用\"}');
INSERT INTO cparameters VALUES ('23', '23', 'R1806E11', '蝴蝶结、拼接、纱', '网纱 蕾丝 里布', '适中', '均码', '无', 'http://shop.nuotisi.com:81/lvpai/R1806E11/FM/3.jpg,', 'http://shop.nuotisi.com:81/lvpai/R1806E11/XQ/X1.jpg,http://shop.nuotisi.com:81/lvpai/R1806E11/XQ/X2.jpg,', '1', '1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\n4.\n24.存放于阴凉干燥的地方。', '四季通用', '都适用', '摄影', '4.0', '580.0', '150.0', '1.可手洗、干洗，不可机洗。\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\n3.不可漂白。\n23.可低温熨烫。', null, null, null, null, 'http://shop.nuotisi.com:81/lvpai/R1806E11/order/2.jpg,', '{\"厚薄\":\"适中\",\"重量\":\"580.0\",\"适用场景\":\"摄影\",\"尺寸\":\"均码\",\"层数\":\"4.0\",\"长度\":\"150.0\",\"洗涤方法\":\"1.可手洗、干洗，不可机洗。\\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\\n3.不可漂白。\\n23.可低温熨烫。\",\"保养\":\"1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\\n4.\\n24.存放于阴凉干燥的地方。\",\"适用人群\":\"都适用\",\"适用季节\":\"四季通用\"}');
INSERT INTO cparameters VALUES ('24', '24', 'E5632-1', '钉珠、蕾丝', '蕾丝 缎里', '适中', '均码', '无', 'http://shop.nuotisi.com:81/lvpai/E5632-1/FM/3.jpg,', 'http://shop.nuotisi.com:81/lvpai/E5632-1/XQ/X1.jpg,http://shop.nuotisi.com:81/lvpai/E5632-1/XQ/X2.jpg,', '1', '1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\n4.\n25.存放于阴凉干燥的地方。', '四季通用', '都适用', '摄影', '2.0', '640.0', '152.0', '1.可手洗、干洗，不可机洗。\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\n3.不可漂白。\n24.可低温熨烫。', null, null, null, null, 'http://shop.nuotisi.com:81/lvpai/E5632-1/order/2.jpg,', '{\"厚薄\":\"适中\",\"重量\":\"640.0\",\"适用场景\":\"摄影\",\"尺寸\":\"均码\",\"层数\":\"2.0\",\"长度\":\"152.0\",\"洗涤方法\":\"1.可手洗、干洗，不可机洗。\\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\\n3.不可漂白。\\n24.可低温熨烫。\",\"保养\":\"1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\\n4.\\n25.存放于阴凉干燥的地方。\",\"适用人群\":\"都适用\",\"适用季节\":\"四季通用\"}');
INSERT INTO cparameters VALUES ('25', '25', 'R1805A39', '荷叶边、一字肩、纱', '红色网纱', '适中', '均码', '无', 'http://shop.nuotisi.com:81/lvpai/R1805A39/FM/3.jpg,', 'http://shop.nuotisi.com:81/lvpai/R1805A39/XQ/X1.jpg,http://shop.nuotisi.com:81/lvpai/R1805A39/XQ/X2.jpg,', '7', '1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\n4.\n26.存放于阴凉干燥的地方。', '四季通用', '都适用', '婚礼、宴会、摄影', '3.0', '245.0', '150.0', '1.可手洗、干洗，不可机洗。\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\n3.不可漂白。\n25.可低温熨烫。', null, null, null, null, 'http://shop.nuotisi.com:81/lvpai/R1805A39/order/2.jpg,', '{\"厚薄\":\"适中\",\"重量\":\"245.0\",\"适用场景\":\"婚礼、宴会、摄影\",\"尺寸\":\"均码\",\"层数\":\"3.0\",\"长度\":\"150.0\",\"洗涤方法\":\"1.可手洗、干洗，不可机洗。\\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\\n3.不可漂白。\\n25.可低温熨烫。\",\"保养\":\"1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\\n4.\\n26.存放于阴凉干燥的地方。\",\"适用人群\":\"都适用\",\"适用季节\":\"四季通用\"}');
INSERT INTO cparameters VALUES ('26', '26', 'R1805A43', '不规则、露背', '花雪纺', '适中', '均码', '无', 'http://shop.nuotisi.com:81/lvpai/R1805A43/FM/3.jpg,', 'http://shop.nuotisi.com:81/lvpai/R1805A43/XQ/X1.jpg,http://shop.nuotisi.com:81/lvpai/R1805A43/XQ/X2.jpg,', '12', '1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\n4.\n27.存放于阴凉干燥的地方。', '四季通用', '都适用', '摄影', '2.0', '276.0', '150.0', '1.可手洗、干洗，不可机洗。\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\n3.不可漂白。\n26.可低温熨烫。', null, null, null, null, 'http://shop.nuotisi.com:81/lvpai/R1805A43/order/2.jpg,', '{\"厚薄\":\"适中\",\"重量\":\"276.0\",\"适用场景\":\"摄影\",\"尺寸\":\"均码\",\"层数\":\"2.0\",\"长度\":\"150.0\",\"洗涤方法\":\"1.可手洗、干洗，不可机洗。\\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\\n3.不可漂白。\\n26.可低温熨烫。\",\"保养\":\"1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\\n4.\\n27.存放于阴凉干燥的地方。\",\"适用人群\":\"都适用\",\"适用季节\":\"四季通用\"}');
INSERT INTO cparameters VALUES ('27', '27', 'R1805B07', '贴花、蝴蝶结、蕾丝', '黄色网纱', '适中', '均码', '无', 'http://shop.nuotisi.com:81/lvpai/R1805B07/FM/3.jpg,', 'http://shop.nuotisi.com:81/lvpai/R1805B07/XQ/X1.jpg,http://shop.nuotisi.com:81/lvpai/R1805B07/XQ/X2.jpg,', '12', '1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\n4.\n28.存放于阴凉干燥的地方。', '四季通用', '都适用', '摄影', '3.5', '275.0', '150.0', '1.可手洗、干洗，不可机洗。\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\n3.不可漂白。\n27.可低温熨烫。', null, null, null, null, 'http://shop.nuotisi.com:81/lvpai/R1805B07/order/2.jpg,', '{\"厚薄\":\"适中\",\"重量\":\"275.0\",\"适用场景\":\"摄影\",\"尺寸\":\"均码\",\"层数\":\"3.5\",\"长度\":\"150.0\",\"洗涤方法\":\"1.可手洗、干洗，不可机洗。\\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\\n3.不可漂白。\\n27.可低温熨烫。\",\"保养\":\"1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\\n4.\\n28.存放于阴凉干燥的地方。\",\"适用人群\":\"都适用\",\"适用季节\":\"四季通用\"}');
INSERT INTO cparameters VALUES ('28', '28', 'R1806B17', '腰带、蕾丝', '蕾丝', '适中', '均码', '无', 'http://shop.nuotisi.com:81/lvpai/R1806B17/FM/3.jpg,', 'http://shop.nuotisi.com:81/lvpai/R1806B17/XQ/X1.jpg,http://shop.nuotisi.com:81/lvpai/R1806B17/XQ/X2.jpg,', '1', '1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\n4.\n29.存放于阴凉干燥的地方。', '四季通用', '都适用', '婚礼、宴会、摄影', '2.0', '370.0', '152.0', '1.可手洗、干洗，不可机洗。\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\n3.不可漂白。\n28.可低温熨烫。', null, null, null, null, 'http://shop.nuotisi.com:81/lvpai/R1806B17/order/2.jpg,', '{\"厚薄\":\"适中\",\"重量\":\"370.0\",\"适用场景\":\"婚礼、宴会、摄影\",\"尺寸\":\"均码\",\"层数\":\"2.0\",\"长度\":\"152.0\",\"洗涤方法\":\"1.可手洗、干洗，不可机洗。\\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\\n3.不可漂白。\\n28.可低温熨烫。\",\"保养\":\"1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\\n4.\\n29.存放于阴凉干燥的地方。\",\"适用人群\":\"都适用\",\"适用季节\":\"四季通用\"}');
INSERT INTO cparameters VALUES ('29', '29', 'R1806D21', '贴花、褶皱、不对称', '香槟网纱', '适中', '均码', '无', 'http://shop.nuotisi.com:81/lvpai/R1806D21/FM/3.jpg,', 'http://shop.nuotisi.com:81/lvpai/R1806D21/XQ/X1.jpg,http://shop.nuotisi.com:81/lvpai/R1806D21/XQ/X2.jpg,', '13', '1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\n4.\n30.存放于阴凉干燥的地方。', '四季通用', '都适用', '摄影', '4.0', '360.0', '152.0', '1.可手洗、干洗，不可机洗。\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\n3.不可漂白。\n29.可低温熨烫。', null, null, null, null, 'http://shop.nuotisi.com:81/lvpai/R1806D21/order/2.jpg,', '{\"厚薄\":\"适中\",\"重量\":\"360.0\",\"适用场景\":\"摄影\",\"尺寸\":\"均码\",\"层数\":\"4.0\",\"长度\":\"152.0\",\"洗涤方法\":\"1.可手洗、干洗，不可机洗。\\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\\n3.不可漂白。\\n29.可低温熨烫。\",\"保养\":\"1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\\n4.\\n30.存放于阴凉干燥的地方。\",\"适用人群\":\"都适用\",\"适用季节\":\"四季通用\"}');
INSERT INTO cparameters VALUES ('30', '30', 'R1806F07', '不对称', '网纱', '适中', '均码', '无', 'http://shop.nuotisi.com:81/lvpai/R1806F07/FM/3.jpg,', 'http://shop.nuotisi.com:81/lvpai/R1806F07/XQ/X1.jpg,http://shop.nuotisi.com:81/lvpai/R1806F07/XQ/X2.jpg,', '10', '1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\n4.\n31.存放于阴凉干燥的地方。', '四季通用', '都适用', '摄影', '3.5', '350.0', '150.0', '1.可手洗、干洗，不可机洗。\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\n3.不可漂白。\n30.可低温熨烫。', null, null, null, null, 'http://shop.nuotisi.com:81/lvpai/R1806F07/order/2.jpg,', '{\"厚薄\":\"适中\",\"重量\":\"350.0\",\"适用场景\":\"摄影\",\"尺寸\":\"均码\",\"层数\":\"3.5\",\"长度\":\"150.0\",\"洗涤方法\":\"1.可手洗、干洗，不可机洗。\\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\\n3.不可漂白。\\n30.可低温熨烫。\",\"保养\":\"1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\\n4.\\n31.存放于阴凉干燥的地方。\",\"适用人群\":\"都适用\",\"适用季节\":\"四季通用\"}');
INSERT INTO cparameters VALUES ('31', '31', 'R1806G07', '蝴蝶结、贴花', '米色网纱', '适中', '均码', '无', 'http://shop.nuotisi.com:81/lvpai/R1806G07/FM/3.jpg,', 'http://shop.nuotisi.com:81/lvpai/R1806G07/XQ/X1.jpg,http://shop.nuotisi.com:81/lvpai/R1806G07/XQ/X2.jpg,', '1', '1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\n4.\n32.存放于阴凉干燥的地方。', '四季通用', '都适用', '婚礼、宴会、摄影', '5.0', '420.0', '150.0', '1.可手洗、干洗，不可机洗。\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\n3.不可漂白。\n31.可低温熨烫。', null, null, null, null, 'http://shop.nuotisi.com:81/lvpai/R1806G07/order/2.jpg,', '{\"厚薄\":\"适中\",\"重量\":\"420.0\",\"适用场景\":\"婚礼、宴会、摄影\",\"尺寸\":\"均码\",\"层数\":\"5.0\",\"长度\":\"150.0\",\"洗涤方法\":\"1.可手洗、干洗，不可机洗。\\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\\n3.不可漂白。\\n31.可低温熨烫。\",\"保养\":\"1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\\n4.\\n32.存放于阴凉干燥的地方。\",\"适用人群\":\"都适用\",\"适用季节\":\"四季通用\"}');
INSERT INTO cparameters VALUES ('32', '32', 'S5768-4', '褶皱、贴花', '缎面', '适中', '均码', '无', 'http://shop.nuotisi.com:81/lvpai/S5768-4/FM/3.jpg,', 'http://shop.nuotisi.com:81/lvpai/S5768-4/XQ/X1.jpg,http://shop.nuotisi.com:81/lvpai/S5768-4/XQ/X2.jpg,', '14', '1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\n4.\n33.存放于阴凉干燥的地方。', '四季通用', '都适用', '婚礼、宴会、摄影', '2.0', '340.0', '147.0', '1.可手洗、干洗，不可机洗。\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\n3.不可漂白。\n32.可低温熨烫。', null, null, null, null, 'http://shop.nuotisi.com:81/lvpai/S5768-4/order/2.jpg,', '{\"厚薄\":\"适中\",\"重量\":\"340.0\",\"适用场景\":\"婚礼、宴会、摄影\",\"尺寸\":\"均码\",\"层数\":\"2.0\",\"长度\":\"147.0\",\"洗涤方法\":\"1.可手洗、干洗，不可机洗。\\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\\n3.不可漂白。\\n32.可低温熨烫。\",\"保养\":\"1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\\n4.\\n33.存放于阴凉干燥的地方。\",\"适用人群\":\"都适用\",\"适用季节\":\"四季通用\"}');
INSERT INTO cparameters VALUES ('33', '33', 'R1806D14', '蕾丝', '香槟网纱', '适中', '均码', '无', 'http://shop.nuotisi.com:81/lvpai/R1806D14/FM/3.jpg,', 'http://shop.nuotisi.com:81/lvpai/R1806D14/XQ/X1.jpg,http://shop.nuotisi.com:81/lvpai/R1806D14/XQ/X2.jpg,', '13', '1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\n4.\n34.存放于阴凉干燥的地方。', '四季通用', '都适用', '婚礼、宴会、摄影', '4.0', '370.0', '152.0', '1.可手洗、干洗，不可机洗。\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\n3.不可漂白。\n33.可低温熨烫。', null, null, null, null, 'http://shop.nuotisi.com:81/lvpai/R1806D14/order/2.jpg,', '{\"厚薄\":\"适中\",\"重量\":\"370.0\",\"适用场景\":\"婚礼、宴会、摄影\",\"尺寸\":\"均码\",\"层数\":\"4.0\",\"长度\":\"152.0\",\"洗涤方法\":\"1.可手洗、干洗，不可机洗。\\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\\n3.不可漂白。\\n33.可低温熨烫。\",\"保养\":\"1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\\n4.\\n34.存放于阴凉干燥的地方。\",\"适用人群\":\"都适用\",\"适用季节\":\"四季通用\"}');
INSERT INTO cparameters VALUES ('34', '34', 'L18L2Q012', '深V、露背', '闪光缎', '适中', '均码', '无', 'http://shop.nuotisi.com:81/lvpai/L18L2Q012/FM/3.jpg,', 'http://shop.nuotisi.com:81/lvpai/L18L2Q012/XQ/X1.jpg,http://shop.nuotisi.com:81/lvpai/L18L2Q012/XQ/X2.jpg,', '7', '1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\n4.\n88.存放于阴凉干燥的地方。', '四季通用', '都适用', '', '2.0', '460.0', '152.0', '', null, null, null, null, 'http://shop.nuotisi.com:81/lvpai/L18L2Q012/order/2.jpg,', '{\"厚薄\":\"适中\",\"重量\":\"460.0\",\"适用场景\":\"\",\"尺寸\":\"均码\",\"层数\":\"2.0\",\"长度\":\"152.0\",\"洗涤方法\":\"\",\"保养\":\"1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\\n4.\\n88.存放于阴凉干燥的地方。\",\"适用人群\":\"都适用\",\"适用季节\":\"四季通用\"}');
INSERT INTO cparameters VALUES ('35', '35', 'R1804B06', 'V领、纱、蕾丝', '蕾丝', '适中', '均码', '无', 'http://shop.nuotisi.com:81/lvpai/R1804B06/FM/3.jpg,', 'http://shop.nuotisi.com:81/lvpai/R1804B06/XQ/X1.jpg,http://shop.nuotisi.com:81/lvpai/R1804B06/XQ/X2.jpg,', '1', '1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\n4.\n91.存放于阴凉干燥的地方。', '四季通用', '都适用', '', '2.0', '550.0', '152.0', '', null, null, null, null, 'http://shop.nuotisi.com:81/lvpai/R1804B06/order/2.jpg,', '{\"厚薄\":\"适中\",\"重量\":\"550.0\",\"适用场景\":\"\",\"尺寸\":\"均码\",\"层数\":\"2.0\",\"长度\":\"152.0\",\"洗涤方法\":\"\",\"保养\":\"1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\\n4.\\n91.存放于阴凉干燥的地方。\",\"适用人群\":\"都适用\",\"适用季节\":\"四季通用\"}');
INSERT INTO cparameters VALUES ('36', '36', 'R1808G11', '不规则、贴花、', '绣花纱 里布', '适中', '均码', '无', 'http://shop.nuotisi.com:81/lvpai/R1808G11/FM/3.jpg,', 'http://shop.nuotisi.com:81/lvpai/R1808G11/XQ/X1.jpg,http://shop.nuotisi.com:81/lvpai/R1808G11/XQ/X2.jpg,', '15', '1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\n4.\n92.存放于阴凉干燥的地方。', '四季通用', '都适用', '', '3.0', '190.0', '95.0', '', null, null, null, null, 'http://shop.nuotisi.com:81/lvpai/R1808G11/order/2.jpg,', '{\"厚薄\":\"适中\",\"重量\":\"190.0\",\"适用场景\":\"\",\"尺寸\":\"均码\",\"层数\":\"3.0\",\"长度\":\"95.0\",\"洗涤方法\":\"\",\"保养\":\"1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\\n4.\\n92.存放于阴凉干燥的地方。\",\"适用人群\":\"都适用\",\"适用季节\":\"四季通用\"}');
INSERT INTO cparameters VALUES ('37', '37', 'E5809', '腰带、贴花', '仿真丝雪纺', '适中', '均码', '无', 'http://shop.nuotisi.com:81/lvpai/E5809/FM/3.jpg,', 'http://shop.nuotisi.com:81/lvpai/E5809/XQ/X1.jpg,http://shop.nuotisi.com:81/lvpai/E5809/XQ/X2.jpg,', '1', '1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\n4.\n96.存放于阴凉干燥的地方。', '四季通用', '都适用', '', '2.0', '450.0', '150.0', '', null, null, null, null, 'http://shop.nuotisi.com:81/lvpai/E5809/order/2.jpg,', '{\"厚薄\":\"适中\",\"重量\":\"450.0\",\"适用场景\":\"\",\"尺寸\":\"均码\",\"层数\":\"2.0\",\"长度\":\"150.0\",\"洗涤方法\":\"\",\"保养\":\"1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\\n4.\\n96.存放于阴凉干燥的地方。\",\"适用人群\":\"都适用\",\"适用季节\":\"四季通用\"}');
INSERT INTO cparameters VALUES ('38', '38', 'R1806E09', '抓褶、不对称', '点点网', '适中', '均码', '无', 'http://shop.nuotisi.com:81/lvpai/R1806E09/FM/3.jpg,', 'http://shop.nuotisi.com:81/lvpai/R1806E09/XQ/X1.jpg,http://shop.nuotisi.com:81/lvpai/R1806E09/XQ/X2.jpg,', '10', '1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\n4.\n98.存放于阴凉干燥的地方。', '四季通用', '都适用', '', '2.0', '110.0', '150.0', '', null, null, null, null, 'http://shop.nuotisi.com:81/lvpai/R1806E09/order/2.jpg,', '{\"厚薄\":\"适中\",\"重量\":\"110.0\",\"适用场景\":\"\",\"尺寸\":\"均码\",\"层数\":\"2.0\",\"长度\":\"150.0\",\"洗涤方法\":\"\",\"保养\":\"1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\\n4.\\n98.存放于阴凉干燥的地方。\",\"适用人群\":\"都适用\",\"适用季节\":\"四季通用\"}');
INSERT INTO cparameters VALUES ('39', '39', 'R1806A56', '纱、荷叶边', '米色瑞士网', '适中', '均码', '无', 'http://shop.nuotisi.com:81/lvpai/R1806A56/FM/3.jpg,', 'http://shop.nuotisi.com:81/lvpai/R1806A56/XQ/X1.jpg,http://shop.nuotisi.com:81/lvpai/R1806A56/XQ/X2.jpg,', '1', '1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\n4.\n100.存放于阴凉干燥的地方。', '四季通用', '都适用', '', '5.0', '490.0', '152.0', '', null, null, null, null, 'http://shop.nuotisi.com:81/lvpai/R1806A56/order/2.jpg,', '{\"厚薄\":\"适中\",\"重量\":\"490.0\",\"适用场景\":\"\",\"尺寸\":\"均码\",\"层数\":\"5.0\",\"长度\":\"152.0\",\"洗涤方法\":\"\",\"保养\":\"1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\\n4.\\n100.存放于阴凉干燥的地方。\",\"适用人群\":\"都适用\",\"适用季节\":\"四季通用\"}');
INSERT INTO cparameters VALUES ('40', '40', 'R1806B12', '深V、露背、蕾丝', '条纹蕾丝', '适中', '均码', '无', 'http://shop.nuotisi.com:81/lvpai/R1806B12/FM/3.jpg,', 'http://shop.nuotisi.com:81/lvpai/R1806B12/XQ/X1.jpg,http://shop.nuotisi.com:81/lvpai/R1806B12/XQ/X2.jpg,', '16', '1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\n4.\n101.存放于阴凉干燥的地方。', '四季通用', '都适用', '', '2.0', '380.0', '152.0', '', null, null, null, null, 'http://shop.nuotisi.com:81/lvpai/R1806B12/order/2.jpg,', '{\"厚薄\":\"适中\",\"重量\":\"380.0\",\"适用场景\":\"\",\"尺寸\":\"均码\",\"层数\":\"2.0\",\"长度\":\"152.0\",\"洗涤方法\":\"\",\"保养\":\"1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\\n4.\\n101.存放于阴凉干燥的地方。\",\"适用人群\":\"都适用\",\"适用季节\":\"四季通用\"}');
INSERT INTO cparameters VALUES ('41', '41', 'R1808F24', '贴花、蝴蝶结', '美国缎', '适中', '均码', '无', 'http://shop.nuotisi.com:81/lvpai/R1808F24/FM/3.jpg,', 'http://shop.nuotisi.com:81/lvpai/R1808F24/XQ/X1.jpg,http://shop.nuotisi.com:81/lvpai/R1808F24/XQ/X2.jpg,', '17', '1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\n4.\n102.存放于阴凉干燥的地方。', '四季通用', '都适用', '', '2.0', '510.0', '150.0', '', null, null, null, null, 'http://shop.nuotisi.com:81/lvpai/R1808F24/order/2.jpg,', '{\"厚薄\":\"适中\",\"重量\":\"510.0\",\"适用场景\":\"\",\"尺寸\":\"均码\",\"层数\":\"2.0\",\"长度\":\"150.0\",\"洗涤方法\":\"\",\"保养\":\"1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\\n4.\\n102.存放于阴凉干燥的地方。\",\"适用人群\":\"都适用\",\"适用季节\":\"四季通用\"}');
INSERT INTO cparameters VALUES ('42', '42', 'R1808F25', '蕾丝、露背', '黑色瑞士网 蕾丝', '适中', '均码', '无', 'http://shop.nuotisi.com:81/lvpai/R1808F25/FM/3.jpg,', 'http://shop.nuotisi.com:81/lvpai/R1808F25/XQ/X1.jpg,http://shop.nuotisi.com:81/lvpai/R1808F25/XQ/X2.jpg,', '10', '1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\n4.\n103.存放于阴凉干燥的地方。', '四季通用', '都适用', '', '2.0', '360.0', '147.0', '', null, null, null, null, 'http://shop.nuotisi.com:81/lvpai/R1808F25/order/2.jpg,', '{\"厚薄\":\"适中\",\"重量\":\"360.0\",\"适用场景\":\"\",\"尺寸\":\"均码\",\"层数\":\"2.0\",\"长度\":\"147.0\",\"洗涤方法\":\"\",\"保养\":\"1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\\n4.\\n103.存放于阴凉干燥的地方。\",\"适用人群\":\"都适用\",\"适用季节\":\"四季通用\"}');
INSERT INTO cparameters VALUES ('43', '43', 'R1807A85', '蕾丝腰带、荷叶边、', '天蓝瑞士网 ', '适中', '均码', '无', 'http://shop.nuotisi.com:81/lvpai/R1807A85/FM/3.jpg,', 'http://shop.nuotisi.com:81/lvpai/R1807A85/XQ/X1.jpg,http://shop.nuotisi.com:81/lvpai/R1807A85/XQ/X2.jpg,', '18', '1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\n4.\n104.存放于阴凉干燥的地方。', '四季通用', '都适用', '', '5.0', '490.0', '152.0', '', null, null, null, null, 'http://shop.nuotisi.com:81/lvpai/R1807A85/order/2.jpg,', '{\"厚薄\":\"适中\",\"重量\":\"490.0\",\"适用场景\":\"\",\"尺寸\":\"均码\",\"层数\":\"5.0\",\"长度\":\"152.0\",\"洗涤方法\":\"\",\"保养\":\"1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\\n4.\\n104.存放于阴凉干燥的地方。\",\"适用人群\":\"都适用\",\"适用季节\":\"四季通用\"}');
INSERT INTO cparameters VALUES ('44', '44', 'R1806D10', '腰带、撞色', '365缎', '适中', '均码', '无', 'http://shop.nuotisi.com:81/lvpai/R1806D10/FM/3.jpg,', 'http://shop.nuotisi.com:81/lvpai/R1806D10/XQ/X1.jpg,http://shop.nuotisi.com:81/lvpai/R1806D10/XQ/X2.jpg,', '19', '1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\n4.\n105.存放于阴凉干燥的地方。', '四季通用', '都适用', '', '2.0', '579.0', '152.0', '', null, null, null, null, 'http://shop.nuotisi.com:81/lvpai/R1806D10/order/2.jpg,', '{\"厚薄\":\"适中\",\"重量\":\"579.0\",\"适用场景\":\"\",\"尺寸\":\"均码\",\"层数\":\"2.0\",\"长度\":\"152.0\",\"洗涤方法\":\"\",\"保养\":\"1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\\n4.\\n105.存放于阴凉干燥的地方。\",\"适用人群\":\"都适用\",\"适用季节\":\"四季通用\"}');
INSERT INTO cparameters VALUES ('45', '45', 'R1806C18', '泡泡袖、蝴蝶结、蕾丝', '粉色网纱', '适中', '均码', '无', 'http://shop.nuotisi.com:81/lvpai/R1806C18/FM/3.jpg,', 'http://shop.nuotisi.com:81/lvpai/R1806C18/XQ/X1.jpg,http://shop.nuotisi.com:81/lvpai/R1806C18/XQ/X2.jpg,', '20', '1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\n4.\n106.存放于阴凉干燥的地方。', '四季通用', '都适用', '', '4.0', '240.0', '152.0', '', null, null, null, null, 'http://shop.nuotisi.com:81/lvpai/R1806C18/order/2.jpg,', '{\"厚薄\":\"适中\",\"重量\":\"240.0\",\"适用场景\":\"\",\"尺寸\":\"均码\",\"层数\":\"4.0\",\"长度\":\"152.0\",\"洗涤方法\":\"\",\"保养\":\"1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\\n4.\\n106.存放于阴凉干燥的地方。\",\"适用人群\":\"都适用\",\"适用季节\":\"四季通用\"}');
INSERT INTO cparameters VALUES ('46', '46', 'R1809A120', '不对称、一字肩', '大红软缎', '适中', '均码', '无', 'http://shop.nuotisi.com:81/lvpai/R1809A120/FM/3.jpg,', 'http://shop.nuotisi.com:81/lvpai/R1809A120/XQ/X1.jpg,http://shop.nuotisi.com:81/lvpai/R1809A120/XQ/X2.jpg,', '7', '1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\n4.\n107.存放于阴凉干燥的地方。', '四季通用', '都适用', '', '2.0', '860.0', '152.0', '', null, null, null, null, 'http://shop.nuotisi.com:81/lvpai/R1809A120/order/2.jpg,', '{\"厚薄\":\"适中\",\"重量\":\"860.0\",\"适用场景\":\"\",\"尺寸\":\"均码\",\"层数\":\"2.0\",\"长度\":\"152.0\",\"洗涤方法\":\"\",\"保养\":\"1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\\n4.\\n107.存放于阴凉干燥的地方。\",\"适用人群\":\"都适用\",\"适用季节\":\"四季通用\"}');
INSERT INTO cparameters VALUES ('47', '47', 'R1807F14', '蕾丝、蝴蝶结', '香槟网纱', '适中', '均码', '无', 'http://shop.nuotisi.com:81/lvpai/R1807F14/FM/3.jpg,', 'http://shop.nuotisi.com:81/lvpai/R1807F14/XQ/X1.jpg,http://shop.nuotisi.com:81/lvpai/R1807F14/XQ/X2.jpg,', '13', '1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\n4.\n108.存放于阴凉干燥的地方。', '四季通用', '都适用', '', '5.0', '450.0', '152.0', '', null, null, null, null, 'http://shop.nuotisi.com:81/lvpai/R1807F14/order/2.jpg,', '{\"厚薄\":\"适中\",\"重量\":\"450.0\",\"适用场景\":\"\",\"尺寸\":\"均码\",\"层数\":\"5.0\",\"长度\":\"152.0\",\"洗涤方法\":\"\",\"保养\":\"1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\\n4.\\n108.存放于阴凉干燥的地方。\",\"适用人群\":\"都适用\",\"适用季节\":\"四季通用\"}');
INSERT INTO cparameters VALUES ('48', '48', 'R1808F21', '立体花、贴花', '仿真丝', '适中', '均码', '无', 'http://shop.nuotisi.com:81/lvpai/R1808F21/FM/3.jpg,', 'http://shop.nuotisi.com:81/lvpai/R1808F21/XQ/X1.jpg,http://shop.nuotisi.com:81/lvpai/R1808F21/XQ/X2.jpg,', '21', '1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\n4.\n109.存放于阴凉干燥的地方。', '四季通用', '都适用', '', '2.0', '750.0', '150.0', '', null, null, null, null, 'http://shop.nuotisi.com:81/lvpai/R1808F21/order/2.jpg,', '{\"厚薄\":\"适中\",\"重量\":\"750.0\",\"适用场景\":\"\",\"尺寸\":\"均码\",\"层数\":\"2.0\",\"长度\":\"150.0\",\"洗涤方法\":\"\",\"保养\":\"1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\\n4.\\n109.存放于阴凉干燥的地方。\",\"适用人群\":\"都适用\",\"适用季节\":\"四季通用\"}');
INSERT INTO cparameters VALUES ('49', '49', 'R1806E12', '蕾丝、纱、贴花', '浅绿软网', '适中', '均码', '无', 'http://shop.nuotisi.com:81/lvpai/R1806E12/FM/3.jpg,', 'http://shop.nuotisi.com:81/lvpai/R1806E12/XQ/X1.jpg,http://shop.nuotisi.com:81/lvpai/R1806E12/XQ/X2.jpg,', '22', '1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\n4.\n110.存放于阴凉干燥的地方。', '四季通用', '都适用', '', '5.0', '590.0', '152.0', '', null, null, null, null, 'http://shop.nuotisi.com:81/lvpai/R1806E12/order/2.jpg,', '{\"厚薄\":\"适中\",\"重量\":\"590.0\",\"适用场景\":\"\",\"尺寸\":\"均码\",\"层数\":\"5.0\",\"长度\":\"152.0\",\"洗涤方法\":\"\",\"保养\":\"1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\\n4.\\n110.存放于阴凉干燥的地方。\",\"适用人群\":\"都适用\",\"适用季节\":\"四季通用\"}');
INSERT INTO cparameters VALUES ('50', '50', 'R1809D36', '蕾丝、贴花', '丝绒 九如网', '适中', '均码', '无', 'http://shop.nuotisi.com:81/lvpai/R1809D36/FM/3.jpg,', 'http://shop.nuotisi.com:81/lvpai/R1809D36/XQ/X1.jpg,http://shop.nuotisi.com:81/lvpai/R1809D36/XQ/X2.jpg,', '10', '1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\n4.\n113.存放于阴凉干燥的地方。', '四季通用', '都适用', '', '2.0', '750.0', '150.0', '', null, null, null, null, 'http://shop.nuotisi.com:81/lvpai/R1809D36/order/2.jpg,', '{\"厚薄\":\"适中\",\"重量\":\"750.0\",\"适用场景\":\"\",\"尺寸\":\"均码\",\"层数\":\"2.0\",\"长度\":\"150.0\",\"洗涤方法\":\"\",\"保养\":\"1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\\n4.\\n113.存放于阴凉干燥的地方。\",\"适用人群\":\"都适用\",\"适用季节\":\"四季通用\"}');
INSERT INTO cparameters VALUES ('51', '51', 'R1809E23', '纱、手绘', '浅粉厚纱', '适中', '均码', '无', 'http://shop.nuotisi.com:81/lvpai/R1809E23/FM/3.jpg,', 'http://shop.nuotisi.com:81/lvpai/R1809E23/XQ/X1.jpg,http://shop.nuotisi.com:81/lvpai/R1809E23/XQ/X2.jpg,', '1', '1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\n4.\n114.存放于阴凉干燥的地方。', '四季通用', '都适用', '', '4.0', '405.0', '135.0', '', null, null, null, null, 'http://shop.nuotisi.com:81/lvpai/R1809E23/order/2.jpg,', '{\"厚薄\":\"适中\",\"重量\":\"405.0\",\"适用场景\":\"\",\"尺寸\":\"均码\",\"层数\":\"4.0\",\"长度\":\"135.0\",\"洗涤方法\":\"\",\"保养\":\"1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\\n4.\\n114.存放于阴凉干燥的地方。\",\"适用人群\":\"都适用\",\"适用季节\":\"四季通用\"}');
INSERT INTO cparameters VALUES ('52', '52', 'R1810A126', '纱，V领', '香槟网纱', '适中', '均码', '无', 'http://shop.nuotisi.com:81/lvpai/R1810A126/FM/3.jpg,', 'http://shop.nuotisi.com:81/lvpai/R1810A126/XQ/X1.jpg,http://shop.nuotisi.com:81/lvpai/R1810A126/XQ/X2.jpg,', '13', '1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\n4.\n115.存放于阴凉干燥的地方。', '四季通用', '都适用', '', '5.0', '760.0', '152.0', '', null, null, null, null, 'http://shop.nuotisi.com:81/lvpai/R1810A126/order/2.jpg,', '{\"厚薄\":\"适中\",\"重量\":\"760.0\",\"适用场景\":\"\",\"尺寸\":\"均码\",\"层数\":\"5.0\",\"长度\":\"152.0\",\"洗涤方法\":\"\",\"保养\":\"1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\\n4.\\n115.存放于阴凉干燥的地方。\",\"适用人群\":\"都适用\",\"适用季节\":\"四季通用\"}');
INSERT INTO cparameters VALUES ('53', '53', 'S5454-5', '单肩、褶皱、不规则', '雪纺纱、缎里', '适中', '均码', '无', 'http://shop.nuotisi.com:81/lvpai/S5454-5/FM/3.jpg,', 'http://shop.nuotisi.com:81/lvpai/S5454-5/XQ/X1.jpg,http://shop.nuotisi.com:81/lvpai/S5454-5/XQ/X2.jpg,', '23', '1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\n4.\n116.存放于阴凉干燥的地方。', '四季通用', '都适用', '', '3.0', '400.0', '147.0', '', null, null, null, null, 'http://shop.nuotisi.com:81/lvpai/S5454-5/order/2.jpg,', '{\"厚薄\":\"适中\",\"重量\":\"400.0\",\"适用场景\":\"\",\"尺寸\":\"均码\",\"层数\":\"3.0\",\"长度\":\"147.0\",\"洗涤方法\":\"\",\"保养\":\"1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\\n4.\\n116.存放于阴凉干燥的地方。\",\"适用人群\":\"都适用\",\"适用季节\":\"四季通用\"}');
INSERT INTO cparameters VALUES ('54', '54', 'S5864-1', '一字肩、工艺结构', '大红美国缎', '适中', '均码', '无', 'http://shop.nuotisi.com:81/lvpai/S5864-1/FM/3.jpg,', 'http://shop.nuotisi.com:81/lvpai/S5864-1/XQ/X1.jpg,http://shop.nuotisi.com:81/lvpai/S5864-1/XQ/X2.jpg,', '7', '1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\n4.\n117.存放于阴凉干燥的地方。', '四季通用', '都适用', '', '2.0', '763.0', '147.0', '', null, null, null, null, 'http://shop.nuotisi.com:81/lvpai/S5864-1/order/2.jpg,', '{\"厚薄\":\"适中\",\"重量\":\"763.0\",\"适用场景\":\"\",\"尺寸\":\"均码\",\"层数\":\"2.0\",\"长度\":\"147.0\",\"洗涤方法\":\"\",\"保养\":\"1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\\n4.\\n117.存放于阴凉干燥的地方。\",\"适用人群\":\"都适用\",\"适用季节\":\"四季通用\"}');
INSERT INTO cparameters VALUES ('55', '55', 'R1806B13', '荷叶边，蕾丝，纱', '网纱', '适中', '均码', '无', 'http://shop.nuotisi.com:81/lvpai/R1806B13/FM/3.jpg,', 'http://shop.nuotisi.com:81/lvpai/R1806B13/XQ/X1.jpg,http://shop.nuotisi.com:81/lvpai/R1806B13/XQ/X2.jpg,', '1', '1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\n4.\n88.存放于阴凉干燥的地方。', '四季通用', '都适用', '', '4.0', '390.0', '147.0', '', null, null, null, null, 'http://shop.nuotisi.com:81/lvpai/R1806B13/order/2.jpg,', '{\"厚薄\":\"适中\",\"重量\":\"390.0\",\"适用场景\":\"\",\"尺寸\":\"均码\",\"层数\":\"4.0\",\"长度\":\"147.0\",\"洗涤方法\":\"\",\"保养\":\"1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\\n4.\\n88.存放于阴凉干燥的地方。\",\"适用人群\":\"都适用\",\"适用季节\":\"四季通用\"}');
INSERT INTO cparameters VALUES ('56', '56', 'L18B2D006', '白底大黑圆点绸缎', '波点元素结合简约的廓形，立体收腰裁剪，后背深V领设计更加复古优雅。', '适中', '均码', '无', 'http://shop.nuotisi.com:81/lvpai/L18B2D006/FM/3.jpg,', 'http://shop.nuotisi.com:81/lvpai/L18B2D006/XQ/X1.jpg,http://shop.nuotisi.com:81/lvpai/L18B2D006/XQ/X2.jpg,', '1', '无', '2.0', '110.0', '697.0', '时尚的复古波点元素结合简约的廓形，后背深V领设计', '', '精准的裁剪，精细的车工，精美的抽褶。', '量身定制', null, null, null, null, 'http://shop.nuotisi.com:81/lvpai/L18B2D006/order/2.jpg,', '{\"厚薄\":\"适中\",\"重量\":\"\",\"适用场景\":\"697.0\",\"尺寸\":\"均码\",\"层数\":\"时尚的复古波点元素结合简约的廓形，后背深V领设计\",\"长度\":\"精准的裁剪，精细的车工，精美的抽褶。\",\"洗涤方法\":\"量身定制\",\"保养\":\"无\",\"适用人群\":\"110.0\",\"适用季节\":\"2.0\"}');
INSERT INTO cparameters VALUES ('57', '57', 'L18B2D019', '浅粉美国软网、米美国软网、喷粉细纱', '浪漫的抽褶立领搭配精美的蕾丝再加上浪漫的白纱，更加迷人。', '适中', '均码', '无', 'http://shop.nuotisi.com:81/lvpai/L18B2D019/FM/3.jpg,', 'http://shop.nuotisi.com:81/lvpai/L18B2D019/XQ/X1.jpg,http://shop.nuotisi.com:81/lvpai/L18B2D019/XQ/X2.jpg,', '3', '无', '3.0', '110.0', '400.0', '立体抽褶立领，浪漫蕾丝贴花', '', '精准的裁剪，精细的车工，精美的抽褶和蕾丝贴花。', '量身定制', null, null, null, null, 'http://shop.nuotisi.com:81/lvpai/L18B2D019/order/2.jpg,', '{\"厚薄\":\"适中\",\"重量\":\"\",\"适用场景\":\"400.0\",\"尺寸\":\"均码\",\"层数\":\"立体抽褶立领，浪漫蕾丝贴花\",\"长度\":\"精准的裁剪，精细的车工，精美的抽褶和蕾丝贴花。\",\"洗涤方法\":\"量身定制\",\"保养\":\"无\",\"适用人群\":\"110.0\",\"适用季节\":\"3.0\"}');
INSERT INTO cparameters VALUES ('58', '58', 'L18H1T013', '米美国网、浅香槟美国网', '精美的立体裁剪，气质的一字肩仿西装设计搭配浪漫的白纱更加时尚大气', '适中', '均码', '无', 'http://shop.nuotisi.com:81/lvpai/L18H1T013/FM/3.jpg,', 'http://shop.nuotisi.com:81/lvpai/L18H1T013/XQ/X1.jpg,http://shop.nuotisi.com:81/lvpai/L18H1T013/XQ/X2.jpg,', '2', '无', '4.0', '152.0', '703.0', '精美的立体裁剪，气质的一字肩仿西装设计搭配浪漫的白纱更加时尚大气', '', '精准的裁剪，精细的车工，精美的立体裁剪。', '量身定制', null, null, null, null, 'http://shop.nuotisi.com:81/lvpai/L18H1T013/order/2.jpg,', '{\"厚薄\":\"适中\",\"重量\":\"\",\"适用场景\":\"703.0\",\"尺寸\":\"均码\",\"层数\":\"精美的立体裁剪，气质的一字肩仿西装设计搭配浪漫的白纱更加时尚大气\",\"长度\":\"精准的裁剪，精细的车工，精美的立体裁剪。\",\"洗涤方法\":\"量身定制\",\"保养\":\"无\",\"适用人群\":\"152.0\",\"适用季节\":\"4.0\"}');
INSERT INTO cparameters VALUES ('59', '59', 'L18H2T002', '米蕾丝、米美国软网', '', '适中', '均码', '无', 'http://shop.nuotisi.com:81/lvpai/L18H2T002/FM/3.jpg,', 'http://shop.nuotisi.com:81/lvpai/L18H2T002/XQ/X1.jpg,http://shop.nuotisi.com:81/lvpai/L18H2T002/XQ/X2.jpg,', '1', '无', '3.0', '152.0', '428.0', '', '', '精准的裁剪，精细的车工，精美的抽褶和蕾丝贴花。', '量身定制', null, null, null, null, 'http://shop.nuotisi.com:81/lvpai/L18H2T002/order/2.jpg,', '{\"厚薄\":\"适中\",\"重量\":\"\",\"适用场景\":\"428.0\",\"尺寸\":\"均码\",\"层数\":\"\",\"长度\":\"精准的裁剪，精细的车工，精美的抽褶和蕾丝贴花。\",\"洗涤方法\":\"量身定制\",\"保养\":\"无\",\"适用人群\":\"152.0\",\"适用季节\":\"3.0\"}');
INSERT INTO cparameters VALUES ('60', '60', 'L18H2T020', '米瑞士网、粉色瑞士网', '性感的吊带V领，唯美的褶皱，简约又不简单的款式搭配后背绑带更加性感迷人。', '适中', '均码', '无', 'http://shop.nuotisi.com:81/lvpai/L18H2T020/FM/3.jpg,', 'http://shop.nuotisi.com:81/lvpai/L18H2T020/XQ/X1.jpg,http://shop.nuotisi.com:81/lvpai/L18H2T020/XQ/X2.jpg,', '1', '无', '1.0', '152.0', '838.0', '吊带V领，唯美的褶皱，后背绑带更加性感迷人。', '', '精准的裁剪，精细的车工，精美的抽褶和立体裁剪。', '量身定制', null, null, null, null, 'http://shop.nuotisi.com:81/lvpai/L18H2T020/order/2.jpg,', '{\"厚薄\":\"适中\",\"重量\":\"\",\"适用场景\":\"838.0\",\"尺寸\":\"均码\",\"层数\":\"吊带V领，唯美的褶皱，后背绑带更加性感迷人。\",\"长度\":\"精准的裁剪，精细的车工，精美的抽褶和立体裁剪。\",\"洗涤方法\":\"量身定制\",\"保养\":\"无\",\"适用人群\":\"152.0\",\"适用季节\":\"1.0\"}');
INSERT INTO cparameters VALUES ('61', '61', 'L18H5T023', '米蕾丝、香槟瑞士网', '浪漫的深V荷叶边装饰领，绑带喇叭袖搭配精美的蕾丝更加优雅迷人。', '适中', '均码', '无', 'http://shop.nuotisi.com:81/lvpai/L18H5T023/FM/3.jpg,', 'http://shop.nuotisi.com:81/lvpai/L18H5T023/XQ/X1.jpg,http://shop.nuotisi.com:81/lvpai/L18H5T023/XQ/X2.jpg,', '3', '无', '2.0', '152.0', '356.0', '深V荷叶边装饰领，绑带喇叭袖，精美的蕾丝。', '', '精准的裁剪，精细的车工，精美的抽褶和蕾丝贴花。', '量身定制', null, null, null, null, 'http://shop.nuotisi.com:81/lvpai/L18H5T023/order/2.jpg,', '{\"厚薄\":\"适中\",\"重量\":\"\",\"适用场景\":\"356.0\",\"尺寸\":\"均码\",\"层数\":\"深V荷叶边装饰领，绑带喇叭袖，精美的蕾丝。\",\"长度\":\"精准的裁剪，精细的车工，精美的抽褶和蕾丝贴花。\",\"洗涤方法\":\"量身定制\",\"保养\":\"无\",\"适用人群\":\"152.0\",\"适用季节\":\"2.0\"}');
INSERT INTO cparameters VALUES ('62', '62', 'L18L2Q012', '米美国软网', '唯美的吊带V领，既简约又大气版型。', '适中', '均码', '无', 'http://shop.nuotisi.com:81/lvpai/L18L2Q012/FM/3.jpg,', 'http://shop.nuotisi.com:81/lvpai/L18L2Q012/XQ/X1.jpg,http://shop.nuotisi.com:81/lvpai/L18L2Q012/XQ/X2.jpg,', '7', '无', '1.0', '152.0', '906.0', '唯美的吊带V领，既简约又大气版型。', '', '精准的裁剪，精细的车工，精美的抽褶和蕾丝贴花。', '量身定制', null, null, null, null, 'http://shop.nuotisi.com:81/lvpai/L18L2Q012/order/2.jpg,', '{\"厚薄\":\"适中\",\"重量\":\"\",\"适用场景\":\"906.0\",\"尺寸\":\"均码\",\"层数\":\"唯美的吊带V领，既简约又大气版型。\",\"长度\":\"精准的裁剪，精细的车工，精美的抽褶和蕾丝贴花。\",\"洗涤方法\":\"量身定制\",\"保养\":\"无\",\"适用人群\":\"152.0\",\"适用季节\":\"1.0\"}');
INSERT INTO cparameters VALUES ('63', '63', 'L18L2T011', '香槟瑞士网、香槟美国软网', '性感的吊带V领，时尚的3D印花简约又不简单的款式搭配后背绑带更加性感迷人。', '适中', '均码', '无', 'http://shop.nuotisi.com:81/lvpai/L18L2T011/FM/3.jpg,', 'http://shop.nuotisi.com:81/lvpai/L18L2T011/XQ/X1.jpg,http://shop.nuotisi.com:81/lvpai/L18L2T011/XQ/X2.jpg,', '24', '无', '3.0', '152.0', '1704.0', '吊带V领，3D印花简约又不简单的款式搭配后背绑带。', '', '精准的裁剪，精细的车工。', '量身定制', null, null, null, null, 'http://shop.nuotisi.com:81/lvpai/L18L2T011/order/2.jpg,', '{\"厚薄\":\"适中\",\"重量\":\"\",\"适用场景\":\"1704.0\",\"尺寸\":\"均码\",\"层数\":\"吊带V领，3D印花简约又不简单的款式搭配后背绑带。\",\"长度\":\"精准的裁剪，精细的车工。\",\"洗涤方法\":\"量身定制\",\"保养\":\"无\",\"适用人群\":\"152.0\",\"适用季节\":\"3.0\"}');
INSERT INTO cparameters VALUES ('64', '64', 'L18L2T027', '酒红软网、暗红支角网、暗紫软网', '性感的深V领，唯美的立体褶皱加上精致的蝴蝶结，更加优雅迷人。', '适中', '均码', '无', 'http://shop.nuotisi.com:81/lvpai/L18L2T027/FM/3.jpg,', 'http://shop.nuotisi.com:81/lvpai/L18L2T027/XQ/X1.jpg,http://shop.nuotisi.com:81/lvpai/L18L2T027/XQ/X2.jpg,', '25', '无', '4.0', '152.0', '601.0', '立体褶皱，精致的蝴蝶结。', '', '精准的裁剪，精细的车工，精美的抽褶。', '量身定制', null, null, null, null, 'http://shop.nuotisi.com:81/lvpai/L18L2T027/order/2.jpg,', '{\"厚薄\":\"适中\",\"重量\":\"\",\"适用场景\":\"601.0\",\"尺寸\":\"均码\",\"层数\":\"立体褶皱，精致的蝴蝶结。\",\"长度\":\"精准的裁剪，精细的车工，精美的抽褶。\",\"洗涤方法\":\"量身定制\",\"保养\":\"无\",\"适用人群\":\"152.0\",\"适用季节\":\"4.0\"}');
INSERT INTO cparameters VALUES ('65', '65', 'R17L2Q039', '披肩，蕾丝，珠绣', '缎面 网纱', '适中', '均码', '无', 'http://shop.nuotisi.com:81/lifu/R17L2Q039/FM/3.jpg,', 'http://shop.nuotisi.com:81/lifu/R17L2Q039/XQ/X1.jpg,http://shop.nuotisi.com:81/lifu/R17L2Q039/XQ/X2.jpg,', '7', '1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\n4.\n22.存放于阴凉干燥的地方。', '四季通用', '都适用', '婚礼、宴会、摄影', '2.0', '1200.0', '147.0', '1.可手洗、干洗，不可机洗。\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\n3.不可漂白。\n21.可低温熨烫。', null, null, null, null, 'http://shop.nuotisi.com:81/lifu/R17L2Q039/order/2.jpg,', '{\"厚薄\":\"适中\",\"重量\":\"1200.0\",\"适用场景\":\"婚礼、宴会、摄影\",\"尺寸\":\"均码\",\"层数\":\"2.0\",\"长度\":\"147.0\",\"洗涤方法\":\"1.可手洗、干洗，不可机洗。\\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\\n3.不可漂白。\\n21.可低温熨烫。\",\"保养\":\"1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\\n4.\\n22.存放于阴凉干燥的地方。\",\"适用人群\":\"都适用\",\"适用季节\":\"四季通用\"}');
INSERT INTO cparameters VALUES ('66', '66', 'R17L2Q012 ', '蕾丝，珠绣，立领', '缎面', '适中', '均码', '无', 'http://shop.nuotisi.com:81/lifu/R17L2Q012/FM/3.jpg,', 'http://shop.nuotisi.com:81/lifu/R17L2Q012/XQ/X1.jpg,http://shop.nuotisi.com:81/lifu/R17L2Q012/XQ/X2.jpg,', '7', '1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\n4.\n23.存放于阴凉干燥的地方。', '四季通用', '都适用', '婚礼、宴会、摄影', '2.0', '1200.0', '147.0', '1.可手洗、干洗，不可机洗。\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\n3.不可漂白。\n22.可低温熨烫。', null, null, null, null, 'http://shop.nuotisi.com:81/lifu/R17L2Q012/order/2.jpg,', '{\"厚薄\":\"适中\",\"重量\":\"1200.0\",\"适用场景\":\"婚礼、宴会、摄影\",\"尺寸\":\"均码\",\"层数\":\"2.0\",\"长度\":\"147.0\",\"洗涤方法\":\"1.可手洗、干洗，不可机洗。\\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\\n3.不可漂白。\\n22.可低温熨烫。\",\"保养\":\"1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\\n4.\\n23.存放于阴凉干燥的地方。\",\"适用人群\":\"都适用\",\"适用季节\":\"四季通用\"}');
INSERT INTO cparameters VALUES ('67', '67', 'R17L2Q036 ', '珠绣，鱼尾，纱', '网纱', '适中', '均码', '无', 'http://shop.nuotisi.com:81/lifu/R17L2Q036/FM/3.jpg,', 'http://shop.nuotisi.com:81/lifu/R17L2Q036/XQ/X1.jpg,http://shop.nuotisi.com:81/lifu/R17L2Q036/XQ/X2.jpg,', '7', '1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\n4.\n24.存放于阴凉干燥的地方。', '四季通用', '都适用', '摄影', '5.0', '1420.0', '147.0', '1.可手洗、干洗，不可机洗。\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\n3.不可漂白。\n23.可低温熨烫。', null, null, null, null, 'http://shop.nuotisi.com:81/lifu/R17L2Q036/order/2.jpg,', '{\"厚薄\":\"适中\",\"重量\":\"1420.0\",\"适用场景\":\"摄影\",\"尺寸\":\"均码\",\"层数\":\"5.0\",\"长度\":\"147.0\",\"洗涤方法\":\"1.可手洗、干洗，不可机洗。\\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\\n3.不可漂白。\\n23.可低温熨烫。\",\"保养\":\"1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\\n4.\\n24.存放于阴凉干燥的地方。\",\"适用人群\":\"都适用\",\"适用季节\":\"四季通用\"}');
INSERT INTO cparameters VALUES ('68', '68', 'R17L2Q134 ', '褶皱，钉钻，珠绣', '缎面', '适中', '均码', '无', 'http://shop.nuotisi.com:81/lifu/R17L2Q134/FM/3.jpg,', 'http://shop.nuotisi.com:81/lifu/R17L2Q134/XQ/X1.jpg,http://shop.nuotisi.com:81/lifu/R17L2Q134/XQ/X2.jpg,', '7', '1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\n4.\n25.存放于阴凉干燥的地方。', '四季通用', '都适用', '摄影', '2.0', '1250.0', '147.0', '1.可手洗、干洗，不可机洗。\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\n3.不可漂白。\n24.可低温熨烫。', null, null, null, null, 'http://shop.nuotisi.com:81/lifu/R17L2Q134/order/2.jpg,', '{\"厚薄\":\"适中\",\"重量\":\"1250.0\",\"适用场景\":\"摄影\",\"尺寸\":\"均码\",\"层数\":\"2.0\",\"长度\":\"147.0\",\"洗涤方法\":\"1.可手洗、干洗，不可机洗。\\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\\n3.不可漂白。\\n24.可低温熨烫。\",\"保养\":\"1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\\n4.\\n25.存放于阴凉干燥的地方。\",\"适用人群\":\"都适用\",\"适用季节\":\"四季通用\"}');
INSERT INTO cparameters VALUES ('69', '69', 'R1807A96', '钉珠，丝绒，腰带', '网纱', '适中', '均码', '无', 'http://shop.nuotisi.com:81/lifu/R1807A96/FM/3.jpg,', 'http://shop.nuotisi.com:81/lifu/R1807A96/XQ/X1.jpg,http://shop.nuotisi.com:81/lifu/R1807A96/XQ/X2.jpg,', '7', '1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\n4.\n29.存放于阴凉干燥的地方。', '四季通用', '都适用', '婚礼、宴会、摄影', '2.0', '1100.0', '150.0', '1.可手洗、干洗，不可机洗。\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\n3.不可漂白。\n28.可低温熨烫。', null, null, null, null, 'http://shop.nuotisi.com:81/lifu/R1807A96/order/2.jpg,', '{\"厚薄\":\"适中\",\"重量\":\"1100.0\",\"适用场景\":\"婚礼、宴会、摄影\",\"尺寸\":\"均码\",\"层数\":\"2.0\",\"长度\":\"150.0\",\"洗涤方法\":\"1.可手洗、干洗，不可机洗。\\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\\n3.不可漂白。\\n28.可低温熨烫。\",\"保养\":\"1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\\n4.\\n29.存放于阴凉干燥的地方。\",\"适用人群\":\"都适用\",\"适用季节\":\"四季通用\"}');
INSERT INTO cparameters VALUES ('70', '70', 'R1808A03', '立体花，蕾丝，纱', '网纱', '适中', '均码', '无', 'http://shop.nuotisi.com:81/lifu/R1808A03/FM/3.jpg,', 'http://shop.nuotisi.com:81/lifu/R1808A03/XQ/X1.jpg,http://shop.nuotisi.com:81/lifu/R1808A03/XQ/X2.jpg,', '7', '1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\n4.\n30.存放于阴凉干燥的地方。', '四季通用', '都适用', '摄影', '5.0', '', '147.0', '1.可手洗、干洗，不可机洗。\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\n3.不可漂白。\n29.可低温熨烫。', null, null, null, null, 'http://shop.nuotisi.com:81/lifu/R1808A03/order/2.jpg,', '{\"厚薄\":\"适中\",\"重量\":\"\",\"适用场景\":\"摄影\",\"尺寸\":\"均码\",\"层数\":\"5.0\",\"长度\":\"147.0\",\"洗涤方法\":\"1.可手洗、干洗，不可机洗。\\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\\n3.不可漂白。\\n29.可低温熨烫。\",\"保养\":\"1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\\n4.\\n30.存放于阴凉干燥的地方。\",\"适用人群\":\"都适用\",\"适用季节\":\"四季通用\"}');
INSERT INTO cparameters VALUES ('71', '71', 'R1808A105', '一字肩，蕾丝，立体花', '缎面', '适中', '均码', '无', 'http://shop.nuotisi.com:81/lifu/R1808A105/FM/3.jpg,', 'http://shop.nuotisi.com:81/lifu/R1808A105/XQ/X1.jpg,http://shop.nuotisi.com:81/lifu/R1808A105/XQ/X2.jpg,', '7', '1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\n4.\n31.存放于阴凉干燥的地方。', '四季通用', '都适用', '摄影', '5.0', '1250.0', '147.0', '1.可手洗、干洗，不可机洗。\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\n3.不可漂白。\n30.可低温熨烫。', null, null, null, null, 'http://shop.nuotisi.com:81/lifu/R1808A105/order/2.jpg,', '{\"厚薄\":\"适中\",\"重量\":\"1250.0\",\"适用场景\":\"摄影\",\"尺寸\":\"均码\",\"层数\":\"5.0\",\"长度\":\"147.0\",\"洗涤方法\":\"1.可手洗、干洗，不可机洗。\\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\\n3.不可漂白。\\n30.可低温熨烫。\",\"保养\":\"1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\\n4.\\n31.存放于阴凉干燥的地方。\",\"适用人群\":\"都适用\",\"适用季节\":\"四季通用\"}');
INSERT INTO cparameters VALUES ('72', '72', 'R1808A109', '一字肩，蕾丝，立体花', '雪纺 蕾丝', '适中', '均码', '无', 'http://shop.nuotisi.com:81/lifu/R1808A109/FM/3.jpg,', 'http://shop.nuotisi.com:81/lifu/R1808A109/XQ/X1.jpg,http://shop.nuotisi.com:81/lifu/R1808A109/XQ/X2.jpg,', '7', '1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\n4.\n32.存放于阴凉干燥的地方。', '四季通用', '都适用', '婚礼、宴会、摄影', '2.0', '1100.0', '150.0', '1.可手洗、干洗，不可机洗。\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\n3.不可漂白。\n31.可低温熨烫。', null, null, null, null, 'http://shop.nuotisi.com:81/lifu/R1808A109/order/2.jpg,', '{\"厚薄\":\"适中\",\"重量\":\"1100.0\",\"适用场景\":\"婚礼、宴会、摄影\",\"尺寸\":\"均码\",\"层数\":\"2.0\",\"长度\":\"150.0\",\"洗涤方法\":\"1.可手洗、干洗，不可机洗。\\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\\n3.不可漂白。\\n31.可低温熨烫。\",\"保养\":\"1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\\n4.\\n32.存放于阴凉干燥的地方。\",\"适用人群\":\"都适用\",\"适用季节\":\"四季通用\"}');
INSERT INTO cparameters VALUES ('73', '73', 'S5881', '蕾丝，一字肩，纱', '网纱', '适中', '均码', '无', 'http://shop.nuotisi.com:81/lifu/S5881/FM/3.jpg,', 'http://shop.nuotisi.com:81/lifu/S5881/XQ/X1.jpg,http://shop.nuotisi.com:81/lifu/S5881/XQ/X2.jpg,', '7', '1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\n4.\n34.存放于阴凉干燥的地方。', '四季通用', '都适用', '婚礼、宴会、摄影', '5.0', '910.0', '147.0', '1.可手洗、干洗，不可机洗。\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\n3.不可漂白。\n33.可低温熨烫。', null, null, null, null, 'http://shop.nuotisi.com:81/lifu/S5881/order/2.jpg,', '{\"厚薄\":\"适中\",\"重量\":\"910.0\",\"适用场景\":\"婚礼、宴会、摄影\",\"尺寸\":\"均码\",\"层数\":\"5.0\",\"长度\":\"147.0\",\"洗涤方法\":\"1.可手洗、干洗，不可机洗。\\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\\n3.不可漂白。\\n33.可低温熨烫。\",\"保养\":\"1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\\n4.\\n34.存放于阴凉干燥的地方。\",\"适用人群\":\"都适用\",\"适用季节\":\"四季通用\"}');
INSERT INTO cparameters VALUES ('74', '74', 'R1804A26', '蕾丝、钉珠、贴花', '素雅段', '适中', '均码', '无', 'http://shop.nuotisi.com:81/lifu/R1804A26/FM/3.jpg,', 'http://shop.nuotisi.com:81/lifu/R1804A26/XQ/X1.jpg,http://shop.nuotisi.com:81/lifu/R1804A26/XQ/X2.jpg,', '1', '1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\n4.\n87.存放于阴凉干燥的地方。', '四季通用', '都适用', '', '3.0', '450.0', '150.0', '', null, null, null, null, 'http://shop.nuotisi.com:81/lifu/R1804A26/order/2.jpg,', '{\"厚薄\":\"适中\",\"重量\":\"450.0\",\"适用场景\":\"\",\"尺寸\":\"均码\",\"层数\":\"3.0\",\"长度\":\"150.0\",\"洗涤方法\":\"\",\"保养\":\"1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\\n4.\\n87.存放于阴凉干燥的地方。\",\"适用人群\":\"都适用\",\"适用季节\":\"四季通用\"}');
INSERT INTO cparameters VALUES ('75', '75', 'E2257-2', '一字肩、蕾丝、贴花', '美国缎', '适中', '均码', '无', 'http://shop.nuotisi.com:81/lifu/E2257-2/FM/3.jpg,', 'http://shop.nuotisi.com:81/lifu/E2257-2/XQ/X1.jpg,http://shop.nuotisi.com:81/lifu/E2257-2/XQ/X2.jpg,', '1', '1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\n4.\n90.存放于阴凉干燥的地方。', '四季通用', '都适用', '', '3.0', '560.0', '150.0', '', null, null, null, null, 'http://shop.nuotisi.com:81/lifu/E2257-2/order/2.jpg,', '{\"厚薄\":\"适中\",\"重量\":\"560.0\",\"适用场景\":\"\",\"尺寸\":\"均码\",\"层数\":\"3.0\",\"长度\":\"150.0\",\"洗涤方法\":\"\",\"保养\":\"1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\\n4.\\n90.存放于阴凉干燥的地方。\",\"适用人群\":\"都适用\",\"适用季节\":\"四季通用\"}');
INSERT INTO cparameters VALUES ('76', '76', 'R1807A91', '立体花、钉珠', '大红395缎', '适中', '均码', '无', 'http://shop.nuotisi.com:81/lifu/R1807A91/FM/3.jpg,', 'http://shop.nuotisi.com:81/lifu/R1807A91/XQ/X1.jpg,http://shop.nuotisi.com:81/lifu/R1807A91/XQ/X2.jpg,', '7', '1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\n4.\n93.存放于阴凉干燥的地方。', '四季通用', '都适用', '', '2.0', '545.0', '147.0', '', null, null, null, null, 'http://shop.nuotisi.com:81/lifu/R1807A91/order/2.jpg,', '{\"厚薄\":\"适中\",\"重量\":\"545.0\",\"适用场景\":\"\",\"尺寸\":\"均码\",\"层数\":\"2.0\",\"长度\":\"147.0\",\"洗涤方法\":\"\",\"保养\":\"1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\\n4.\\n93.存放于阴凉干燥的地方。\",\"适用人群\":\"都适用\",\"适用季节\":\"四季通用\"}');
INSERT INTO cparameters VALUES ('77', '77', 'S5862-1', '贴花、钉珠、蕾丝', '蕾丝', '适中', '均码', '无', 'http://shop.nuotisi.com:81/lifu/S5862-1/FM/3.jpg,', 'http://shop.nuotisi.com:81/lifu/S5862-1/XQ/X1.jpg,http://shop.nuotisi.com:81/lifu/S5862-1/XQ/X2.jpg,', '7', '1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\n4.\n95.存放于阴凉干燥的地方。', '四季通用', '都适用', '', '2.0', '480.0', '150.0', '', null, null, null, null, 'http://shop.nuotisi.com:81/lifu/S5862-1/order/2.jpg,', '{\"厚薄\":\"适中\",\"重量\":\"480.0\",\"适用场景\":\"\",\"尺寸\":\"均码\",\"层数\":\"2.0\",\"长度\":\"150.0\",\"洗涤方法\":\"\",\"保养\":\"1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\\n4.\\n95.存放于阴凉干燥的地方。\",\"适用人群\":\"都适用\",\"适用季节\":\"四季通用\"}');
INSERT INTO cparameters VALUES ('78', '78', 'R17L2Q185', '中西结合，鱼尾、云纹、流苏', '红色素雅缎', '适中', '均码', '无', 'http://shop.nuotisi.com:81/lifu/R17L2Q185/FM/3.jpg,', 'http://shop.nuotisi.com:81/lifu/R17L2Q185/XQ/X1.jpg,http://shop.nuotisi.com:81/lifu/R17L2Q185/XQ/X2.jpg,', '7', '1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\n4.\n114.存放于阴凉干燥的地方。', '四季通用', '都适用', '', '2.0', '1.2kg', '122.0', '', null, null, null, null, 'http://shop.nuotisi.com:81/lifu/R17L2Q185/order/2.jpg,', '{\"厚薄\":\"适中\",\"重量\":\"1.2kg\",\"适用场景\":\"\",\"尺寸\":\"均码\",\"层数\":\"2.0\",\"长度\":\"122.0\",\"洗涤方法\":\"\",\"保养\":\"1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\\n4.\\n114.存放于阴凉干燥的地方。\",\"适用人群\":\"都适用\",\"适用季节\":\"四季通用\"}');
INSERT INTO cparameters VALUES ('79', '79', 'R17L2T179', '中西结合，鱼尾、云纹、流苏', '红色素雅缎', '适中', '均码', '无', 'http://shop.nuotisi.com:81/lifu/R17L2T179/FM/3.jpg,', 'http://shop.nuotisi.com:81/lifu/R17L2T179/XQ/X1.jpg,http://shop.nuotisi.com:81/lifu/R17L2T179/XQ/X2.jpg,', '7', '1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\n4.\n115.存放于阴凉干燥的地方。', '四季通用', '都适用', '', '2.0', '1.2kg', '180.0', '', null, null, null, null, 'http://shop.nuotisi.com:81/lifu/R17L2T179/order/2.jpg,', '{\"厚薄\":\"适中\",\"重量\":\"1.2kg\",\"适用场景\":\"\",\"尺寸\":\"均码\",\"层数\":\"2.0\",\"长度\":\"180.0\",\"洗涤方法\":\"\",\"保养\":\"1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\\n4.\\n115.存放于阴凉干燥的地方。\",\"适用人群\":\"都适用\",\"适用季节\":\"四季通用\"}');
INSERT INTO cparameters VALUES ('80', '80', 'S5857', '刺绣，珠绣，盘扣', '缎面', '适中', '均码', '无', 'http://shop.nuotisi.com:81/jiayi/S5857/FM/3.jpg,', 'http://shop.nuotisi.com:81/jiayi/S5857/XQ/X1.jpg,http://shop.nuotisi.com:81/jiayi/S5857/XQ/X2.jpg,', '7', '1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\n4.\n5.存放于阴凉干燥的地方。', '四季通用', '都适用', '摄影', '2.0', '1350.0', '152.0', '1.可手洗、干洗，不可机洗。\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\n3.不可漂白。\n4.可低温熨烫。', null, null, null, null, 'http://shop.nuotisi.com:81/jiayi/S5857/order/2.jpg,', '{\"厚薄\":\"适中\",\"重量\":\"1350.0\",\"适用场景\":\"摄影\",\"尺寸\":\"均码\",\"层数\":\"2.0\",\"长度\":\"152.0\",\"洗涤方法\":\"1.可手洗、干洗，不可机洗。\\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\\n3.不可漂白。\\n4.可低温熨烫。\",\"保养\":\"1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\\n4.\\n5.存放于阴凉干燥的地方。\",\"适用人群\":\"都适用\",\"适用季节\":\"四季通用\"}');
INSERT INTO cparameters VALUES ('81', '81', 'R17X5D073', '刺绣，祥云，牡丹', '缎面', '适中', '均码', '无', 'http://shop.nuotisi.com:81/jiayi/R17X5D073/FM/3.jpg,', 'http://shop.nuotisi.com:81/jiayi/R17X5D073/XQ/X1.jpg,http://shop.nuotisi.com:81/jiayi/R17X5D073/XQ/X2.jpg,http://shop.nuotisi.com:81/jiayi/R17X5D073/XQ/X3.jpg,', '7', '1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\n4.\n7.存放于阴凉干燥的地方。', '四季通用', '都适用', '摄影', '3.0', '2130.0', '150.0', '1.可手洗、干洗，不可机洗。\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\n3.不可漂白。\n6.可低温熨烫。', null, null, null, null, 'http://shop.nuotisi.com:81/jiayi/R17X5D073/order/2.jpg,', '{\"厚薄\":\"适中\",\"重量\":\"2130.0\",\"适用场景\":\"摄影\",\"尺寸\":\"均码\",\"层数\":\"3.0\",\"长度\":\"150.0\",\"洗涤方法\":\"1.可手洗、干洗，不可机洗。\\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\\n3.不可漂白。\\n6.可低温熨烫。\",\"保养\":\"1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\\n4.\\n7.存放于阴凉干燥的地方。\",\"适用人群\":\"都适用\",\"适用季节\":\"四季通用\"}');
INSERT INTO cparameters VALUES ('82', '82', 'R17X5D072', '流苏，龙凤呈祥，浮雕刺绣', '缎面', '适中', '均码', '无', 'http://shop.nuotisi.com:81/jiayi/R17X5D072/FM/3.jpg,', 'http://shop.nuotisi.com:81/jiayi/R17X5D072/XQ/X1.jpg,http://shop.nuotisi.com:81/jiayi/R17X5D072/XQ/X2.jpg,http://shop.nuotisi.com:81/jiayi/R17X5D072/XQ/X3.jpg,', '7', '1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\n4.\n8.存放于阴凉干燥的地方。', '四季通用', '都适用', '婚礼、宴会、摄影', '2.0', '120.0', '145.0', '1.可手洗、干洗，不可机洗。\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\n3.不可漂白。\n7.可低温熨烫。', null, null, null, null, 'http://shop.nuotisi.com:81/jiayi/R17X5D072/order/2.jpg,', '{\"厚薄\":\"适中\",\"重量\":\"120.0\",\"适用场景\":\"婚礼、宴会、摄影\",\"尺寸\":\"均码\",\"层数\":\"2.0\",\"长度\":\"145.0\",\"洗涤方法\":\"1.可手洗、干洗，不可机洗。\\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\\n3.不可漂白。\\n7.可低温熨烫。\",\"保养\":\"1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\\n4.\\n8.存放于阴凉干燥的地方。\",\"适用人群\":\"都适用\",\"适用季节\":\"四季通用\"}');
INSERT INTO cparameters VALUES ('83', '83', 'R18H5Q233', '祥云，凤，闽绣工艺', '缎面', '适中', '均码', '无', 'http://shop.nuotisi.com:81/jiayi/R18H5Q233/FM/3.jpg,', 'http://shop.nuotisi.com:81/jiayi/R18H5Q233/XQ/X1.jpg,http://shop.nuotisi.com:81/jiayi/R18H5Q233/XQ/X2.jpg,http://shop.nuotisi.com:81/jiayi/R18H5Q233/XQ/X3.jpg,', '7', '1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\n4.\n9.存放于阴凉干燥的地方。', '四季通用', '都适用', '摄影', '2.0', '1573.0', '147.0', '1.可手洗、干洗，不可机洗。\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\n3.不可漂白。\n8.可低温熨烫。', null, null, null, null, 'http://shop.nuotisi.com:81/jiayi/R18H5Q233/order/2.jpg,', '{\"厚薄\":\"适中\",\"重量\":\"1573.0\",\"适用场景\":\"摄影\",\"尺寸\":\"均码\",\"层数\":\"2.0\",\"长度\":\"147.0\",\"洗涤方法\":\"1.可手洗、干洗，不可机洗。\\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\\n3.不可漂白。\\n8.可低温熨烫。\",\"保养\":\"1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\\n4.\\n9.存放于阴凉干燥的地方。\",\"适用人群\":\"都适用\",\"适用季节\":\"四季通用\"}');
INSERT INTO cparameters VALUES ('84', '84', 'R1802A01', '闽绣，凤凰，刺绣', '缎面', '适中', '均码', '无', 'http://shop.nuotisi.com:81/jiayi/R1802A01/FM/3.jpg,', 'http://shop.nuotisi.com:81/jiayi/R1802A01/XQ/X1.jpg,http://shop.nuotisi.com:81/jiayi/R1802A01/XQ/X2.jpg,http://shop.nuotisi.com:81/jiayi/R1802A01/XQ/X3.jpg,', '7', '1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\n4.\n10.存放于阴凉干燥的地方。', '四季通用', '都适用', '摄影', '3.0', '1320.0', '147.0', '1.可手洗、干洗，不可机洗。\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\n3.不可漂白。\n9.可低温熨烫。', null, null, null, null, 'http://shop.nuotisi.com:81/jiayi/R1802A01/order/2.jpg,', '{\"厚薄\":\"适中\",\"重量\":\"1320.0\",\"适用场景\":\"摄影\",\"尺寸\":\"均码\",\"层数\":\"3.0\",\"长度\":\"147.0\",\"洗涤方法\":\"1.可手洗、干洗，不可机洗。\\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\\n3.不可漂白。\\n9.可低温熨烫。\",\"保养\":\"1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\\n4.\\n10.存放于阴凉干燥的地方。\",\"适用人群\":\"都适用\",\"适用季节\":\"四季通用\"}');
INSERT INTO cparameters VALUES ('85', '85', 'R1803A06', '凤凰，刺绣，车骨绣', '缎面', '适中', '均码', '无', 'http://shop.nuotisi.com:81/jiayi/R1803A06/FM/3.jpg,', 'http://shop.nuotisi.com:81/jiayi/R1803A06/XQ/X1.jpg,http://shop.nuotisi.com:81/jiayi/R1803A06/XQ/X2.jpg,http://shop.nuotisi.com:81/jiayi/R1803A06/XQ/X3.jpg,', '7', '1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\n4.\n11.存放于阴凉干燥的地方。', '四季通用', '都适用', '婚礼、宴会、摄影', '2.0', '920.0', '145.0', '1.可手洗、干洗，不可机洗。\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\n3.不可漂白。\n10.可低温熨烫。', null, null, null, null, 'http://shop.nuotisi.com:81/jiayi/R1803A06/order/2.jpg,', '{\"厚薄\":\"适中\",\"重量\":\"920.0\",\"适用场景\":\"婚礼、宴会、摄影\",\"尺寸\":\"均码\",\"层数\":\"2.0\",\"长度\":\"145.0\",\"洗涤方法\":\"1.可手洗、干洗，不可机洗。\\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\\n3.不可漂白。\\n10.可低温熨烫。\",\"保养\":\"1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\\n4.\\n11.存放于阴凉干燥的地方。\",\"适用人群\":\"都适用\",\"适用季节\":\"四季通用\"}');
INSERT INTO cparameters VALUES ('86', '86', 'R18X5D182', '牡丹，凤凰，流苏，闽绣', '缎面', '适中', '均码', '无', 'http://shop.nuotisi.com:81/jiayi/R18X5D182/FM/3.jpg,', 'http://shop.nuotisi.com:81/jiayi/R18X5D182/XQ/X1.jpg,http://shop.nuotisi.com:81/jiayi/R18X5D182/XQ/X2.jpg,http://shop.nuotisi.com:81/jiayi/R18X5D182/XQ/X3.jpg,', '7', '1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\n4.\n12.存放于阴凉干燥的地方。', '四季通用', '都适用', '摄影', '2.0', '2230.0', '145.0', '1.可手洗、干洗，不可机洗。\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\n3.不可漂白。\n11.可低温熨烫。', null, null, null, null, 'http://shop.nuotisi.com:81/jiayi/R18X5D182/order/2.jpg,', '{\"厚薄\":\"适中\",\"重量\":\"2230.0\",\"适用场景\":\"摄影\",\"尺寸\":\"均码\",\"层数\":\"2.0\",\"长度\":\"145.0\",\"洗涤方法\":\"1.可手洗、干洗，不可机洗。\\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\\n3.不可漂白。\\n11.可低温熨烫。\",\"保养\":\"1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\\n4.\\n12.存放于阴凉干燥的地方。\",\"适用人群\":\"都适用\",\"适用季节\":\"四季通用\"}');
INSERT INTO cparameters VALUES ('87', '87', 'S5907', '祥云，牡丹，刺绣', '缎面', '适中', '均码', '无', 'http://shop.nuotisi.com:81/jiayi/S5907/FM/3.jpg,', 'http://shop.nuotisi.com:81/jiayi/S5907/XQ/X1.jpg,http://shop.nuotisi.com:81/jiayi/S5907/XQ/X2.jpg,http://shop.nuotisi.com:81/jiayi/S5907/XQ/X3.jpg,', '7', '1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\n4.\n13.存放于阴凉干燥的地方。', '四季通用', '都适用', '摄影', '3.0', '2510.0', '152.0', '1.可手洗、干洗，不可机洗。\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\n3.不可漂白。\n12.可低温熨烫。', null, null, null, null, 'http://shop.nuotisi.com:81/jiayi/S5907/order/2.jpg,', '{\"厚薄\":\"适中\",\"重量\":\"2510.0\",\"适用场景\":\"摄影\",\"尺寸\":\"均码\",\"层数\":\"3.0\",\"长度\":\"152.0\",\"洗涤方法\":\"1.可手洗、干洗，不可机洗。\\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\\n3.不可漂白。\\n12.可低温熨烫。\",\"保养\":\"1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\\n4.\\n13.存放于阴凉干燥的地方。\",\"适用人群\":\"都适用\",\"适用季节\":\"四季通用\"}');
INSERT INTO cparameters VALUES ('88', '88', 'R18X5Q234', '闽绣，如意，流苏', '缎面', '适中', '均码', '无', 'http://shop.nuotisi.com:81/jiayi/R18X5Q234/FM/3.jpg,', 'http://shop.nuotisi.com:81/jiayi/R18X5Q234/XQ/X1.jpg,http://shop.nuotisi.com:81/jiayi/R18X5Q234/XQ/X2.jpg,http://shop.nuotisi.com:81/jiayi/R18X5Q234/XQ/X3.jpg,', '7', '1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\n4.\n14.存放于阴凉干燥的地方。', '四季通用', '都适用', '婚礼、宴会、摄影', '3.0', '1530.0', '147.0', '1.可手洗、干洗，不可机洗。\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\n3.不可漂白。\n13.可低温熨烫。', null, null, null, null, 'http://shop.nuotisi.com:81/jiayi/R18X5Q234/order/2.jpg,', '{\"厚薄\":\"适中\",\"重量\":\"1530.0\",\"适用场景\":\"婚礼、宴会、摄影\",\"尺寸\":\"均码\",\"层数\":\"3.0\",\"长度\":\"147.0\",\"洗涤方法\":\"1.可手洗、干洗，不可机洗。\\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\\n3.不可漂白。\\n13.可低温熨烫。\",\"保养\":\"1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\\n4.\\n14.存放于阴凉干燥的地方。\",\"适用人群\":\"都适用\",\"适用季节\":\"四季通用\"}');
INSERT INTO cparameters VALUES ('89', '89', 'R17X5Q671', '刺绣，镶边，凤凰', '缎面、纱', '适中', '均码', '无', 'http://shop.nuotisi.com:81/jiayi/R17X5Q671/FM/3.jpg,', 'http://shop.nuotisi.com:81/jiayi/R17X5Q671/XQ/X1.jpg,http://shop.nuotisi.com:81/jiayi/R17X5Q671/XQ/X2.jpg,http://shop.nuotisi.com:81/jiayi/R17X5Q671/XQ/X3.jpg,', '7', '1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\n4.\n15.存放于阴凉干燥的地方。', '四季通用', '都适用', '摄影', '3.0', '850.0', '147.0', '1.可手洗、干洗，不可机洗。\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\n3.不可漂白。\n14.可低温熨烫。', null, null, null, null, 'http://shop.nuotisi.com:81/jiayi/R17X5Q671/order/2.jpg,', '{\"厚薄\":\"适中\",\"重量\":\"850.0\",\"适用场景\":\"摄影\",\"尺寸\":\"均码\",\"层数\":\"3.0\",\"长度\":\"147.0\",\"洗涤方法\":\"1.可手洗、干洗，不可机洗。\\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\\n3.不可漂白。\\n14.可低温熨烫。\",\"保养\":\"1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\\n4.\\n15.存放于阴凉干燥的地方。\",\"适用人群\":\"都适用\",\"适用季节\":\"四季通用\"}');
INSERT INTO cparameters VALUES ('90', '90', 'X5Q1201', '闽绣，刺绣，凤凰', '缎面', '适中', '均码', '无', 'http://shop.nuotisi.com:81/jiayi/X5Q1201/FM/3.jpg,', 'http://shop.nuotisi.com:81/jiayi/X5Q1201/XQ/X1.jpg,http://shop.nuotisi.com:81/jiayi/X5Q1201/XQ/X2.jpg,http://shop.nuotisi.com:81/jiayi/X5Q1201/XQ/X3.jpg,', '7', '1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\n4.\n16.存放于阴凉干燥的地方。', '四季通用', '都适用', '摄影', '3.0', '1220.0', '145.0', '1.可手洗、干洗，不可机洗。\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\n3.不可漂白。\n15.可低温熨烫。', null, null, null, null, 'http://shop.nuotisi.com:81/jiayi/X5Q1201/order/2.jpg,', '{\"厚薄\":\"适中\",\"重量\":\"1220.0\",\"适用场景\":\"摄影\",\"尺寸\":\"均码\",\"层数\":\"3.0\",\"长度\":\"145.0\",\"洗涤方法\":\"1.可手洗、干洗，不可机洗。\\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\\n3.不可漂白。\\n15.可低温熨烫。\",\"保养\":\"1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\\n4.\\n16.存放于阴凉干燥的地方。\",\"适用人群\":\"都适用\",\"适用季节\":\"四季通用\"}');
INSERT INTO cparameters VALUES ('91', '91', 'R18X5Q181', '盘扣，刺绣，凤凰', '缎面', '适中', '均码', '无', 'http://shop.nuotisi.com:81/jiayi/R18X5Q181/FM/3.jpg,', 'http://shop.nuotisi.com:81/jiayi/R18X5Q181/XQ/X1.jpg,http://shop.nuotisi.com:81/jiayi/R18X5Q181/XQ/X2.jpg,http://shop.nuotisi.com:81/jiayi/R18X5Q181/XQ/X3.jpg,', '7', '1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\n4.\n17.存放于阴凉干燥的地方。', '四季通用', '都适用', '婚礼、宴会、摄影', '2.0', '1320.0', '145.0', '1.可手洗、干洗，不可机洗。\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\n3.不可漂白。\n16.可低温熨烫。', null, null, null, null, 'http://shop.nuotisi.com:81/jiayi/R18X5Q181/order/2.jpg,', '{\"厚薄\":\"适中\",\"重量\":\"1320.0\",\"适用场景\":\"婚礼、宴会、摄影\",\"尺寸\":\"均码\",\"层数\":\"2.0\",\"长度\":\"145.0\",\"洗涤方法\":\"1.可手洗、干洗，不可机洗。\\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\\n3.不可漂白。\\n16.可低温熨烫。\",\"保养\":\"1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\\n4.\\n17.存放于阴凉干燥的地方。\",\"适用人群\":\"都适用\",\"适用季节\":\"四季通用\"}');
INSERT INTO cparameters VALUES ('92', '92', 'R18X5T183', '凤凰，刺绣，闽绣', '缎面', '适中', '均码', '无', 'http://shop.nuotisi.com:81/jiayi/R18X5T183/FM/3.jpg,', 'http://shop.nuotisi.com:81/jiayi/R18X5T183/XQ/X1.jpg,http://shop.nuotisi.com:81/jiayi/R18X5T183/XQ/X2.jpg,http://shop.nuotisi.com:81/jiayi/R18X5T183/XQ/X3.jpg,', '7', '1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\n4.\n18.存放于阴凉干燥的地方。', '四季通用', '都适用', '摄影', '2.0', '2710.0', '147.0', '1.可手洗、干洗，不可机洗。\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\n3.不可漂白。\n17.可低温熨烫。', null, null, null, null, 'http://shop.nuotisi.com:81/jiayi/R18X5T183/order/2.jpg,', '{\"厚薄\":\"适中\",\"重量\":\"2710.0\",\"适用场景\":\"摄影\",\"尺寸\":\"均码\",\"层数\":\"2.0\",\"长度\":\"147.0\",\"洗涤方法\":\"1.可手洗、干洗，不可机洗。\\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\\n3.不可漂白。\\n17.可低温熨烫。\",\"保养\":\"1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\\n4.\\n18.存放于阴凉干燥的地方。\",\"适用人群\":\"都适用\",\"适用季节\":\"四季通用\"}');
INSERT INTO cparameters VALUES ('93', '93', 'R1803A06', '闽绣、刺绣', '395缎', '适中', '均码', '无', 'http://shop.nuotisi.com:81/jiayi/R1803A06/FM/3.jpg,', 'http://shop.nuotisi.com:81/jiayi/R1803A06/XQ/X1.jpg,http://shop.nuotisi.com:81/jiayi/R1803A06/XQ/X2.jpg,http://shop.nuotisi.com:81/jiayi/R1803A06/XQ/X3.jpg,', '7', '1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\n4.\n111.存放于阴凉干燥的地方。', '四季通用', '都适用', '', '2.0', '750.0', '147.0', '', null, null, null, null, 'http://shop.nuotisi.com:81/jiayi/R1803A06/order/2.jpg,', '{\"厚薄\":\"适中\",\"重量\":\"750.0\",\"适用场景\":\"\",\"尺寸\":\"均码\",\"层数\":\"2.0\",\"长度\":\"147.0\",\"洗涤方法\":\"\",\"保养\":\"1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\\n4.\\n111.存放于阴凉干燥的地方。\",\"适用人群\":\"都适用\",\"适用季节\":\"四季通用\"}');
INSERT INTO cparameters VALUES ('94', '94', 'S5907', '中国风图案、闽綉、刺绣', '大红395缎、大红里布', '适中', '均码', '无', 'http://shop.nuotisi.com:81/jiayi/S5907/FM/3.jpg,', 'http://shop.nuotisi.com:81/jiayi/S5907/XQ/X1.jpg,http://shop.nuotisi.com:81/jiayi/S5907/XQ/X2.jpg,http://shop.nuotisi.com:81/jiayi/S5907/XQ/X3.jpg,', '26', '1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\n4.\n21.存放于阴凉干燥的地方。', '四季通用', '都适用', '婚礼、宴会、摄影', '2.0', '2500.0', '147.0', '1.可手洗、干洗，不可机洗。\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\n3.不可漂白。\n20.可低温熨烫。', null, null, null, null, 'http://shop.nuotisi.com:81/jiayi/S5907/order/2.jpg,', '{\"厚薄\":\"适中\",\"重量\":\"2500.0\",\"适用场景\":\"婚礼、宴会、摄影\",\"尺寸\":\"均码\",\"层数\":\"2.0\",\"长度\":\"147.0\",\"洗涤方法\":\"1.可手洗、干洗，不可机洗。\\n2.可由温和，中性清洁剂水中清洗，不可热水浸泡。\\n3.不可漂白。\\n20.可低温熨烫。\",\"保养\":\"1.最好的方法是把婚纱放入拌由温和，中性清洁剂水中清洗，不可机洗或热水浸泡。\\n2.为保持原色泽，请将婚纱礼服与深颜色衣服分开洗涤。\\n3.晾晒时将衣物拉平并将反面朝外、严禁暴晒。\\n4.\\n21.存放于阴凉干燥的地方。\",\"适用人群\":\"都适用\",\"适用季节\":\"四季通用\"}');

-- ----------------------------
-- Table structure for `evaluate`
-- ----------------------------
DROP TABLE IF EXISTS `evaluate`;
CREATE TABLE `evaluate` (
  `evaluate_id` int(11) NOT NULL AUTO_INCREMENT,
  `evaluate_acount` varchar(255) DEFAULT NULL COMMENT '评价内容',
  `evaluate_Time` varchar(255) NOT NULL COMMENT '评价时间',
  `evaluate_userid` int(11) NOT NULL COMMENT '用户编号',
  `evaluate_orderid` int(11) NOT NULL COMMENT '订单编号',
  `evaluate_xingji` int(11) DEFAULT NULL COMMENT '评价星级',
  PRIMARY KEY (`evaluate_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of evaluate
-- ----------------------------

-- ----------------------------
-- Table structure for `express`
-- ----------------------------
DROP TABLE IF EXISTS `express`;
CREATE TABLE `express` (
  `express_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `express_name` varchar(255) NOT NULL COMMENT '快递公司名称',
  `express_price` double NOT NULL COMMENT '快递费用',
  `express_default` int(11) NOT NULL DEFAULT 0 COMMENT '默认使用快递模板',
  `shop_id` int(11) NOT NULL COMMENT '商铺id',
  PRIMARY KEY (`express_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of express
-- ----------------------------

-- ----------------------------
-- Table structure for `giveback`
-- ----------------------------
DROP TABLE IF EXISTS `giveback`;
CREATE TABLE `giveback` (
  `giveback_id` int(11) NOT NULL COMMENT '归还id',
  `giveback_time` varchar(255) NOT NULL COMMENT '归还时间',
  `giveback_address` varchar(255) NOT NULL COMMENT '归还地址',
  `giveback_overtime` varchar(255) DEFAULT NULL COMMENT '归还完成时间',
  `giveback_order_id` int(11) NOT NULL COMMENT '归还订单id',
  `giveback_commodity_id` int(11) DEFAULT NULL COMMENT '归还商品id',
  `giveback_kuaidi` varchar(255) DEFAULT NULL COMMENT '归还快递单号',
  `giveback_type` varchar(255) NOT NULL COMMENT '归还方式【在线归还 或 邮寄归还】',
  `giveback_kuaidi_name` varchar(255) DEFAULT NULL COMMENT '归还快递公司名称',
  PRIMARY KEY (`giveback_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of giveback
-- ----------------------------

-- ----------------------------
-- Table structure for `leave_word`
-- ----------------------------
DROP TABLE IF EXISTS `leave_word`;
CREATE TABLE `leave_word` (
  `leave_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '留言编号',
  `user_id` int(11) NOT NULL COMMENT '用户编号',
  `commodity_id` int(11) NOT NULL COMMENT '商品编号',
  `leave_content` varchar(255) NOT NULL COMMENT '留言类容',
  `leave_xingji` varchar(255) DEFAULT NULL COMMENT '星级评价',
  PRIMARY KEY (`leave_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of leave_word
-- ----------------------------

-- ----------------------------
-- Table structure for `oc`
-- ----------------------------
DROP TABLE IF EXISTS `oc`;
CREATE TABLE `oc` (
  `oc_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `oc_order_id` int(11) NOT NULL COMMENT '外键订单编号',
  `oc_name` varchar(255) NOT NULL COMMENT '订单商品名称',
  `oc_commodity_id` int(11) NOT NULL COMMENT '外键商品编号',
  `oc_size` char(10) NOT NULL COMMENT '订单商品的大小',
  `oc_color` varchar(255) NOT NULL COMMENT '订单商品的颜色',
  `oc_count` int(11) NOT NULL COMMENT '订单商品的数量',
  `oc_tptalprices` double DEFAULT NULL COMMENT '订单商品的总价',
  `oc_yajin` double DEFAULT NULL COMMENT '订单租赁商品的押金',
  `oc_tupian` varchar(255) NOT NULL COMMENT '商品的图片',
  `oc_lease_time` varchar(255) DEFAULT NULL COMMENT '商品的租赁时间',
  `oc_lease_overtime` varchar(255) DEFAULT NULL COMMENT '商品的结束租赁时间',
  `oc_shop_id` int(11) DEFAULT NULL COMMENT '商品的门店',
  PRIMARY KEY (`oc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of oc
-- ----------------------------

-- ----------------------------
-- Table structure for `orderss`
-- ----------------------------
DROP TABLE IF EXISTS `orderss`;
CREATE TABLE `orderss` (
  `order_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '订单编号',
  `user_id` int(11) NOT NULL COMMENT '用户编号',
  `order_type` int(11) NOT NULL COMMENT '购物类型【0为租赁，1为购买】',
  `order_name` varchar(255) NOT NULL COMMENT '订单名字',
  `order_lease_guihuan_time` varchar(255) DEFAULT NULL COMMENT '订单归还时间',
  `order_lease_guihuantype` varchar(255) DEFAULT NULL COMMENT '订单归还方式',
  `order_kuaidifei` double DEFAULT NULL COMMENT '订单快递费用',
  `order_peisong` varchar(255) DEFAULT '' COMMENT '订单配送方式',
  `order_fapiao` int(11) DEFAULT NULL COMMENT '订单发票 【0 无订单 1代表增值发票】',
  `order_fukuan_time` varchar(255) DEFAULT NULL COMMENT '订单付款时间',
  `order_fahuo_time` varchar(255) DEFAULT NULL COMMENT '订单发货时间',
  `order_guihuan_address` varchar(255) DEFAULT NULL COMMENT '订单归还地址',
  `order_status` int(11) DEFAULT NULL COMMENT '订单购买状态【0待付款，1待发货，2待收货，3已收货，4退货中，6退款完成，7订单完成】',
  `order_lease_status` int(11) DEFAULT NULL COMMENT '订单租赁状态【0待付款，1待发货，2待收货，3待退还，4待品检，5 退还中, 6退款中，7退款完成，8退还完成，9订单完成】',
  `order_time` varchar(255) NOT NULL COMMENT '订单创建时间',
  `order_address` varchar(255) NOT NULL COMMENT '订单的收货地址',
  `order_phone` varchar(255) NOT NULL COMMENT '订单的联系人电话',
  `order_user_name` varchar(255) NOT NULL COMMENT '订单的联系人',
  `order_zuli_time` varchar(255) DEFAULT NULL COMMENT '商品开始租赁时间',
  `order_zuli_overtime` varchar(255) DEFAULT '' COMMENT '商品结束租赁时间',
  `order_total_amount` double NOT NULL COMMENT '订单的总价',
  `order_tracking_number` varchar(255) DEFAULT '' COMMENT '快递单号',
  `order_shop_name` varchar(255) DEFAULT '' COMMENT '订单商铺id',
  `order_zhifupingtai` char(10) DEFAULT NULL COMMENT '订单支付平台',
  `order_jiaoyi_number` varchar(255) DEFAULT NULL COMMENT '交易凭证号',
  `order_ShiJiFuKuan` double DEFAULT NULL COMMENT '订单实际付款金额',
  PRIMARY KEY (`order_id`,`order_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of orderss
-- ----------------------------

-- ----------------------------
-- Table structure for `order_lengthen`
-- ----------------------------
DROP TABLE IF EXISTS `order_lengthen`;
CREATE TABLE `order_lengthen` (
  `lengthen_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '延长表的id',
  `lengthen_time` varchar(255) NOT NULL COMMENT '创建延长的时间',
  `lengthen_order_time` varchar(255) NOT NULL COMMENT '延长订单时间',
  `order_id` int(11) NOT NULL COMMENT '订单编号',
  `lengthen_status` int(11) NOT NULL COMMENT '延长状态【0未付款 1已付款】',
  PRIMARY KEY (`lengthen_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of order_lengthen
-- ----------------------------

-- ----------------------------
-- Table structure for `order_message`
-- ----------------------------
DROP TABLE IF EXISTS `order_message`;
CREATE TABLE `order_message` (
  `message_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '订单留言编号',
  `message_name` varchar(255) DEFAULT '' COMMENT '订单留言类容',
  `order_id` int(11) DEFAULT NULL COMMENT '订单编号',
  PRIMARY KEY (`message_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of order_message
-- ----------------------------

-- ----------------------------
-- Table structure for `pinlei`
-- ----------------------------
DROP TABLE IF EXISTS `pinlei`;
CREATE TABLE `pinlei` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `pinlei_tier_name` varchar(255) DEFAULT NULL COMMENT '品类第n层的名字',
  `pinlei_tier_id` int(11) DEFAULT NULL COMMENT '品类的层数',
  `commodity_category_id` int(11) DEFAULT NULL COMMENT '品类id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pinlei
-- ----------------------------
INSERT INTO pinlei VALUES ('3', '毛领大衣', '0', '2');
INSERT INTO pinlei VALUES ('4', '皮衣', '1', '2');
INSERT INTO pinlei VALUES ('5', '高领', '2', '2');
INSERT INTO pinlei VALUES ('6', '毛领大衣', '0', '3');
INSERT INTO pinlei VALUES ('7', '皮衣', '1', '3');
INSERT INTO pinlei VALUES ('8', '高领', '2', '3');
INSERT INTO pinlei VALUES ('9', '毛领大衣', '0', '4');
INSERT INTO pinlei VALUES ('10', '皮衣', '1', '4');
INSERT INTO pinlei VALUES ('11', '高领', '2', '4');

-- ----------------------------
-- Table structure for `refund`
-- ----------------------------
DROP TABLE IF EXISTS `refund`;
CREATE TABLE `refund` (
  `refund_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '退款id',
  `refund_order_id` int(11) NOT NULL COMMENT '退款订单编号',
  `fefund_number` varchar(255) DEFAULT NULL COMMENT '退款编号',
  `fefund_cause` varchar(255) NOT NULL COMMENT '退款原因',
  `fefund_time` varchar(255) NOT NULL COMMENT '退款时间',
  `fefund_status` int(11) NOT NULL COMMENT '退款状态【0 退款处理中 1退款结束】',
  `fefund_user_id` int(11) NOT NULL COMMENT '退款用户',
  `fefund_succeed_time` varchar(255) DEFAULT '' COMMENT '退款成功日期',
  `fefund_price` double DEFAULT NULL COMMENT '退款金额',
  `refund_describe` varchar(255) DEFAULT '',
  PRIMARY KEY (`refund_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of refund
-- ----------------------------

-- ----------------------------
-- Table structure for `shop`
-- ----------------------------
DROP TABLE IF EXISTS `shop`;
CREATE TABLE `shop` (
  `shop_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '商铺编号',
  `shop_number` varchar(255) NOT NULL COMMENT '商品编号',
  `shop_name` varchar(255) NOT NULL COMMENT '商铺名称',
  `shop_boss` varchar(255) NOT NULL COMMENT '商品创建人',
  `shop_address` varchar(255) NOT NULL COMMENT '商品地址',
  `shop_phone` varchar(255) NOT NULL COMMENT '商铺联系人电话',
  `shop_linkman` varchar(255) NOT NULL COMMENT '商铺联系人',
  `shop_PV` int(11) DEFAULT NULL COMMENT '商铺访问量',
  `shop_logo` varchar(255) DEFAULT NULL COMMENT '商铺logo',
  `shop_jieshao` varchar(255) DEFAULT NULL COMMENT '商铺介绍',
  `shop_create_time` varchar(255) NOT NULL COMMENT '商铺创建时间',
  `shop_admin_email` varchar(255) DEFAULT NULL COMMENT '店铺管理员邮箱',
  PRIMARY KEY (`shop_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of shop
-- ----------------------------
INSERT INTO shop VALUES ('1', '', '万幸商店', 'xxx老', 'xxx区xxx号', '123454645', '张xx', null, null, null, '', null);
INSERT INTO shop VALUES ('2', '', '龙兴商店', 'xxx某', 'xxx区xxx号', '546456', '张xx', null, null, null, '', null);
INSERT INTO shop VALUES ('3', '', '汇合商店', 'xxx料', 'xxx区xxx号', '546456', '张xx', null, null, null, '', null);

-- ----------------------------
-- Table structure for `staff`
-- ----------------------------
DROP TABLE IF EXISTS `staff`;
CREATE TABLE `staff` (
  `staff_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '员工id',
  `staff_name` varchar(255) NOT NULL COMMENT '员工姓名',
  `staff_account` varchar(255) NOT NULL COMMENT '员工账号',
  `staff_pwd` varchar(255) NOT NULL COMMENT '员工密码',
  `staff_contact_way` varchar(255) NOT NULL COMMENT '员工联系方式',
  `staff_identity` varchar(255) NOT NULL COMMENT '员工身份',
  `staff_root` varchar(255) NOT NULL COMMENT '员工权限',
  PRIMARY KEY (`staff_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of staff
-- ----------------------------

-- ----------------------------
-- Table structure for `user`
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户编号',
  `user_member_id` varchar(255) DEFAULT NULL COMMENT '会员编号',
  `user_name` varchar(255) DEFAULT NULL COMMENT '用户昵称',
  `user_account` varchar(255) DEFAULT NULL COMMENT '用户账号',
  `user_pwd` varchar(255) DEFAULT NULL COMMENT '用户密码',
  `user_pwd_salt` varchar(255) DEFAULT NULL COMMENT '用户密码加密盐',
  `user_phone` varchar(255) DEFAULT NULL COMMENT '手机号',
  `user_sex` char(2) DEFAULT NULL COMMENT '用户性别',
  `user_portrait` varchar(255) DEFAULT NULL COMMENT '用户头像地址',
  `user_create_time` varchar(255) NOT NULL COMMENT '用户注册时间',
  `user_up_time` varchar(255) NOT NULL COMMENT '用户上次登录时间',
  `user_emil` varchar(255) DEFAULT NULL COMMENT '用户邮箱',
  `user_qq` varchar(255) DEFAULT NULL COMMENT '用户关联qq',
  `user_wx` varchar(255) DEFAULT NULL COMMENT '用户关联微信',
  `user_zfb` varchar(255) DEFAULT NULL COMMENT '用户关联支付宝',
  `user_login_day` int(11) DEFAULT 1 COMMENT '用户连续登陆天数',
  `user_record_time` varchar(255) DEFAULT NULL COMMENT '记录时间',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO user VALUES ('1', null, '12344557788', null, 'p/Syc6zP/AAVCCMGhXr7HQ==', '1054122786887300', '12344557788', null, null, '2019-01-07 15:24:39', '2019-01-07 16:43:40', null, null, null, null, '1', null);
INSERT INTO user VALUES ('2', null, '17791729287', null, 'fPaNqvflg/CUza5Bb4Omig==', '1004007489569853', '17791729287', null, null, '2019-01-11 10:19:10', '2019-01-14 17:51:48', null, null, null, null, '1', null);

-- ----------------------------
-- Table structure for `userfavorite`
-- ----------------------------
DROP TABLE IF EXISTS `userfavorite`;
CREATE TABLE `userfavorite` (
  `favorite_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '收藏夹编号',
  `user_id` int(11) NOT NULL COMMENT '用户信息',
  `commodity_id` int(11) NOT NULL COMMENT '商品信息',
  `favorite_type` int(11) DEFAULT NULL COMMENT '收藏夹类型【1为购买类型，0为租赁类型】',
  `commodity_type` varchar(255) DEFAULT '' COMMENT '收藏商品类别',
  PRIMARY KEY (`favorite_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of userfavorite
-- ----------------------------
INSERT INTO userfavorite VALUES ('1', '2', '1', null, '婚纱');
