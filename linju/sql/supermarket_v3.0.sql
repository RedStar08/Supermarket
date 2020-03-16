/*
MySQL Code
Host           : localhost:3306
Database       : supermarket
Target Server Type    : MYSQL
Date: 2020-02-02 22:22:22
          ID varchar(100)
备注：0表示商品ID      000001
      1表示员工ID      100001
      2表示会员ID      200001
      3表示供应商ID    300001
      4表示仓库ID      400001
*/
SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- **********商品表************
-- Table structure for tb_goods
-- ----------------------------
DROP TABLE IF EXISTS `tb_goods`;
CREATE TABLE `tb_goods` (
  `goodsID` varchar(100) NOT NULL COMMENT '商品编号',
  `goodsName` varchar(100) NOT NULL COMMENT '商品名称',
  `goodsPrice` float(2)  NOT NULL COMMENT '商品价格',
  `goodsType` varchar(100) NOT NULL COMMENT '商品类别',
  `goodsSpecs` varchar(100) NOT NULL COMMENT '商品规格',
  `goodsSave` int NOT NULL COMMENT '保质期',
  `note` varchar(1000) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`goodsID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商品表';

-- ----------------------------
-- **********供应商表**********
-- Table structure for tb_supplier
-- ----------------------------
DROP TABLE IF EXISTS `tb_supplier`;
CREATE TABLE `tb_supplier` (
  `supplierID` varchar(100) NOT NULL COMMENT '供货商编号',
  `supplierName` varchar(100) NOT NULL COMMENT '供货商名称',
  `supplierManager` varchar(100) NOT NULL COMMENT '负责人',
  `supplierPhone` varchar(100) NOT NULL COMMENT '联系方式',
  `supplierAddress` varchar(100) NOT NULL COMMENT '地址',
  `note` varchar(1000) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`supplierID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='供应商表';

-- ----------------------------
-- **********生产表**********
-- Table structure for tb_produce
-- ----------------------------
DROP TABLE IF EXISTS `tb_produce`;
CREATE TABLE `tb_produce` (
  `goodsID` varchar(100) NOT NULL COMMENT '商品编号',
  `supplierID` varchar(100) NOT NULL COMMENT '供货商编号',
  `produceID` varchar(100) NOT NULL COMMENT '生产批号',
  `note` varchar(1000) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`produceID`, `supplierID`, `goodsID`),
  FOREIGN KEY (`goodsID`) REFERENCES `tb_goods` (`goodsID`),
  FOREIGN KEY (`supplierID`) REFERENCES `tb_supplier` (`supplierID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='生产明细';

-- ----------------------------
-- *********商品信息***********
-- Table structure for tb_goodinfo
-- ----------------------------
DROP TABLE IF EXISTS `tb_goodinfo`;
CREATE TABLE `tb_goodinfo` (
  `goodsID` varchar(100) NOT NULL COMMENT '商品编号',
  `supplierID` varchar(100) NOT NULL COMMENT '供货商编号',
  `produceID` varchar(100) NOT NULL COMMENT '生产批号', 
  `produceDate` date NOT NULL COMMENT '生产日期',
  `produceArea` varchar(100) NOT NULL COMMENT'生产地址',
  `note` varchar(1000) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`goodsID`, `supplierID`, `produceID`),
  FOREIGN KEY (`goodsID`) REFERENCES `tb_goods` (`goodsID`),
  FOREIGN KEY (`supplierID`) REFERENCES `tb_supplier` (`supplierID`),
  FOREIGN KEY (`produceID`) REFERENCES `tb_produce` (`produceID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商品明细';

-- ----------------------------
-- **********促销表************
-- Table structure for tb_discount
-- ----------------------------
DROP TABLE IF EXISTS `tb_discount`;
CREATE TABLE `tb_discount` (
  `goodsID` varchar(100) NOT NULL COMMENT '商品编号',
  `produceID` varchar(100) NOT NULL COMMENT '生产批号',
  `disPrice` float(2) NOT NULL COMMENT '促销价格',
  `disStart` date DEFAULT NULL COMMENT '促销始日期',
  `disEnd` date DEFAULT NULL COMMENT '促销止日期',
  `note` varchar(1000) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`goodsID`, `produceID`),
  FOREIGN KEY (`goodsID`) REFERENCES `tb_goods` (`goodsID`),
  FOREIGN KEY (`produceID`) REFERENCES `tb_produce` (`produceID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='促销信息表';


-- ----------------------------
-- **********采购表************
-- Table structure for tb_buys
-- Table structure for tb_buy
-- ----------------------------
DROP TABLE IF EXISTS `tb_buys`;
CREATE TABLE `tb_buys` (
  `buysID`  varchar(100) NOT NULL COMMENT '采购编号',
  `goodsID` varchar(100) NOT NULL COMMENT '商品编号',
  `supplierID` varchar(100) NOT NULL COMMENT '供货商编号',
  `produceID` varchar(100) NOT NULL COMMENT '生产批号', 
  `buyPrice` float(2) NOT NULL COMMENT '采购单价',
  `buyNum` int NOT NULL COMMENT '采购数量',
  `note` varchar(1000) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`buysID`,`goodsID`, `supplierID`, `produceID`),
  FOREIGN KEY (`goodsID`) REFERENCES `tb_goods` (`goodsID`),
  FOREIGN KEY (`supplierID`) REFERENCES `tb_supplier` (`supplierID`),
  FOREIGN KEY (`produceID`) REFERENCES `tb_produce` (`produceID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='采购明细';

DROP TABLE IF EXISTS `tb_buy`;
CREATE TABLE `tb_buy` (
  `buysID`  varchar(100) NOT NULL COMMENT '采购编号',
  `buyDate` date NOT NULL COMMENT '采购日期',
  `note` varchar(1000) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`buysID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='采购记录';

-- ----------------------------
-- **********仓库表************
-- Table structure for tb_store
-- ----------------------------
DROP TABLE IF EXISTS `tb_store`;
CREATE TABLE `tb_store` (
  `storeID`  varchar(100) NOT NULL COMMENT '仓库编号',
  `storeName`  varchar(100) NOT NULL COMMENT '仓库名称',
  `storeNum` int DEFAULT 0 COMMENT '已用容量',
  `storeMax` int DEFAULT 50000 COMMENT '仓库容量',
  `storeManager` varchar(100) NOT NULL COMMENT '负责人ID',
  `storePhone`   varchar(100) DEFAULT NULL COMMENT '仓库电话',
  `storeAddress` varchar(100) DEFAULT NULL COMMENT '仓库地址',
  `note` varchar(1000) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`storeID`),
  FOREIGN KEY (`storeManager`) REFERENCES `tb_user` (`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='仓库表';


-- ----------------------------
-- **********入库表************
-- Table structure for tb_instocks
-- Table structure for tb_instock
-- ----------------------------
DROP TABLE IF EXISTS `tb_instocks`;
CREATE TABLE `tb_instocks` (
  `instockID` varchar(100) NOT NULL COMMENT '入库编号',
  `storeID`   varchar(100) NOT NULL COMMENT '仓库编号',
  `goodsID`   varchar(100) NOT NULL COMMENT '商品编号',
  `supplierID` varchar(100) NOT NULL COMMENT '供货商编号',
  `produceID` varchar(100) NOT NULL COMMENT '生产批号',
  `instockNum` int NOT NULL COMMENT '入库数量',
  `note` varchar(1000) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`instockID`,`storeID`,`goodsID`, `supplierID`, `produceID`),
  FOREIGN KEY (`storeID`) REFERENCES `tb_store` (`storeID`),
  FOREIGN KEY (`goodsID`) REFERENCES `tb_goods` (`goodsID`),
  FOREIGN KEY (`supplierID`) REFERENCES `tb_supplier` (`supplierID`),
  FOREIGN KEY (`produceID`) REFERENCES `tb_produce` (`produceID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='入库明细';

DROP TABLE IF EXISTS `tb_instock`;
CREATE TABLE `tb_instock` (
  `instockID` varchar(100) NOT NULL COMMENT '入库编号',
  `inDate` date NOT NULL COMMENT '入库日期',
  `note` varchar(1000) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`instockID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='入库记录';

-- ----------------------------
-- **********出库表************
-- Table structure for tb_outstocks
-- Table structure for tb_outstock
-- ----------------------------
DROP TABLE IF EXISTS `tb_outstocks`;
CREATE TABLE `tb_outstocks` (
  `outstockID` varchar(100) NOT NULL COMMENT '出库编号',
  `storeID`    varchar(100) NOT NULL COMMENT '仓库编号',
  `goodsID`    varchar(100) NOT NULL COMMENT '商品编号',
  `supplierID` varchar(100) NOT NULL COMMENT '供货商编号',
  `produceID` varchar(100) NOT NULL COMMENT '生产批号',
  `outstockNum` int DEFAULT NULL COMMENT '出库数量',
  `note` varchar(1000) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`outstockID`,`storeID`,`goodsID`, `supplierID`, `produceID`),
  FOREIGN KEY (`storeID`) REFERENCES `tb_store` (`storeID`),
  FOREIGN KEY (`goodsID`) REFERENCES `tb_goods` (`goodsID`),
  FOREIGN KEY (`supplierID`) REFERENCES `tb_supplier` (`supplierID`),
  FOREIGN KEY (`produceID`) REFERENCES `tb_produce` (`produceID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='出库明细';

DROP TABLE IF EXISTS `tb_outstock`;
CREATE TABLE `tb_outstock` (
  `outstockID` varchar(100) NOT NULL COMMENT '出库编号',
  `outDate` date NOT NULL COMMENT '出库日期',
  `note` varchar(1000) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`outstockID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='出库记录';


-- ----------------------------
-- **********库存表************
-- Table structure for tb_stock
-- ----------------------------
DROP TABLE IF EXISTS `tb_stock`;
CREATE TABLE `tb_stock` (
  `storeID` varchar(100) NOT NULL COMMENT '仓库编号',
  `goodsID` varchar(100) NOT NULL COMMENT '商品编号',
  `supplierID` varchar(100) NOT NULL COMMENT '供货商编号',
  `produceID` varchar(100) NOT NULL COMMENT '生产批号',
  `stockNum` int DEFAULT 0 COMMENT '库存数量',
  `stockMax` int DEFAULT 1000 COMMENT '最大容量',
  `stockAlarm` int DEFAULT 30 COMMENT '库存警报',
  `note` varchar(1000) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`storeID`,`goodsID`, `supplierID`, `produceID`),
  FOREIGN KEY (`storeID`) REFERENCES `tb_store` (`storeID`),
  FOREIGN KEY (`goodsID`) REFERENCES `tb_goods` (`goodsID`),
  FOREIGN KEY (`supplierID`) REFERENCES `tb_supplier` (`supplierID`),
  FOREIGN KEY (`produceID`) REFERENCES `tb_produce` (`produceID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='库存表';

-- ----------------------------
-- **********盘点表************
-- Table structure for tb_checks
-- Table structure for tb_check
-- ----------------------------
DROP TABLE IF EXISTS `tb_checks`;
CREATE TABLE `tb_checks` (
  `checkID` varchar(100) NOT NULL COMMENT '报表编号',
  `storeID` varchar(100) NOT NULL COMMENT '仓库编号',
  `goodsID` varchar(100) NOT NULL COMMENT '商品编号',
  `supplierID` varchar(100) NOT NULL COMMENT '供货商编号',
  `produceID` varchar(100) NOT NULL COMMENT '生产批号',
  `checkNum` int NOT NULL COMMENT '盘点数量',
  `note` varchar(1000) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`checkID`,`storeID`,`goodsID`,`supplierID`,`produceID`),
  FOREIGN KEY (`storeID`) REFERENCES `tb_store` (`storeID`),
  FOREIGN KEY (`goodsID`) REFERENCES `tb_goods` (`goodsID`),
  FOREIGN KEY (`supplierID`) REFERENCES `tb_supplier` (`supplierID`),
  FOREIGN KEY (`produceID`) REFERENCES `tb_produce` (`produceID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='盘点明细';

DROP TABLE IF EXISTS `tb_check`;
CREATE TABLE `tb_check` (
  `checkID` varchar(100) NOT NULL COMMENT '报表编号',
  `checkTime` date NOT NULL COMMENT '盘点日期',
  `note` varchar(1000) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`checkID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='盘点记录';


-- ----------------------------
-- **********销售表************
-- Table structure for tb_sales
-- Table structure for tb_sale
-- ----------------------------
DROP TABLE IF EXISTS `tb_sales`;
CREATE TABLE `tb_sales` (
  `salesID` varchar(100) NOT NULL COMMENT '销售编号',
  `goodsID` varchar(100) NOT NULL COMMENT '商品编号',
  `supplierID` varchar(100) NOT NULL COMMENT '供货商编号',
  `produceID` varchar(100) NOT NULL COMMENT '生产批号',
  `salesPrice` float(2) NOT NULL COMMENT '销售单价',
  `salesNum` int NOT NULL COMMENT '销售数量',
  `note` varchar(1000) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`salesID`,`goodsID`, `supplierID`, `produceID`),
  FOREIGN KEY (`goodsID`) REFERENCES `tb_goods` (`goodsID`),
  FOREIGN KEY (`supplierID`) REFERENCES `tb_supplier` (`supplierID`),
  FOREIGN KEY (`produceID`) REFERENCES `tb_produce` (`produceID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='销售明细';

DROP TABLE IF EXISTS `tb_sale`;
CREATE TABLE `tb_sale` (
  `salesID` varchar(100) NOT NULL COMMENT '销售编号',
  `salesSum`  float(2) NOT NULL COMMENT '应收款',
  `salesMoney`  float(2) NOT NULL COMMENT '实收款',
  `salesChange` float(2) NOT NULL COMMENT '找零',
  `salesDate` date NOT NULL COMMENT '销售日期',
  `salesTime` time NOT NULL COMMENT '销售时间',
  `note` varchar(1000) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`salesID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='销售记录';

-- ----------------------------
-- **********用户表************
-- Table structure for tb_user
-- ----------------------------
DROP TABLE IF EXISTS `tb_user`;
CREATE TABLE `tb_user` (
  `userID` varchar(100) NOT NULL COMMENT '用户编号',
  `userPassword` varchar(100) NOT NULL COMMENT '密码',
  `userName` varchar(100) NOT NULL COMMENT '姓名',
  `userSex` varchar(100) DEFAULT NULL COMMENT '性别',
  `userAge` varchar(100) DEFAULT NULL COMMENT '年龄',
  `userType` tinyint(1) DEFAULT NULL COMMENT '级别',
  `userJob` varchar(100) DEFAULT NULL COMMENT '职称',
  `userPhone` varchar(100) DEFAULT NULL COMMENT '联系方式',
  `note` varchar(1000) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- **********会员表************
-- Table structure for tb_member
-- ----------------------------
DROP TABLE IF EXISTS `tb_member`;
CREATE TABLE `tb_member` (
  `memberID` varchar(100) NOT NULL COMMENT '会员编号',
  `memberName` varchar(100) NOT NULL COMMENT '姓名',
  `memberSex` varchar(100) NOT NULL COMMENT '性别',
  `memberPhone` varchar(100) NOT NULL COMMENT '电话',
  `totalSum` float(2) DEFAULT NULL COMMENT '累积消费金额',
  `createDate` date DEFAULT NULL COMMENT '注册日期',
  `note` varchar(1000) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`memberID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会员表';

