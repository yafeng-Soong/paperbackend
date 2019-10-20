
-- 更新paper表结构
DROP TABLE IF EXISTS `paper`;
CREATE TABLE `paper`.`paper` (
    `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
    `name` varchar(100) NOT NULL DEFAULT '' COMMENT '论文名称',
    `publisher_email` varchar(50) NOT NULL DEFAULT '' COMMENT '提交论文的用户email',
    `keyword` varchar(200) NOT NULL DEFAULT '' COMMENT '论文关键字',
    `summary` varchar(1024) NOT NULL DEFAULT '' COMMENT '论文概要',
    `file_path` varchar(200) NOT NULL DEFAULT '' COMMENT '文件存储路径',
    `pay_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '支付状态 0未支付 1已支付',
    `check_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '审核状态 0待审核 1待修改 2已通过',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    PRIMARY KEY(`id`),
    UNIQUE KEY `publisher_email` (`publisher_email`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT '论文记录';

-- 更新操作表结构
