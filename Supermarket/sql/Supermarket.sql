/*
MySQL Code
Host           : localhost:3306
Database       : supermarket
Target Server Type    : MYSQL
Date: 2020-02-02 22:22:22
          ID varchar(100)
created by 
          RedStar08@github.com Web前端
          zyzyzy520@github.com php后端
          ReunionJ@github.com Mysql数据库
开发语言：HTML + CSS + JavaScript + PHP + Mysql
开发环境：XAMPP + Chrome
Supermarket_Management_System Web App 
使用步骤：
1. 创建Supermarket数据库
2. 运行mysql -uroot -p -DSupermarket <E:\XAMPP\webapp\Supermarket\sql\Supermarket.sql
3. 初始登录 用户名: admin 密码: 123456
备注：0表示商品ID      000001
      1表示员工ID      100001
      2表示会员ID      200001
      3表示供应商ID    300001
      4表示仓库ID      400001
*/
set names utf8mb4;
-- 取消外码约束
SET FOREIGN_KEY_CHECKS=0;
-- --------------------------------------------------------------------
-- ******************************基本表********************************
-- *************************Table structure****************************
-- ***************************19张基本表*******************************
-- ****************************第3范式*********************************
-- --------------------------------------------------------------------

-- ----------------------------
-- **********商品表************
-- Table structure for tb_goods
-- ----------------------------
DROP TABLE IF EXISTS `tb_goods`;
CREATE TABLE `tb_goods` (
  `goodsID` varchar(100) NOT NULL COMMENT '商品编号',
  `goodsName` varchar(100) NOT NULL COMMENT '商品名称',
  `goodsPrice` decimal(10,2)  NOT NULL COMMENT '商品价格',
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
  `buyPrice` decimal(10,2) NOT NULL COMMENT '采购单价',
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
  `disPrice` decimal(10,2) NOT NULL COMMENT '促销价格',
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
  `buyID`  varchar(100) NOT NULL COMMENT '采购编号',
  `goodsID` varchar(100) NOT NULL COMMENT '商品编号',
  `supplierID` varchar(100) NOT NULL COMMENT '供货商编号',
  `produceID` varchar(100) NOT NULL COMMENT '生产批号',
  `buyPrice` decimal(10,2) NOT NULL COMMENT '采购单价',
  `buyNum` int NOT NULL COMMENT '采购数量',
  `note` varchar(1000) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`buyID`,`goodsID`, `supplierID`, `produceID`),
  FOREIGN KEY (`goodsID`) REFERENCES `tb_goods` (`goodsID`),
  FOREIGN KEY (`supplierID`) REFERENCES `tb_supplier` (`supplierID`),
  FOREIGN KEY (`produceID`) REFERENCES `tb_produce` (`produceID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='采购明细';

DROP TABLE IF EXISTS `tb_buy`;
CREATE TABLE `tb_buy` (
  `buyID`  varchar(100) NOT NULL COMMENT '采购编号',
  `buyTotal` int NOT NULL COMMENT '采购总数',
  `buyAcount` decimal(10,2) NOT NULL COMMENT '采购总价',
  `buyDate` date NOT NULL COMMENT '采购日期',
  `userID` varchar(100) NOT NULL COMMENT '用户编号',
  `note` varchar(1000) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`buyID`),
  FOREIGN KEY (`userID`) REFERENCES `tb_user` (`userID`)
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
  `instockTotal` int NOT NULL COMMENT '入库总数',
  `inDate` date NOT NULL COMMENT '入库日期',
  `userID` varchar(100) NOT NULL COMMENT '用户编号',
  `note` varchar(1000) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`instockID`),
  FOREIGN KEY (`userID`) REFERENCES `tb_user` (`userID`)
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
  `outstockTotal` int NOT NULL COMMENT '出库总数',
  `outDate` date NOT NULL COMMENT '出库日期',
  `userID` varchar(100) NOT NULL COMMENT '用户编号',
  `note` varchar(1000) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`outstockID`),
  FOREIGN KEY (`userID`) REFERENCES `tb_user` (`userID`)
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
  `stockNum` int NOT NULL COMMENT '库存数量',
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
  `stockTotal` int NOT NULL COMMENT '库存总数',
  `checkTotal` int NOT NULL COMMENT '盘点总数',
  `checkTime` date NOT NULL COMMENT '盘点日期',
  `userID` varchar(100) NOT NULL COMMENT '用户编号',
  `note` varchar(1000) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`checkID`),
  FOREIGN KEY (`userID`) REFERENCES `tb_user` (`userID`)
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
  `salesPrice` decimal(10,2) NOT NULL COMMENT '销售单价',
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
  `salesTotal` int NOT NULL COMMENT '销售总数',
  `salesSum`  decimal(10,2) NOT NULL COMMENT '应收款',
  `salesMoney`  decimal(10,2) NOT NULL COMMENT '实收款',
  `salesChange` decimal(10,2) NOT NULL COMMENT '找零',
  `salesProfit` decimal(10,2) NOT NULL COMMENT '利润',
  `salesDate` date NOT NULL COMMENT '销售日期',
  `salesTime` time NOT NULL COMMENT '销售时间',
  `userID` varchar(100) NOT NULL COMMENT '用户编号',
  `memberID` varchar(100) DEFAULT '非会员' COMMENT '会员编号',
  `note` varchar(1000) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`salesID`),
  FOREIGN KEY (`userID`) REFERENCES `tb_user` (`userID`)
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
  `totalSum` decimal(10,2) DEFAULT NULL COMMENT '累积消费金额',
  `createDate` date DEFAULT NULL COMMENT '注册日期',
  `note` varchar(1000) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`memberID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会员表';



-- --------------------------------------------------------------------
-- ******************************视图**********************************
-- *************************Table Views********************************
-- ***************************15张视图*********************************
-- ****************************第3范式*********************************
-- --------------------------------------------------------------------


-- 商品信息视图
DELIMITER $$
DROP view IF EXISTS `goods_info`$$
create view goods_info as select tb_goods.goodsID,goodsName,goodsType,goodsPrice,goodsSpecs,
goodsSave,tb_goodinfo.supplierID,supplierName,produceID,produceDate,produceArea,tb_goodinfo.note 
from tb_goods,tb_goodinfo,tb_supplier 
where tb_goods.goodsID = tb_goodinfo.goodsID and tb_supplier.supplierID = tb_goodinfo.supplierID
$$


-- 商品折扣表视图
DELIMITER $$
DROP view IF EXISTS `goods_discount`$$
create view goods_discount as select distinct tb_discount.goodsID, goodsName, goodsType, goodsPrice, disPrice,tb_discount.produceID, disStart, disEnd,
date_add(produceDate,interval goodsSave day) expirationDate,tb_discount.note 
from tb_discount,tb_goods,tb_goodinfo 
where tb_discount.goodsID = tb_goods.goodsID and tb_discount.goodsID = tb_goodinfo.goodsID 
and tb_goodinfo.goodsID = tb_goods.goodsID and tb_goodinfo.produceID =tb_discount.produceID
$$


-- 供应批次视图
DELIMITER $$
DROP view IF EXISTS `produce`$$
create view produce as select tb_produce.goodsID,goodsName,tb_produce.supplierID,supplierName,
  produceID, buyPrice, tb_produce.note 
from tb_goods,tb_supplier,tb_produce 
where tb_produce.goodsID = tb_goods.goodsID 
and tb_produce.supplierID = tb_supplier.supplierID
$$


-- 出库明细视图
DELIMITER $$
DROP view IF EXISTS `outstocks`$$
create view outstocks as select  tb_outstocks.outstockID,CONCAT_WS('',tb_outstocks.goodsID,tb_goods.goodsName)as goodsIDName,CONCAT_WS('',tb_outstocks.supplierID,tb_supplier.supplierName)as supplierIDName,
  tb_outstocks.produceID,CONCAT_WS('',tb_outstocks.storeID,tb_store.storeName)as storeIDName,tb_outstocks.outstockNum,tb_outstocks.note
from tb_goods,tb_store,tb_supplier,tb_outstocks
where tb_goods.goodsID = tb_outstocks.goodsID and tb_supplier.supplierID = tb_outstocks.supplierID and tb_outstocks.storeID = tb_store.storeID
$$


-- 出库记录视图
DELIMITER $$
DROP view IF EXISTS `outstock`$$
create view outstock as select outstockID,outstockTotal,outDate,tb_outstock.userID,userName,userPhone,tb_outstock.note
from tb_outstock,tb_user
where tb_outstock.userID=tb_user.userID
$$


-- 入库明细视图
DELIMITER $$
DROP view IF EXISTS `instocks`$$
create view instocks as select  tb_instocks.instockID,CONCAT_WS('',tb_instocks.goodsID,tb_goods.goodsName) as goodsIDName,CONCAT_WS('',tb_instocks.supplierID,tb_supplier.supplierName) as supplierIDName,
  tb_instocks.produceID,CONCAT_WS('',tb_instocks.storeID,tb_store.storeName) as storeIDName,tb_instocks.instockNum,tb_instocks.note
from tb_goods,tb_store,tb_supplier,tb_instocks
where tb_goods.goodsID = tb_instocks.goodsID and tb_supplier.supplierID = tb_instocks.supplierID and tb_instocks.storeID = tb_store.storeID
$$


-- 入库记录视图
DELIMITER $$
DROP view IF EXISTS `instock`$$
create view instock as select instockID,instockTotal,inDate,tb_instock.userID,userName,userPhone,tb_instock.note
from tb_instock,tb_user
where tb_instock.userID=tb_user.userID
$$


-- 库存状态视图
DELIMITER $$
DROP view IF EXISTS `stock`$$
create view stock as 
select tb_stock.goodsID,goodsName,goodsPrice,goodsType,goodsSpecs,sum(stockNum) as stockTotal,
sum(stockMax) as stockMax,stockAlarm,tb_stock.note
from tb_stock,tb_goods
where tb_stock.goodsID=tb_goods.goodsID
group by tb_goods.goodsID
$$


-- 库存明细视图(不需要已知goodsID)
DELIMITER $$
DROP view IF EXISTS `stocks`$$
create view stocks as 
select  tb_stock.goodsID,tb_goods.goodsName,tb_stock.supplierID,tb_supplier.supplierName,
tb_stock.produceID,CONCAT_WS('',tb_stock.storeID,tb_store.storeName)as storeIDName,tb_stock.stockNum
from tb_goods,tb_store,tb_supplier,tb_stock
where tb_stock.goodsID = tb_goods.goodsID and tb_supplier.supplierID = tb_stock.supplierID and tb_stock.storeID = tb_store.storeID
$$


-- 盘点记录视图
DELIMITER $$
DROP view IF EXISTS `check_list`$$
create view check_list as select checkID,tb_check.stockTotal,checkTotal,checkTime,tb_check.userID,userName,userPhone,tb_check.note
from tb_check,tb_user
where tb_check.userID=tb_user.userID
$$


-- 盘点明细视图(不需要已知checkID)
DELIMITER $$
DROP view IF EXISTS `checks`$$
create view checks as select  checkID,CONCAT_WS('',tb_checks.goodsID,tb_goods.goodsName) as goodsIDName,
  CONCAT_WS('',tb_checks.supplierID,tb_supplier.supplierName)as supplierIDName,
  tb_checks.produceID,CONCAT_WS('',tb_checks.storeID,tb_store.storeName)as storeIDName,tb_checks.stockNum,tb_checks.checkNum,tb_checks.note
from tb_goods,tb_store,tb_supplier,tb_checks
where tb_checks.goodsID = tb_goods.goodsID and tb_supplier.supplierID = tb_checks.supplierID and tb_checks.storeID = tb_store.storeID
$$


-- 采购明细视图
DELIMITER $$
DROP view IF EXISTS `buys`$$
create view buys as
select buyID,CONCAT_WS('',tb_buys.goodsID,tb_goods.goodsName) as goodsIDName,
  CONCAT_WS('',tb_buys.supplierID,tb_supplier.supplierName)as supplierIDName,
  produceID ,buyPrice ,buyNum ,(buyPrice*buyNum) as buyTips,tb_buys.note  
from tb_buys,tb_goods,tb_supplier
where tb_buys.goodsID = tb_goods.goodsID and tb_buys.supplierID = tb_supplier.supplierID;
$$


-- 采购记录视图
DELIMITER $$
DROP view IF EXISTS `buy`$$
create view buy as select buyID,buyTotal,buyAcount,buyDate,tb_buy.userID,userName,userPhone,tb_buy.note
from tb_buy,tb_user
where tb_buy.userID=tb_user.userID
$$


-- 销售记录视图
DELIMITER $$
DROP view IF EXISTS `sale`$$
create view sale as select salesID,salesTotal,format(salesSum,2) as salesSum,format(salesMoney,2) as salesMoney,
  format(salesChange,2) as salesChange,
  format(salesProfit,2) as salesProfit,
  salesDate,salesTime,
  memberID,tb_sale.userID,userName,tb_sale.note
from tb_sale,tb_user
where tb_sale.userID=tb_user.userID
$$


-- 销售明细视图
DELIMITER $$
DROP view IF EXISTS `sales`$$
create view sales as select salesID,CONCAT_WS('',tb_sales.goodsID,tb_goods.goodsName) as goodsIDName,
  CONCAT_WS('',tb_sales.supplierID,tb_supplier.supplierName)as supplierIDName,produceID,
  salesPrice,salesNum,(salesPrice*salesNum) as salesTips,tb_sales.note
from tb_sales,tb_goods,tb_supplier
where tb_sales.goodsID = tb_goods.goodsID and tb_sales.supplierID = tb_supplier.supplierID;
$$


-- 每日销售统计视图
DELIMITER $$
DROP view IF EXISTS `daily_count`$$
create view daily_count as 
select salesDate,sum(salesTotal) as salesTotal, sum(salesSum) as salesSum,
sum(salesMoney) as salesMoney, sum(salesChange) as salesChange, sum(salesProfit) as salesProfit
from tb_sale
group by salesDate
$$


-- 每日采购统计视图
DELIMITER $$
DROP view IF EXISTS `buy_count`$$
create view buy_count as 
select buyDate,sum(buyTotal) as buyTotal, sum(buyAcount) as buyAcount from buy group by buyDate
$$

-- 每日采购统计视图
DELIMITER $$
DROP view IF EXISTS `sales_count`$$
create view sales_count as 
select goodsIDName, sum(salesNum) as salesNum, sum(salesTips) as salesTips 
  from sales group by goodsIDName ORDER BY goodsIDName
$$



-- --------------------------------------------------------------------
-- ****************************触发器**********************************
-- *************************Table Tigger*******************************
-- ***************************2触发器**********************************
-- ****************************第3范式*********************************
-- --------------------------------------------------------------------


-- 数据流触发器（ 入库-库存/仓库 和 出库-库存/仓库 数量自动变化（插入-更新））：

-- --------------------------------------------------------------
-- ************************入库-库存限制/仓库*********************
-- Table update constraint for tb_instocks and tb_stock/ tb_store
-- --------------------------------------------------------------
-- 插入入库-更新库存/仓库
DELIMITER $$
DROP TRIGGER IF EXISTS `insert_instock_stock_store`$$
CREATE TRIGGER `insert_instock_stock_store` after INSERT ON `tb_instocks`
	FOR EACH ROW begin 

		IF EXISTS (select * from tb_stock where tb_stock.storeID=new.storeID and tb_stock.goodsID=new.goodsID 
			and tb_stock.supplierID=new.supplierID and tb_stock.produceID=new.produceID)

			then update tb_stock set stockNum = stockNum + new.instockNum where tb_stock.storeID=new.storeID 
      and tb_stock.goodsID=new.goodsID 
				and tb_stock.supplierID=new.supplierID and tb_stock.produceID=new.produceID;

		else INSERT INTO `tb_stock` VALUES (new.storeID, new.goodsID, new.supplierID, new.produceID, 
      new.instockNum, DEFAULT, DEFAULT, '');
		end if;

		update tb_store set storeNum = storeNum + new.instockNum where tb_store.storeID=new.storeID;
	end
$$
-- 测试数据
-- INSERT INTO `tb_instocks` VALUES ('201911110004', '400001', '000001', '300001', '20191111', '200', '光棍节入库');
-- INSERT INTO `tb_instocks` VALUES ('202001140001', '400001', '000001', '300001', '20200101', '200', '1月入库');



-- ---------------------------------------------------------------
-- ************************出库-库存限制/仓库**********************
-- Table update constraint for tb_outstocks and tb_stock/ tb_store
-- ---------------------------------------------------------------
-- 插入出库-更新库存/仓库
DELIMITER $$
DROP TRIGGER IF EXISTS `insert_outstock_stock_store`$$
CREATE TRIGGER `insert_outstock_stock_store` after INSERT ON `tb_outstocks`
	FOR EACH ROW begin 
		update tb_stock set stockNum = stockNum - new.outstockNum where tb_stock.storeID=new.storeID 
      and tb_stock.goodsID=new.goodsID 
			and tb_stock.supplierID=new.supplierID and tb_stock.produceID=new.produceID;
		update tb_store set storeNum = storeNum - new.outstockNum where tb_store.storeID=new.storeID;
	end
$$
-- 测试数据
-- INSERT INTO `tb_outstocks` VALUES ('201911110004', '400001', '000001', '300001', '20191111', '200', '光棍节出库');


-- ---------------------------------------------------------------
-- ************************销售记录-会员累计金额**********************
-- Table update constraint for tb_sale and tb_member
-- ---------------------------------------------------------------
-- 插入销售记录-更新会员累计金额
DELIMITER $$
DROP TRIGGER IF EXISTS `insert_sale_member`$$
CREATE TRIGGER `insert_sale_member` after INSERT ON `tb_sale`
  FOR EACH ROW begin 
    IF EXISTS (select * from tb_member where tb_member.memberID = new.memberID)
      then update tb_member set totalSum = totalSum + new.salesSum where tb_member.memberID = new.memberID;
    end if;
  end
$$
-- 测试数据
-- INSERT INTO `tb_sale` VALUES ('202004020003', '9', '133.50', '150.00', '16.50', '2020-04-02', '22:07:19', '100000', '200001', '现金支付');


---------------------------------------------------------------------------
-- ********************************** 注意事项 ******************************
-- ！！！尽量少使用触发器，不建议使用。

-- 　　假设触发器触发每次执行1s，insert table 500条数据，那么就需要触发500次触发器。
--  光是触发器执行的时间就花费了500s，而insert 500条数据一共是1s，那么这个insert的效率就非常低了。
--  因此我们特别需要注意的一点是触发器的begin end;之间的语句的执行效率一定要高，资源消耗要小。

-- 　　触发器尽量少的使用，因为不管如何，它还是很消耗资源。
--  如果使用的话要谨慎的使用，确定它是非常高效的：触发器是针对每一行的；
--  对增删改非常频繁的表上切记不要使用触发器，因为它会非常消耗资源。 

--  触发器只能创建在永久表（Permanent Table）上，不能对临时表（Temporary Table）创建触发器。

--CREATE TRIGGER tri_userAge  
--       { BEFORE} 
--            <触发事件> ON <表名>
--       FOR EACH  {ROW | STATEMENT}
--  <触发动作体>；
--特殊对象：New,   Old
-- *********************************************************************
-------------------------------------------------------------------------


-- --------------------------------------------------------------------
-- ************************基本表测试数据******************************
-- *************************Table Test Data****************************
-- ***************************1500+条**********************************
-- ****************************第3范式*********************************
-- --------------------------------------------------------------------
/*
备注：0表示商品ID      000001
      1表示员工ID      100001
      2表示会员ID      200001
      3表示供应商ID    300001
      4表示仓库ID      400001
*/
DELIMITER ;

-- ----------------------------
-- ********用户测试数据********
-- Records of tb_user
-- ----------------------------
INSERT INTO `tb_user` VALUES ('admin',  '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',  'admin',  '男', '23', '1', '数据库管理员', '18856310000', '数据库测试');
INSERT INTO `tb_user` VALUES ('100000', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92','RedStar08','男', '23', '1', '数据库管理员', '18856310000', '系统测试');
INSERT INTO `tb_user` VALUES ('100001', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', '小刘',   '男', '23', '2', '店长',         '18856310001', 'Web前端');
INSERT INTO `tb_user` VALUES ('100002', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', '小林',   '男', '20', '4', '仓库管理员',   '18856310002', '数据库');
INSERT INTO `tb_user` VALUES ('100003', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', '小周',   '女', '21', '5', '收银员',       '18856310003', 'Web后端');
INSERT INTO `tb_user` VALUES ('100004', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', '朱明露', '男', '22', '3', '采购员',       '18856310004', '');
INSERT INTO `tb_user` VALUES ('100005', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', '杨凤美', '女', '23', '4', '仓库管理员',   '18856310005', '');
INSERT INTO `tb_user` VALUES ('100006', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', '曹景燕', '男', '24', '4', '仓库管理员',   '18856310006', '');
INSERT INTO `tb_user` VALUES ('100007', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', '奚黛',   '女', '25', '4', '仓库管理员',   '18856310007', '');
INSERT INTO `tb_user` VALUES ('100008', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', '王玉凤', '女', '26', '4', '仓库管理员',   '18856310008', '');
INSERT INTO `tb_user` VALUES ('100009', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', '何纨',   '男', '27', '5', '收银员',       '18856310009', '');
INSERT INTO `tb_user` VALUES ('100010', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', '张欢',   '男', '28', '5', '收银员',       '18856310010', '');
INSERT INTO `tb_user` VALUES ('100011', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', '朱明露', '男', '29', '5', '收银员',       '18856310011', '');
INSERT INTO `tb_user` VALUES ('100012', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', '吴良翠', '女', '30', '5', '收银员',       '18856310012', '');
INSERT INTO `tb_user` VALUES ('100013', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', '姜传敏', '男', '31', '4', '仓库管理员',   '18856310013', '');
INSERT INTO `tb_user` VALUES ('100014', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', '何雪倩', '女', '32', '3', '采购员',       '18856310014', '');
INSERT INTO `tb_user` VALUES ('100015', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', '吕紫君', '男', '33', '3', '采购员',       '18856310015', '');
INSERT INTO `tb_user` VALUES ('100016', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', '韩乐',   '男', '34', '3', '采购员',       '18856310016', '');
INSERT INTO `tb_user` VALUES ('100017', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', '华庆黎', '男', '35', '4', '仓库管理员',   '18856310017', '');
INSERT INTO `tb_user` VALUES ('100018', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', '康春文', '男', '36', '4', '仓库管理员',   '18856310018', '');
INSERT INTO `tb_user` VALUES ('100019', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', '岑朱婷', '女', '37', '4', '仓库管理员',   '18856310019', '');

-- ----------------------------
-- ********会员测试数据********
-- Records of tb_member
-- ----------------------------
INSERT INTO `tb_member` VALUES ('200001', '小刘',    '男', '18856320001', '0.00', '2019-11-26', '刘总');
INSERT INTO `tb_member` VALUES ('200002', '小林',    '男', '18856320002', '0.00', '2019-11-26', '林总');
INSERT INTO `tb_member` VALUES ('200003', '小周*',   '女', '18856320003', '0.00', '2019-11-26', '周总');
INSERT INTO `tb_member` VALUES ('200004', '严绮菱*', '女', '18856320004', '0.00', '2019-11-27', 'SVIP用户');
INSERT INTO `tb_member` VALUES ('200005', '钱世兰',  '男', '18856320005', '0.00', '2019-11-28', 'SVIP用户');
INSERT INTO `tb_member` VALUES ('200006', '曹黄萍*', '女', '18856320006', '0.00', '2019-11-29', 'SVIP用户');
INSERT INTO `tb_member` VALUES ('200007', '陶香秀*', '女', '18856320007', '0.00', '2019-11-30', 'SVIP用户');
INSERT INTO `tb_member` VALUES ('200008', '赵露*',   '女', '18856320008', '0.00', '2019-12-1',  'SVIP用户');
INSERT INTO `tb_member` VALUES ('200009', '李寒',    '男', '18856320009', '0.00', '2019-12-2',  'SVIP用户');
INSERT INTO `tb_member` VALUES ('200010', '钱琴*',   '女', '18856320010', '0.00', '2019-12-3',  'SVIP用户');
INSERT INTO `tb_member` VALUES ('200011', '郑惜雪*', '女', '18856320011', '0.00', '2019-12-4',  'VIP用户');
INSERT INTO `tb_member` VALUES ('200012', '陶佳丽*', '女', '18856320012', '0.00', '2019-12-5',  'VIP用户');
INSERT INTO `tb_member` VALUES ('200013', '王树平',  '男', '18856320013', '0.00', '2019-12-6',  'VIP用户');
INSERT INTO `tb_member` VALUES ('200014', '周玉凤*', '女', '18856320014', '0.00', '2019-12-7',  'VIP用户');
INSERT INTO `tb_member` VALUES ('200015', '沈欣淼',  '男', '18856320015', '0.00', '2019-12-8',  'VIP用户');
INSERT INTO `tb_member` VALUES ('200016', '昌冰彤',  '男', '18856320016', '0.00', '2019-12-9',  'VIP用户');
INSERT INTO `tb_member` VALUES ('200017', '尤春竹',  '男', '18856320017', '0.00', '2019-12-10', 'VIP用户');
INSERT INTO `tb_member` VALUES ('200018', '邹灿灿',  '男', '18856320018', '0.00', '2019-12-11', 'VIP用户');
INSERT INTO `tb_member` VALUES ('200019', '孙景燕*', '女', '18856320019', '0.00', '2019-12-12', 'VIP用户');
INSERT INTO `tb_member` VALUES ('200020', '岑朱婷*', '女', '18856320020', '0.00', '2019-12-13', 'VIP用户');

-- ----------------------------
-- ********商品测试数据********
-- Records of tb_goods
-- ----------------------------
INSERT INTO `tb_goods` VALUES ('000001', '百事可乐',    '3.00',  '饮品',     '瓶', '180', '夏季增加采购');
INSERT INTO `tb_goods` VALUES ('000002', '可口可乐',    '3.00',  '饮品',     '瓶', '180', '夏季增加采购');
INSERT INTO `tb_goods` VALUES ('000003', '农夫山泉',    '2.00',  '饮品',     '瓶', '180', '夏季增加采购');
INSERT INTO `tb_goods` VALUES ('000004', '红星笔记本',  '5.00',  '文具',     '本', '360', '开学季增加采购');
INSERT INTO `tb_goods` VALUES ('000005', '派克钢笔',    '55.00', '文具',     '支', '360', '开学季增加采购');
INSERT INTO `tb_goods` VALUES ('000006', '得力订书机',  '5.00',  '文具',     '个', '360', '开学季增加采购');
INSERT INTO `tb_goods` VALUES ('000007', '可比克薯片',  '3.50',  '食品类',   '袋', '180', '');
INSERT INTO `tb_goods` VALUES ('000008', '达利园面包',  '3.50',  '食品类',   '袋', '180', '');
INSERT INTO `tb_goods` VALUES ('000009', '好吃点饼干',  '3.50',  '食品类',   '袋', '180', '');
INSERT INTO `tb_goods` VALUES ('000010', '金龙鱼花生油','55.00', '厨用品',   '桶', '500', '1:1:1调和');
INSERT INTO `tb_goods` VALUES ('000011', '海天酱油',    '20.00', '厨用品',   '瓶', '180', '晒足180天');
INSERT INTO `tb_goods` VALUES ('000012', '麻辣十三香',  '8.00',  '厨用品',   '包', '360', '还是麻麻的味道');
INSERT INTO `tb_goods` VALUES ('000013', '超人牙刷',    '3.50',  '洗漱用品', '支', '360', '');
INSERT INTO `tb_goods` VALUES ('000014', '黑人牙膏',    '3.50',  '洗漱用品', '支', '360', '');
INSERT INTO `tb_goods` VALUES ('000015', '席梦思毛巾',  '3.50',  '洗漱用品', '条', '360', '');
INSERT INTO `tb_goods` VALUES ('000016', '清风抽纸',    '15.00', '日用品',   '包', '360', '好用就行了');
INSERT INTO `tb_goods` VALUES ('000017', '捷达棉签',    '5.00',  '日用品',   '盒', '90',  '好用就行了');
INSERT INTO `tb_goods` VALUES ('000018', '水晶玻璃杯',  '8.00',  '日用品',   '个', '360', '好用就行了');
INSERT INTO `tb_goods` VALUES ('000019', '好妈妈拖把',  '33.50', '清洁用品', '个', '360', '');
INSERT INTO `tb_goods` VALUES ('000020', '好爸爸抹布',  '13.50', '清洁用品', '个', '360', '');
INSERT INTO `tb_goods` VALUES ('000021', '乖儿子扫帚',  '23.50', '清洁用品', '个', '360', '');
INSERT INTO `tb_goods` VALUES ('000022', '脑白金',      '100.00','保健品',   '盒', '360', '送爸妈');
INSERT INTO `tb_goods` VALUES ('000023', '成长快乐',    '100.00','保健品',   '罐', '360', '送孩子');
INSERT INTO `tb_goods` VALUES ('000024', '黄金搭档',    '100.00','保健品',   '瓶', '360', '童年的回忆');

-- ----------------------------
-- **********供应商测试*********
-- Records of tb_supplier
-- ----------------------------
INSERT INTO `tb_supplier` VALUES ('300001', '饮品供应商',   '小刘', '10086','安徽-宣城市-宣州区-薰化路301号', '24小时供货');
INSERT INTO `tb_supplier` VALUES ('300002', '文具供应商',   '小林', '10086','安徽-宣城市-宣州区-薰化路302号', '周末不供货');
INSERT INTO `tb_supplier` VALUES ('300003', '食品供应商',   '小周', '10086','安徽-宣城市-宣州区-薰化路303号', '不定时供货');
INSERT INTO `tb_supplier` VALUES ('300004', '厨具供应商',   '大刘', '10086','安徽-宣城市-宣州区-薰化路304号', '周末不供货');
INSERT INTO `tb_supplier` VALUES ('300005', '洗漱品供应商', '小刘', '10086','安徽-宣城市-宣州区-薰化路305号', '24小时供货');
INSERT INTO `tb_supplier` VALUES ('300006', '日用品供应商', '小林', '10086','安徽-宣城市-宣州区-薰化路306号', '周末不供货');
INSERT INTO `tb_supplier` VALUES ('300007', '清洁品供应商', '小周', '10086','安徽-宣城市-宣州区-薰化路307号', '不定时供货');
INSERT INTO `tb_supplier` VALUES ('300008', '保健品供应商', '小周', '10086','安徽-宣城市-宣州区-薰化路308号', '不定时供货');

-- ----------------------------
-- **********生产表测试*********
-- Records of tb_produce
-- ----------------------------
-- 商品对应供应商
INSERT INTO `tb_produce` VALUES ('000001', '300001', '20191111', '1.00',  '光棍节促销');
INSERT INTO `tb_produce` VALUES ('000002', '300001', '20191111', '1.00',  '光棍节促销');
INSERT INTO `tb_produce` VALUES ('000003', '300001', '20191111', '0.50',  '光棍节促销');
INSERT INTO `tb_produce` VALUES ('000004', '300002', '20191111', '2.00',  '光棍节促销');
INSERT INTO `tb_produce` VALUES ('000005', '300002', '20191111', '30.00', '光棍节促销');
INSERT INTO `tb_produce` VALUES ('000006', '300002', '20191111', '2.00',  '光棍节促销');
INSERT INTO `tb_produce` VALUES ('000007', '300003', '20191111', '1.00',  '光棍节促销');
INSERT INTO `tb_produce` VALUES ('000008', '300003', '20191111', '1.00',  '光棍节促销');
INSERT INTO `tb_produce` VALUES ('000009', '300003', '20191111', '1.00',  '光棍节促销');
INSERT INTO `tb_produce` VALUES ('000010', '300004', '20191111', '25.00', '光棍节促销');
INSERT INTO `tb_produce` VALUES ('000011', '300004', '20191111', '10.00', '光棍节促销');
INSERT INTO `tb_produce` VALUES ('000012', '300004', '20191111', '6.00',  '光棍节促销');
INSERT INTO `tb_produce` VALUES ('000013', '300005', '20191111', '1.50',  '光棍节促销');
INSERT INTO `tb_produce` VALUES ('000014', '300005', '20191111', '1.50',  '光棍节促销');
INSERT INTO `tb_produce` VALUES ('000015', '300005', '20191111', '2.00',  '光棍节促销');
INSERT INTO `tb_produce` VALUES ('000016', '300006', '20191111', '10.00', '光棍节促销');
INSERT INTO `tb_produce` VALUES ('000017', '300006', '20191111', '3.00',  '光棍节促销');
INSERT INTO `tb_produce` VALUES ('000018', '300006', '20191111', '6.00',  '光棍节促销');
INSERT INTO `tb_produce` VALUES ('000019', '300007', '20191111', '28.50', '光棍节促销');
INSERT INTO `tb_produce` VALUES ('000020', '300007', '20191111', '8.50',  '光棍节促销');
INSERT INTO `tb_produce` VALUES ('000021', '300007', '20191111', '13.50', '光棍节促销');
INSERT INTO `tb_produce` VALUES ('000022', '300008', '20191111', '80.00', '光棍节促销');
INSERT INTO `tb_produce` VALUES ('000023', '300008', '20191111', '75.00', '光棍节促销');
INSERT INTO `tb_produce` VALUES ('000024', '300008', '20191111', '85.00', '光棍节促销');

INSERT INTO `tb_produce` VALUES ('000001', '300001', '20191212', '1.00',  '双12促销');
INSERT INTO `tb_produce` VALUES ('000002', '300001', '20191212', '1.00',  '双12促销');
INSERT INTO `tb_produce` VALUES ('000003', '300001', '20191212', '0.50',  '双12促销');
INSERT INTO `tb_produce` VALUES ('000004', '300002', '20191212', '2.00',  '双12促销');
INSERT INTO `tb_produce` VALUES ('000005', '300002', '20191212', '30.00', '双12促销');
INSERT INTO `tb_produce` VALUES ('000006', '300002', '20191212', '2.00',  '双12促销');
INSERT INTO `tb_produce` VALUES ('000007', '300003', '20191212', '1.00',  '双12促销');
INSERT INTO `tb_produce` VALUES ('000008', '300003', '20191212', '1.00',  '双12促销');
INSERT INTO `tb_produce` VALUES ('000009', '300003', '20191212', '1.00',  '双12促销');
INSERT INTO `tb_produce` VALUES ('000010', '300004', '20191212', '25.00', '双12促销');
INSERT INTO `tb_produce` VALUES ('000011', '300004', '20191212', '10.00', '双12促销');
INSERT INTO `tb_produce` VALUES ('000012', '300004', '20191212', '6.00',  '双12促销');
INSERT INTO `tb_produce` VALUES ('000013', '300005', '20191212', '1.50',  '双12促销');
INSERT INTO `tb_produce` VALUES ('000014', '300005', '20191212', '1.50',  '双12促销');
INSERT INTO `tb_produce` VALUES ('000015', '300005', '20191212', '2.00',  '双12促销');
INSERT INTO `tb_produce` VALUES ('000016', '300006', '20191212', '10.00', '双12促销');
INSERT INTO `tb_produce` VALUES ('000017', '300006', '20191212', '3.00',  '双12促销');
INSERT INTO `tb_produce` VALUES ('000018', '300006', '20191212', '6.00',  '双12促销');
INSERT INTO `tb_produce` VALUES ('000019', '300007', '20191212', '28.50', '双12促销');
INSERT INTO `tb_produce` VALUES ('000020', '300007', '20191212', '8.50',  '双12促销');
INSERT INTO `tb_produce` VALUES ('000021', '300007', '20191212', '13.50', '双12促销');
INSERT INTO `tb_produce` VALUES ('000022', '300008', '20191212', '80.00', '双12促销');
INSERT INTO `tb_produce` VALUES ('000023', '300008', '20191212', '75.00', '双12促销');
INSERT INTO `tb_produce` VALUES ('000024', '300008', '20191212', '85.00', '双12促销');

INSERT INTO `tb_produce` VALUES ('000001', '300001', '20200101', '1.00',  '元旦促销');
INSERT INTO `tb_produce` VALUES ('000002', '300001', '20200101', '1.00',  '元旦促销');
INSERT INTO `tb_produce` VALUES ('000003', '300001', '20200101', '0.50',  '元旦促销');
INSERT INTO `tb_produce` VALUES ('000004', '300002', '20200101', '2.00',  '元旦促销');
INSERT INTO `tb_produce` VALUES ('000005', '300002', '20200101', '30.00', '元旦促销');
INSERT INTO `tb_produce` VALUES ('000006', '300002', '20200101', '2.00',  '元旦促销');
INSERT INTO `tb_produce` VALUES ('000007', '300003', '20200101', '1.00',  '元旦促销');
INSERT INTO `tb_produce` VALUES ('000008', '300003', '20200101', '1.00',  '元旦促销');
INSERT INTO `tb_produce` VALUES ('000009', '300003', '20200101', '1.00',  '元旦促销');
INSERT INTO `tb_produce` VALUES ('000010', '300004', '20200101', '25.00', '元旦促销');
INSERT INTO `tb_produce` VALUES ('000011', '300004', '20200101', '10.00', '元旦促销');
INSERT INTO `tb_produce` VALUES ('000012', '300004', '20200101', '6.00',  '元旦促销');
INSERT INTO `tb_produce` VALUES ('000013', '300005', '20200101', '1.50',  '元旦促销');
INSERT INTO `tb_produce` VALUES ('000014', '300005', '20200101', '1.50',  '元旦促销');
INSERT INTO `tb_produce` VALUES ('000015', '300005', '20200101', '2.00',  '元旦促销');
INSERT INTO `tb_produce` VALUES ('000016', '300006', '20200101', '10.00', '元旦促销');
INSERT INTO `tb_produce` VALUES ('000017', '300006', '20200101', '3.00',  '元旦促销');
INSERT INTO `tb_produce` VALUES ('000018', '300006', '20200101', '6.00',  '元旦促销');
INSERT INTO `tb_produce` VALUES ('000019', '300007', '20200101', '28.50', '元旦促销');
INSERT INTO `tb_produce` VALUES ('000020', '300007', '20200101', '8.50',  '元旦促销');
INSERT INTO `tb_produce` VALUES ('000021', '300007', '20200101', '13.50', '元旦促销');
INSERT INTO `tb_produce` VALUES ('000022', '300008', '20200101', '80.00', '元旦促销');
INSERT INTO `tb_produce` VALUES ('000023', '300008', '20200101', '75.00', '元旦促销');
INSERT INTO `tb_produce` VALUES ('000024', '300008', '20200101', '85.00', '元旦促销');
-- 同一商品不同供应商
INSERT INTO `tb_produce` VALUES ('000001', '300003', '20191111', '1.50', '光棍节促销');
INSERT INTO `tb_produce` VALUES ('000002', '300003', '20191111', '1.50', '光棍节促销');
INSERT INTO `tb_produce` VALUES ('000003', '300003', '20191111', '1.00', '光棍节促销');
INSERT INTO `tb_produce` VALUES ('000013', '300006', '20191111', '2.00', '光棍节促销');
INSERT INTO `tb_produce` VALUES ('000014', '300006', '20191111', '2.00', '光棍节促销');
INSERT INTO `tb_produce` VALUES ('000015', '300006', '20191111', '2.00', '光棍节促销');

INSERT INTO `tb_produce` VALUES ('000001', '300003', '20191212', '1.50', '双12促销');
INSERT INTO `tb_produce` VALUES ('000002', '300003', '20191212', '1.50', '双12促销');
INSERT INTO `tb_produce` VALUES ('000003', '300003', '20191212', '1.00', '双12促销');
INSERT INTO `tb_produce` VALUES ('000013', '300006', '20191212', '2.00', '双12促销');
INSERT INTO `tb_produce` VALUES ('000014', '300006', '20191212', '2.00', '双12促销');
INSERT INTO `tb_produce` VALUES ('000015', '300006', '20191212', '2.00', '双12促销');

INSERT INTO `tb_produce` VALUES ('000001', '300003', '20200101', '1.50', '元旦促销');
INSERT INTO `tb_produce` VALUES ('000002', '300003', '20200101', '1.50', '元旦促销');
INSERT INTO `tb_produce` VALUES ('000003', '300003', '20200101', '1.00', '元旦促销');
INSERT INTO `tb_produce` VALUES ('000013', '300006', '20200101', '2.00', '元旦促销');
INSERT INTO `tb_produce` VALUES ('000014', '300006', '20200101', '2.00', '元旦促销');
INSERT INTO `tb_produce` VALUES ('000015', '300006', '20200101', '2.00', '元旦促销');

-- ----------------------------
-- ******商品信息测试数据******
-- Records of tb_goodinfo
-- ----------------------------
INSERT INTO `tb_goodinfo` VALUES ('000001', '300001', '20191111', '2019-11-11', '安徽省-宣城市-宣州区-薰化路301号', '光棍节促销');
INSERT INTO `tb_goodinfo` VALUES ('000002', '300001', '20191111', '2019-11-11', '安徽省-宣城市-宣州区-薰化路301号', '光棍节促销');
INSERT INTO `tb_goodinfo` VALUES ('000003', '300001', '20191111', '2019-11-11', '安徽省-宣城市-宣州区-薰化路301号', '光棍节促销');
INSERT INTO `tb_goodinfo` VALUES ('000004', '300002', '20191111', '2019-11-11', '安徽省-宣城市-宣州区-薰化路301号', '光棍节促销');
INSERT INTO `tb_goodinfo` VALUES ('000005', '300002', '20191111', '2019-11-11', '安徽省-宣城市-宣州区-薰化路301号', '光棍节促销');
INSERT INTO `tb_goodinfo` VALUES ('000006', '300002', '20191111', '2019-11-11', '安徽省-宣城市-宣州区-薰化路301号', '光棍节促销');
INSERT INTO `tb_goodinfo` VALUES ('000007', '300003', '20191111', '2019-11-11', '安徽省-宣城市-宣州区-薰化路301号', '光棍节促销');
INSERT INTO `tb_goodinfo` VALUES ('000008', '300003', '20191111', '2019-11-11', '安徽省-宣城市-宣州区-薰化路301号', '光棍节促销');
INSERT INTO `tb_goodinfo` VALUES ('000009', '300003', '20191111', '2019-11-11', '安徽省-宣城市-宣州区-薰化路301号', '光棍节促销');
INSERT INTO `tb_goodinfo` VALUES ('000010', '300004', '20191111', '2019-11-11', '安徽省-宣城市-宣州区-薰化路301号', '光棍节促销');
INSERT INTO `tb_goodinfo` VALUES ('000011', '300004', '20191111', '2019-11-11', '安徽省-宣城市-宣州区-薰化路301号', '光棍节促销');
INSERT INTO `tb_goodinfo` VALUES ('000012', '300004', '20191111', '2019-11-11', '安徽省-宣城市-宣州区-薰化路301号', '光棍节促销');
INSERT INTO `tb_goodinfo` VALUES ('000013', '300005', '20191111', '2019-11-11', '安徽省-宣城市-宣州区-薰化路301号', '光棍节促销');
INSERT INTO `tb_goodinfo` VALUES ('000014', '300005', '20191111', '2019-11-11', '安徽省-宣城市-宣州区-薰化路301号', '光棍节促销');
INSERT INTO `tb_goodinfo` VALUES ('000015', '300005', '20191111', '2019-11-11', '安徽省-宣城市-宣州区-薰化路301号', '光棍节促销');
INSERT INTO `tb_goodinfo` VALUES ('000016', '300006', '20191111', '2019-11-11', '安徽省-宣城市-宣州区-薰化路301号', '光棍节促销');
INSERT INTO `tb_goodinfo` VALUES ('000017', '300006', '20191111', '2019-11-11', '安徽省-宣城市-宣州区-薰化路301号', '光棍节促销');
INSERT INTO `tb_goodinfo` VALUES ('000018', '300006', '20191111', '2019-11-11', '安徽省-宣城市-宣州区-薰化路301号', '光棍节促销');
INSERT INTO `tb_goodinfo` VALUES ('000019', '300007', '20191111', '2019-11-11', '安徽省-宣城市-宣州区-薰化路301号', '光棍节促销');
INSERT INTO `tb_goodinfo` VALUES ('000020', '300007', '20191111', '2019-11-11', '安徽省-宣城市-宣州区-薰化路301号', '光棍节促销');
INSERT INTO `tb_goodinfo` VALUES ('000021', '300007', '20191111', '2019-11-11', '安徽省-宣城市-宣州区-薰化路301号', '光棍节促销');
INSERT INTO `tb_goodinfo` VALUES ('000022', '300008', '20191111', '2019-11-11', '安徽省-宣城市-宣州区-薰化路301号', '光棍节促销');
INSERT INTO `tb_goodinfo` VALUES ('000023', '300008', '20191111', '2019-11-11', '安徽省-宣城市-宣州区-薰化路301号', '光棍节促销');
INSERT INTO `tb_goodinfo` VALUES ('000024', '300008', '20191111', '2019-11-11', '安徽省-宣城市-宣州区-薰化路301号', '光棍节促销');

INSERT INTO `tb_goodinfo` VALUES ('000001', '300001', '20191212', '2019-12-12', '安徽省-宣城市-宣州区-薰化路301号', '双12促销');
INSERT INTO `tb_goodinfo` VALUES ('000002', '300001', '20191212', '2019-12-12', '安徽省-宣城市-宣州区-薰化路301号', '双12促销');
INSERT INTO `tb_goodinfo` VALUES ('000003', '300001', '20191212', '2019-12-12', '安徽省-宣城市-宣州区-薰化路301号', '双12促销');
INSERT INTO `tb_goodinfo` VALUES ('000004', '300002', '20191212', '2019-12-12', '安徽省-宣城市-宣州区-薰化路301号', '双12促销');
INSERT INTO `tb_goodinfo` VALUES ('000005', '300002', '20191212', '2019-12-12', '安徽省-宣城市-宣州区-薰化路301号', '双12促销');
INSERT INTO `tb_goodinfo` VALUES ('000006', '300002', '20191212', '2019-12-12', '安徽省-宣城市-宣州区-薰化路301号', '双12促销');
INSERT INTO `tb_goodinfo` VALUES ('000007', '300003', '20191212', '2019-12-12', '安徽省-宣城市-宣州区-薰化路301号', '双12促销');
INSERT INTO `tb_goodinfo` VALUES ('000008', '300003', '20191212', '2019-12-12', '安徽省-宣城市-宣州区-薰化路301号', '双12促销');
INSERT INTO `tb_goodinfo` VALUES ('000009', '300003', '20191212', '2019-12-12', '安徽省-宣城市-宣州区-薰化路301号', '双12促销');
INSERT INTO `tb_goodinfo` VALUES ('000010', '300004', '20191212', '2019-12-12', '安徽省-宣城市-宣州区-薰化路301号', '双12促销');
INSERT INTO `tb_goodinfo` VALUES ('000011', '300004', '20191212', '2019-12-12', '安徽省-宣城市-宣州区-薰化路301号', '双12促销');
INSERT INTO `tb_goodinfo` VALUES ('000012', '300004', '20191212', '2019-12-12', '安徽省-宣城市-宣州区-薰化路301号', '双12促销');
INSERT INTO `tb_goodinfo` VALUES ('000013', '300005', '20191212', '2019-12-12', '安徽省-宣城市-宣州区-薰化路301号', '双12促销');
INSERT INTO `tb_goodinfo` VALUES ('000014', '300005', '20191212', '2019-12-12', '安徽省-宣城市-宣州区-薰化路301号', '双12促销');
INSERT INTO `tb_goodinfo` VALUES ('000015', '300005', '20191212', '2019-12-12', '安徽省-宣城市-宣州区-薰化路301号', '双12促销');
INSERT INTO `tb_goodinfo` VALUES ('000016', '300006', '20191212', '2019-12-12', '安徽省-宣城市-宣州区-薰化路301号', '双12促销');
INSERT INTO `tb_goodinfo` VALUES ('000017', '300006', '20191212', '2019-12-12', '安徽省-宣城市-宣州区-薰化路301号', '双12促销');
INSERT INTO `tb_goodinfo` VALUES ('000018', '300006', '20191212', '2019-12-12', '安徽省-宣城市-宣州区-薰化路301号', '双12促销');
INSERT INTO `tb_goodinfo` VALUES ('000019', '300007', '20191212', '2019-12-12', '安徽省-宣城市-宣州区-薰化路301号', '双12促销');
INSERT INTO `tb_goodinfo` VALUES ('000020', '300007', '20191212', '2019-12-12', '安徽省-宣城市-宣州区-薰化路301号', '双12促销');
INSERT INTO `tb_goodinfo` VALUES ('000021', '300007', '20191212', '2019-12-12', '安徽省-宣城市-宣州区-薰化路301号', '双12促销');
INSERT INTO `tb_goodinfo` VALUES ('000022', '300008', '20191212', '2019-12-12', '安徽省-宣城市-宣州区-薰化路301号', '双12促销');
INSERT INTO `tb_goodinfo` VALUES ('000023', '300008', '20191212', '2019-12-12', '安徽省-宣城市-宣州区-薰化路301号', '双12促销');
INSERT INTO `tb_goodinfo` VALUES ('000024', '300008', '20191212', '2019-12-12', '安徽省-宣城市-宣州区-薰化路301号', '双12促销');

INSERT INTO `tb_goodinfo` VALUES ('000001', '300001', '20200101', '2020-01-01', '安徽省-宣城市-宣州区-薰化路301号', '元旦促销');
INSERT INTO `tb_goodinfo` VALUES ('000002', '300001', '20200101', '2020-01-01', '安徽省-宣城市-宣州区-薰化路301号', '元旦促销');
INSERT INTO `tb_goodinfo` VALUES ('000003', '300001', '20200101', '2020-01-01', '安徽省-宣城市-宣州区-薰化路301号', '元旦促销');
INSERT INTO `tb_goodinfo` VALUES ('000004', '300002', '20200101', '2020-01-01', '安徽省-宣城市-宣州区-薰化路301号', '元旦促销');
INSERT INTO `tb_goodinfo` VALUES ('000005', '300002', '20200101', '2020-01-01', '安徽省-宣城市-宣州区-薰化路301号', '元旦促销');
INSERT INTO `tb_goodinfo` VALUES ('000006', '300002', '20200101', '2020-01-01', '安徽省-宣城市-宣州区-薰化路301号', '元旦促销');
INSERT INTO `tb_goodinfo` VALUES ('000007', '300003', '20200101', '2020-01-01', '安徽省-宣城市-宣州区-薰化路301号', '元旦促销');
INSERT INTO `tb_goodinfo` VALUES ('000008', '300003', '20200101', '2020-01-01', '安徽省-宣城市-宣州区-薰化路301号', '元旦促销');
INSERT INTO `tb_goodinfo` VALUES ('000009', '300003', '20200101', '2020-01-01', '安徽省-宣城市-宣州区-薰化路301号', '元旦促销');
INSERT INTO `tb_goodinfo` VALUES ('000010', '300004', '20200101', '2020-01-01', '安徽省-宣城市-宣州区-薰化路301号', '元旦促销');
INSERT INTO `tb_goodinfo` VALUES ('000011', '300004', '20200101', '2020-01-01', '安徽省-宣城市-宣州区-薰化路301号', '元旦促销');
INSERT INTO `tb_goodinfo` VALUES ('000012', '300004', '20200101', '2020-01-01', '安徽省-宣城市-宣州区-薰化路301号', '元旦促销');
INSERT INTO `tb_goodinfo` VALUES ('000013', '300005', '20200101', '2020-01-01', '安徽省-宣城市-宣州区-薰化路301号', '元旦促销');
INSERT INTO `tb_goodinfo` VALUES ('000014', '300005', '20200101', '2020-01-01', '安徽省-宣城市-宣州区-薰化路301号', '元旦促销');
INSERT INTO `tb_goodinfo` VALUES ('000015', '300005', '20200101', '2020-01-01', '安徽省-宣城市-宣州区-薰化路301号', '元旦促销');
INSERT INTO `tb_goodinfo` VALUES ('000016', '300006', '20200101', '2020-01-01', '安徽省-宣城市-宣州区-薰化路301号', '元旦促销');
INSERT INTO `tb_goodinfo` VALUES ('000017', '300006', '20200101', '2020-01-01', '安徽省-宣城市-宣州区-薰化路301号', '元旦促销');
INSERT INTO `tb_goodinfo` VALUES ('000018', '300006', '20200101', '2020-01-01', '安徽省-宣城市-宣州区-薰化路301号', '元旦促销');
INSERT INTO `tb_goodinfo` VALUES ('000019', '300007', '20200101', '2020-01-01', '安徽省-宣城市-宣州区-薰化路301号', '元旦促销');
INSERT INTO `tb_goodinfo` VALUES ('000020', '300007', '20200101', '2020-01-01', '安徽省-宣城市-宣州区-薰化路301号', '元旦促销');
INSERT INTO `tb_goodinfo` VALUES ('000021', '300007', '20200101', '2020-01-01', '安徽省-宣城市-宣州区-薰化路301号', '元旦促销');
INSERT INTO `tb_goodinfo` VALUES ('000022', '300008', '20200101', '2020-01-01', '安徽省-宣城市-宣州区-薰化路301号', '元旦促销');
INSERT INTO `tb_goodinfo` VALUES ('000023', '300008', '20200101', '2020-01-01', '安徽省-宣城市-宣州区-薰化路301号', '元旦促销');
INSERT INTO `tb_goodinfo` VALUES ('000024', '300008', '20200101', '2020-01-01', '安徽省-宣城市-宣州区-薰化路301号', '元旦促销');
-- 同一商品不同供应商
INSERT INTO `tb_goodinfo` VALUES ('000001', '300003', '20191111', '2019-11-11', '安徽省-宣城市-宣州区-薰化路301号', '光棍节促销');
INSERT INTO `tb_goodinfo` VALUES ('000002', '300003', '20191111', '2019-11-11', '安徽省-宣城市-宣州区-薰化路301号', '光棍节促销');
INSERT INTO `tb_goodinfo` VALUES ('000003', '300003', '20191111', '2019-11-11', '安徽省-宣城市-宣州区-薰化路301号', '光棍节促销');
INSERT INTO `tb_goodinfo` VALUES ('000013', '300006', '20191111', '2019-11-11', '安徽省-宣城市-宣州区-薰化路301号', '光棍节促销');
INSERT INTO `tb_goodinfo` VALUES ('000014', '300006', '20191111', '2019-11-11', '安徽省-宣城市-宣州区-薰化路301号', '光棍节促销');
INSERT INTO `tb_goodinfo` VALUES ('000015', '300006', '20191111', '2019-11-11', '安徽省-宣城市-宣州区-薰化路301号', '光棍节促销');

INSERT INTO `tb_goodinfo` VALUES ('000001', '300003', '20191212', '2019-12-12', '安徽省-宣城市-宣州区-薰化路301号', '双12促销');
INSERT INTO `tb_goodinfo` VALUES ('000002', '300003', '20191212', '2019-12-12', '安徽省-宣城市-宣州区-薰化路301号', '双12促销');
INSERT INTO `tb_goodinfo` VALUES ('000003', '300003', '20191212', '2019-12-12', '安徽省-宣城市-宣州区-薰化路301号', '双12促销');
INSERT INTO `tb_goodinfo` VALUES ('000013', '300006', '20191212', '2019-12-12', '安徽省-宣城市-宣州区-薰化路301号', '双12促销');
INSERT INTO `tb_goodinfo` VALUES ('000014', '300006', '20191212', '2019-12-12', '安徽省-宣城市-宣州区-薰化路301号', '双12促销');
INSERT INTO `tb_goodinfo` VALUES ('000015', '300006', '20191212', '2019-12-12', '安徽省-宣城市-宣州区-薰化路301号', '双12促销');

INSERT INTO `tb_goodinfo` VALUES ('000001', '300003', '20200101', '2020-01-01', '安徽省-宣城市-宣州区-薰化路301号', '元旦促销');
INSERT INTO `tb_goodinfo` VALUES ('000002', '300003', '20200101', '2020-01-01', '安徽省-宣城市-宣州区-薰化路301号', '元旦促销');
INSERT INTO `tb_goodinfo` VALUES ('000003', '300003', '20200101', '2020-01-01', '安徽省-宣城市-宣州区-薰化路301号', '元旦促销');
INSERT INTO `tb_goodinfo` VALUES ('000013', '300006', '20200101', '2020-01-01', '安徽省-宣城市-宣州区-薰化路301号', '元旦促销');
INSERT INTO `tb_goodinfo` VALUES ('000014', '300006', '20200101', '2020-01-01', '安徽省-宣城市-宣州区-薰化路301号', '元旦促销');
INSERT INTO `tb_goodinfo` VALUES ('000015', '300006', '20200101', '2020-01-01', '安徽省-宣城市-宣州区-薰化路301号', '元旦促销');

-- ----------------------------
-- ********促销测试数据********
-- Records of tb_discount
-- ----------------------------
INSERT INTO `tb_discount` VALUES ('000001', '20191111', '1.00',  '2019-12-14', '2019-12-24', '');
INSERT INTO `tb_discount` VALUES ('000004', '20191111', '3.00',  '2019-12-14', '2019-12-24', '');
INSERT INTO `tb_discount` VALUES ('000007', '20191111', '1.50',  '2019-12-14', '2019-12-24', '');
INSERT INTO `tb_discount` VALUES ('000010', '20191111', '53.00', '2019-12-14', '2019-12-24', '');
INSERT INTO `tb_discount` VALUES ('000013', '20191111', '1.50',  '2019-12-14', '2019-12-24', '');
INSERT INTO `tb_discount` VALUES ('000016', '20191111', '13.00', '2019-12-14', '2019-12-24', '');
INSERT INTO `tb_discount` VALUES ('000019', '20191111', '31.50', '2019-12-14', '2019-12-24', '');
INSERT INTO `tb_discount` VALUES ('000022', '20191111', '98.00', '2019-12-14', '2019-12-24', '');

INSERT INTO `tb_discount` VALUES ('000001', '20191212', '1.00',  '2020-01-03', '2020-01-13', '');
INSERT INTO `tb_discount` VALUES ('000004', '20191212', '3.00',  '2020-01-03', '2020-01-13', '');
INSERT INTO `tb_discount` VALUES ('000007', '20191212', '1.50',  '2020-01-03', '2020-01-13', '');
INSERT INTO `tb_discount` VALUES ('000010', '20191212', '53.00', '2020-01-03', '2020-01-13', '');
INSERT INTO `tb_discount` VALUES ('000013', '20191212', '1.50',  '2020-01-03', '2020-01-13', '');
INSERT INTO `tb_discount` VALUES ('000016', '20191212', '13.00', '2020-01-03', '2020-01-13', '');
INSERT INTO `tb_discount` VALUES ('000019', '20191212', '31.50', '2020-01-03', '2020-01-13', '');
INSERT INTO `tb_discount` VALUES ('000022', '20191212', '98.00', '2020-01-03', '2020-01-13', '');

-- ----------------------------
-- *******仓库测试数据*********
-- Records of tb_store
-- ----------------------------
INSERT INTO `tb_store` VALUES ('400001', '新安仓', DEFAULT, DEFAULT, '100001', '10010', '安徽省-宣城市-宣州区-薰化路301号', '');
INSERT INTO `tb_store` VALUES ('400002', '敬亭仓', DEFAULT, DEFAULT, '100002', '10086', '安徽省-宣城市-宣州区-薰化路301号', '');

-- ----------------------------
-- *******采购测试数据*********
-- Records of tb_buys
-- Records of tb_buy
-- ----------------------------
-- 商品对应供应商
-- 2019.11.11
INSERT INTO `tb_buys` VALUES ('201911110001', '000001', '300001', '20191111', '1.00',  '200', '光棍节采购');
INSERT INTO `tb_buys` VALUES ('201911110001', '000002', '300001', '20191111', '1.00',  '300', '光棍节采购');
INSERT INTO `tb_buys` VALUES ('201911110001', '000003', '300001', '20191111', '0.50',  '100', '光棍节采购');
INSERT INTO `tb_buys` VALUES ('201911110001', '000004', '300002', '20191111', '2.00',  '100', '光棍节采购');
INSERT INTO `tb_buys` VALUES ('201911110001', '000005', '300002', '20191111', '30.00', '200', '光棍节采购');
INSERT INTO `tb_buys` VALUES ('201911110001', '000006', '300002', '20191111', '2.00',  '100', '光棍节采购');
INSERT INTO `tb_buys` VALUES ('201911110001', '000007', '300003', '20191111', '1.00',  '300', '光棍节采购');
INSERT INTO `tb_buys` VALUES ('201911110001', '000008', '300003', '20191111', '1.00',  '100', '光棍节采购');
INSERT INTO `tb_buys` VALUES ('201911110001', '000009', '300003', '20191111', '1.00',  '200', '光棍节采购');
INSERT INTO `tb_buys` VALUES ('201911110001', '000010', '300004', '20191111', '25.00', '100', '光棍节采购');
INSERT INTO `tb_buys` VALUES ('201911110001', '000011', '300004', '20191111', '10.00', '100', '光棍节采购');
INSERT INTO `tb_buys` VALUES ('201911110001', '000012', '300004', '20191111', '6.00',  '100', '光棍节采购');
INSERT INTO `tb_buys` VALUES ('201911110002', '000013', '300005', '20191111', '1.50',  '100', '光棍节采购');
INSERT INTO `tb_buys` VALUES ('201911110002', '000014', '300005', '20191111', '1.50',  '300', '光棍节采购');
INSERT INTO `tb_buys` VALUES ('201911110002', '000015', '300005', '20191111', '2.00',  '200', '光棍节采购');
INSERT INTO `tb_buys` VALUES ('201911110002', '000016', '300006', '20191111', '10.00', '300', '光棍节采购');
INSERT INTO `tb_buys` VALUES ('201911110002', '000017', '300006', '20191111', '3.00',  '200', '光棍节采购');
INSERT INTO `tb_buys` VALUES ('201911110002', '000018', '300006', '20191111', '6.00',  '500', '光棍节采购');
INSERT INTO `tb_buys` VALUES ('201911110002', '000019', '300007', '20191111', '28.50', '400', '光棍节采购');
INSERT INTO `tb_buys` VALUES ('201911110002', '000020', '300007', '20191111', '8.50',  '300', '光棍节采购');
INSERT INTO `tb_buys` VALUES ('201911110002', '000021', '300007', '20191111', '13.50', '500', '光棍节采购');
INSERT INTO `tb_buys` VALUES ('201911110002', '000022', '300008', '20191111', '80.00', '400', '光棍节采购');
INSERT INTO `tb_buys` VALUES ('201911110002', '000023', '300008', '20191111', '75.00', '300', '光棍节采购');
INSERT INTO `tb_buys` VALUES ('201911110002', '000024', '300008', '20191111', '85.00', '200', '光棍节采购');

-- 2019.11.24
INSERT INTO `tb_buys` VALUES ('201911240001', '000001', '300001', '20191111', '1.00',  '200', '十一月采购');
INSERT INTO `tb_buys` VALUES ('201911240001', '000002', '300001', '20191111', '1.00',  '300', '十一月采购');
INSERT INTO `tb_buys` VALUES ('201911240001', '000003', '300001', '20191111', '0.50',  '100', '十一月采购');
INSERT INTO `tb_buys` VALUES ('201911240001', '000004', '300002', '20191111', '2.00',  '100', '十一月采购');
INSERT INTO `tb_buys` VALUES ('201911240001', '000005', '300002', '20191111', '30.00', '200', '十一月采购');
INSERT INTO `tb_buys` VALUES ('201911240001', '000006', '300002', '20191111', '2.00',  '100', '十一月采购');
INSERT INTO `tb_buys` VALUES ('201911240001', '000007', '300003', '20191111', '1.00',  '300', '十一月采购');
INSERT INTO `tb_buys` VALUES ('201911240001', '000008', '300003', '20191111', '1.00',  '100', '十一月采购');
INSERT INTO `tb_buys` VALUES ('201911240001', '000009', '300003', '20191111', '1.00',  '200', '十一月采购');
INSERT INTO `tb_buys` VALUES ('201911240001', '000010', '300004', '20191111', '25.00', '100', '十一月采购');
INSERT INTO `tb_buys` VALUES ('201911240001', '000011', '300004', '20191111', '10.00', '100', '十一月采购');
INSERT INTO `tb_buys` VALUES ('201911240001', '000012', '300004', '20191111', '6.00',  '100', '十一月采购');
INSERT INTO `tb_buys` VALUES ('201911240002', '000013', '300005', '20191111', '1.50',  '100', '十一月采购');
INSERT INTO `tb_buys` VALUES ('201911240002', '000014', '300005', '20191111', '1.50',  '300', '十一月采购');
INSERT INTO `tb_buys` VALUES ('201911240002', '000015', '300005', '20191111', '2.00',  '200', '十一月采购');
INSERT INTO `tb_buys` VALUES ('201911240002', '000016', '300006', '20191111', '10.00', '300', '十一月采购');
INSERT INTO `tb_buys` VALUES ('201911240002', '000017', '300006', '20191111', '3.00',  '200', '十一月采购');
INSERT INTO `tb_buys` VALUES ('201911240002', '000018', '300006', '20191111', '6.00',  '500', '十一月采购');
INSERT INTO `tb_buys` VALUES ('201911240002', '000019', '300007', '20191111', '28.50', '400', '十一月采购');
INSERT INTO `tb_buys` VALUES ('201911240002', '000020', '300007', '20191111', '8.50',  '300', '十一月采购');
INSERT INTO `tb_buys` VALUES ('201911240002', '000021', '300007', '20191111', '13.50', '500', '十一月采购');
INSERT INTO `tb_buys` VALUES ('201911240002', '000022', '300008', '20191111', '80.00', '400', '十一月采购');
INSERT INTO `tb_buys` VALUES ('201911240002', '000023', '300008', '20191111', '75.00', '300', '十一月采购');
INSERT INTO `tb_buys` VALUES ('201911240002', '000024', '300008', '20191111', '85.00', '200', '十一月采购');

-- 2019.12.12
INSERT INTO `tb_buys` VALUES ('201912120001', '000001', '300001', '20191212', '1.00',  '200', '双12采购');
INSERT INTO `tb_buys` VALUES ('201912120001', '000002', '300001', '20191212', '1.00',  '300', '双12采购');
INSERT INTO `tb_buys` VALUES ('201912120001', '000003', '300001', '20191212', '0.50',  '100', '双12采购');
INSERT INTO `tb_buys` VALUES ('201912120001', '000004', '300002', '20191212', '2.00',  '100', '双12采购');
INSERT INTO `tb_buys` VALUES ('201912120001', '000005', '300002', '20191212', '30.00', '200', '双12采购');
INSERT INTO `tb_buys` VALUES ('201912120001', '000006', '300002', '20191212', '2.00',  '100', '双12采购');
INSERT INTO `tb_buys` VALUES ('201912120001', '000007', '300003', '20191212', '1.00',  '300', '双12采购');
INSERT INTO `tb_buys` VALUES ('201912120001', '000008', '300003', '20191212', '1.00',  '100', '双12采购');
INSERT INTO `tb_buys` VALUES ('201912120001', '000009', '300003', '20191212', '1.00',  '200', '双12采购');
INSERT INTO `tb_buys` VALUES ('201912120001', '000010', '300004', '20191212', '25.00', '100', '双12采购');
INSERT INTO `tb_buys` VALUES ('201912120001', '000011', '300004', '20191212', '10.00', '100', '双12采购');
INSERT INTO `tb_buys` VALUES ('201912120001', '000012', '300004', '20191212', '6.00',  '100', '双12采购');
INSERT INTO `tb_buys` VALUES ('201912120002', '000013', '300005', '20191212', '1.50',  '100', '双12采购');
INSERT INTO `tb_buys` VALUES ('201912120002', '000014', '300005', '20191212', '1.50',  '300', '双12采购');
INSERT INTO `tb_buys` VALUES ('201912120002', '000015', '300005', '20191212', '2.00',  '200', '双12采购');
INSERT INTO `tb_buys` VALUES ('201912120002', '000016', '300006', '20191212', '10.00', '300', '双12采购');
INSERT INTO `tb_buys` VALUES ('201912120002', '000017', '300006', '20191212', '3.00',  '200', '双12采购');
INSERT INTO `tb_buys` VALUES ('201912120002', '000018', '300006', '20191212', '6.00',  '500', '双12采购');
INSERT INTO `tb_buys` VALUES ('201912120002', '000019', '300007', '20191212', '28.50', '400', '双12采购');
INSERT INTO `tb_buys` VALUES ('201912120002', '000020', '300007', '20191212', '8.50',  '300', '双12采购');
INSERT INTO `tb_buys` VALUES ('201912120002', '000021', '300007', '20191212', '13.50', '500', '双12采购');
INSERT INTO `tb_buys` VALUES ('201912120002', '000022', '300008', '20191212', '80.00', '400', '双12采购');
INSERT INTO `tb_buys` VALUES ('201912120002', '000023', '300008', '20191212', '75.00', '300', '双12采购');
INSERT INTO `tb_buys` VALUES ('201912120002', '000024', '300008', '20191212', '85.00', '200', '双12采购');

-- 2019.12.25
INSERT INTO `tb_buys` VALUES ('201912250001', '000001', '300001', '20191212', '1.00',  '200', '十二月采购');
INSERT INTO `tb_buys` VALUES ('201912250001', '000002', '300001', '20191212', '1.00',  '300', '十二月采购');
INSERT INTO `tb_buys` VALUES ('201912250001', '000003', '300001', '20191212', '0.50',  '100', '十二月采购');
INSERT INTO `tb_buys` VALUES ('201912250001', '000004', '300002', '20191212', '2.00',  '100', '十二月采购');
INSERT INTO `tb_buys` VALUES ('201912250001', '000005', '300002', '20191212', '30.00', '200', '十二月采购');
INSERT INTO `tb_buys` VALUES ('201912250001', '000006', '300002', '20191212', '2.00',  '100', '十二月采购');
INSERT INTO `tb_buys` VALUES ('201912250001', '000007', '300003', '20191212', '1.00',  '300', '十二月采购');
INSERT INTO `tb_buys` VALUES ('201912250001', '000008', '300003', '20191212', '1.00',  '100', '十二月采购');
INSERT INTO `tb_buys` VALUES ('201912250001', '000009', '300003', '20191212', '1.00',  '200', '十二月采购');
INSERT INTO `tb_buys` VALUES ('201912250001', '000010', '300004', '20191212', '25.00', '100', '十二月采购');
INSERT INTO `tb_buys` VALUES ('201912250001', '000011', '300004', '20191212', '10.00', '100', '十二月采购');
INSERT INTO `tb_buys` VALUES ('201912250001', '000012', '300004', '20191212', '6.00',  '100', '十二月采购');
INSERT INTO `tb_buys` VALUES ('201912250002', '000013', '300005', '20191212', '1.50',  '100', '十二月采购');
INSERT INTO `tb_buys` VALUES ('201912250002', '000014', '300005', '20191212', '1.50',  '300', '十二月采购');
INSERT INTO `tb_buys` VALUES ('201912250002', '000015', '300005', '20191212', '2.00',  '200', '十二月采购');
INSERT INTO `tb_buys` VALUES ('201912250002', '000016', '300006', '20191212', '10.00', '300', '十二月采购');
INSERT INTO `tb_buys` VALUES ('201912250002', '000017', '300006', '20191212', '3.00',  '200', '十二月采购');
INSERT INTO `tb_buys` VALUES ('201912250002', '000018', '300006', '20191212', '6.00',  '500', '十二月采购');
INSERT INTO `tb_buys` VALUES ('201912250002', '000019', '300007', '20191212', '28.50', '400', '十二月采购');
INSERT INTO `tb_buys` VALUES ('201912250002', '000020', '300007', '20191212', '8.50',  '300', '十二月采购');
INSERT INTO `tb_buys` VALUES ('201912250002', '000021', '300007', '20191212', '13.50', '500', '十二月采购');
INSERT INTO `tb_buys` VALUES ('201912250002', '000022', '300008', '20191212', '80.00', '400', '十二月采购');
INSERT INTO `tb_buys` VALUES ('201912250002', '000023', '300008', '20191212', '75.00', '300', '十二月采购');
INSERT INTO `tb_buys` VALUES ('201912250002', '000024', '300008', '20191212', '85.00', '200', '十二月采购');

-- 2020.01.01
INSERT INTO `tb_buys` VALUES ('202001010001', '000001', '300001', '20200101', '1.00',  '200', '元旦采购');
INSERT INTO `tb_buys` VALUES ('202001010001', '000002', '300001', '20200101', '1.00',  '300', '元旦采购');
INSERT INTO `tb_buys` VALUES ('202001010001', '000003', '300001', '20200101', '0.50',  '100', '元旦采购');
INSERT INTO `tb_buys` VALUES ('202001010001', '000004', '300002', '20200101', '2.00',  '100', '元旦采购');
INSERT INTO `tb_buys` VALUES ('202001010001', '000005', '300002', '20200101', '30.00', '200', '元旦采购');
INSERT INTO `tb_buys` VALUES ('202001010001', '000006', '300002', '20200101', '2.00',  '100', '元旦采购');
INSERT INTO `tb_buys` VALUES ('202001010001', '000007', '300003', '20200101', '1.00',  '300', '元旦采购');
INSERT INTO `tb_buys` VALUES ('202001010001', '000008', '300003', '20200101', '1.00',  '100', '元旦采购');
INSERT INTO `tb_buys` VALUES ('202001010001', '000009', '300003', '20200101', '1.00',  '200', '元旦采购');
INSERT INTO `tb_buys` VALUES ('202001010001', '000010', '300004', '20200101', '25.00', '100', '元旦采购');
INSERT INTO `tb_buys` VALUES ('202001010001', '000011', '300004', '20200101', '10.00', '100', '元旦采购');
INSERT INTO `tb_buys` VALUES ('202001010001', '000012', '300004', '20200101', '6.00',  '100', '元旦采购');
INSERT INTO `tb_buys` VALUES ('202001010002', '000013', '300005', '20200101', '1.50',  '100', '元旦采购');
INSERT INTO `tb_buys` VALUES ('202001010002', '000014', '300005', '20200101', '1.50',  '300', '元旦采购');
INSERT INTO `tb_buys` VALUES ('202001010002', '000015', '300005', '20200101', '2.00',  '200', '元旦采购');
INSERT INTO `tb_buys` VALUES ('202001010002', '000016', '300006', '20200101', '10.00', '300', '元旦采购');
INSERT INTO `tb_buys` VALUES ('202001010002', '000017', '300006', '20200101', '3.00',  '200', '元旦采购');
INSERT INTO `tb_buys` VALUES ('202001010002', '000018', '300006', '20200101', '6.00',  '500', '元旦采购');
INSERT INTO `tb_buys` VALUES ('202001010002', '000019', '300007', '20200101', '28.50', '400', '元旦采购');
INSERT INTO `tb_buys` VALUES ('202001010002', '000020', '300007', '20200101', '8.50',  '300', '元旦采购');
INSERT INTO `tb_buys` VALUES ('202001010002', '000021', '300007', '20200101', '13.50', '500', '元旦采购');
INSERT INTO `tb_buys` VALUES ('202001010002', '000022', '300008', '20200101', '80.00', '400', '元旦采购');
INSERT INTO `tb_buys` VALUES ('202001010002', '000023', '300008', '20200101', '75.00', '300', '元旦采购');
INSERT INTO `tb_buys` VALUES ('202001010002', '000024', '300008', '20200101', '85.00', '200', '元旦采购');

-- 2020.01.14
INSERT INTO `tb_buys` VALUES ('202001140001', '000001', '300001', '202000101', '1.00',  '200', '一月采购');
INSERT INTO `tb_buys` VALUES ('202001140001', '000002', '300001', '202000101', '1.00',  '300', '一月采购');
INSERT INTO `tb_buys` VALUES ('202001140001', '000003', '300001', '202000101', '0.50',  '100', '一月采购');
INSERT INTO `tb_buys` VALUES ('202001140001', '000004', '300002', '202000101', '2.00',  '100', '一月采购');
INSERT INTO `tb_buys` VALUES ('202001140001', '000005', '300002', '202000101', '30.00', '200', '一月采购');
INSERT INTO `tb_buys` VALUES ('202001140001', '000006', '300002', '202000101', '2.00',  '100', '一月采购');
INSERT INTO `tb_buys` VALUES ('202001140001', '000007', '300003', '202000101', '1.00',  '300', '一月采购');
INSERT INTO `tb_buys` VALUES ('202001140001', '000008', '300003', '202000101', '1.00',  '100', '一月采购');
INSERT INTO `tb_buys` VALUES ('202001140001', '000009', '300003', '202000101', '1.00',  '200', '一月采购');
INSERT INTO `tb_buys` VALUES ('202001140001', '000010', '300004', '202000101', '25.00', '100', '一月采购');
INSERT INTO `tb_buys` VALUES ('202001140001', '000011', '300004', '202000101', '10.00', '100', '一月采购');
INSERT INTO `tb_buys` VALUES ('202001140001', '000012', '300004', '202000101', '6.00',  '100', '一月采购');
INSERT INTO `tb_buys` VALUES ('202001140002', '000013', '300005', '202000101', '1.50',  '100', '一月采购');
INSERT INTO `tb_buys` VALUES ('202001140002', '000014', '300005', '202000101', '1.50',  '300', '一月采购');
INSERT INTO `tb_buys` VALUES ('202001140002', '000015', '300005', '202000101', '2.00',  '200', '一月采购');
INSERT INTO `tb_buys` VALUES ('202001140002', '000016', '300006', '202000101', '10.00', '300', '一月采购');
INSERT INTO `tb_buys` VALUES ('202001140002', '000017', '300006', '202000101', '3.00',  '200', '一月采购');
INSERT INTO `tb_buys` VALUES ('202001140002', '000018', '300006', '202000101', '6.00',  '500', '一月采购');
INSERT INTO `tb_buys` VALUES ('202001140002', '000019', '300007', '202000101', '28.50', '400', '一月采购');
INSERT INTO `tb_buys` VALUES ('202001140002', '000020', '300007', '202000101', '8.50',  '300', '一月采购');
INSERT INTO `tb_buys` VALUES ('202001140002', '000021', '300007', '202000101', '13.50', '500', '一月采购');
INSERT INTO `tb_buys` VALUES ('202001140002', '000022', '300008', '202000101', '80.00', '400', '一月采购');
INSERT INTO `tb_buys` VALUES ('202001140002', '000023', '300008', '202000101', '75.00', '300', '一月采购');
INSERT INTO `tb_buys` VALUES ('202001140002', '000024', '300008', '202000101', '85.00', '200', '一月采购');

-- 同一商品不同供应商
INSERT INTO `tb_buys` VALUES ('201911110001', '000001', '300003', '20191111', '1.50', '100', '光棍节采购');
INSERT INTO `tb_buys` VALUES ('201911110001', '000002', '300003', '20191111', '1.50', '200', '光棍节采购');
INSERT INTO `tb_buys` VALUES ('201911110001', '000003', '300003', '20191111', '1.00', '300', '光棍节采购');
INSERT INTO `tb_buys` VALUES ('201911110001', '000013', '300006', '20191111', '2.00', '400', '光棍节采购');
INSERT INTO `tb_buys` VALUES ('201911110001', '000014', '300006', '20191111', '2.00', '500', '光棍节采购');
INSERT INTO `tb_buys` VALUES ('201911110001', '000015', '300006', '20191111', '2.00', '600', '光棍节采购');

INSERT INTO `tb_buys` VALUES ('201912120001', '000001', '300003', '20191212', '1.50', '100', '双12采购');
INSERT INTO `tb_buys` VALUES ('201912120001', '000002', '300003', '20191212', '1.50', '200', '双12采购');
INSERT INTO `tb_buys` VALUES ('201912120001', '000003', '300003', '20191212', '1.00', '300', '双12采购');
INSERT INTO `tb_buys` VALUES ('201912120001', '000013', '300006', '20191212', '2.00', '400', '双12采购');
INSERT INTO `tb_buys` VALUES ('201912120001', '000014', '300006', '20191212', '2.00', '500', '双12采购');
INSERT INTO `tb_buys` VALUES ('201912120001', '000015', '300006', '20191212', '2.00', '600', '双12采购');

INSERT INTO `tb_buys` VALUES ('202001010001', '000001', '300003', '20200101', '1.50', '100', '元旦采购');
INSERT INTO `tb_buys` VALUES ('202001010001', '000002', '300003', '20200101', '1.50', '200', '元旦采购');
INSERT INTO `tb_buys` VALUES ('202001010001', '000003', '300003', '20200101', '1.00', '300', '元旦采购');
INSERT INTO `tb_buys` VALUES ('202001010001', '000013', '300006', '20200101', '2.00', '400', '元旦采购');
INSERT INTO `tb_buys` VALUES ('202001010001', '000014', '300006', '20200101', '2.00', '500', '元旦采购');
INSERT INTO `tb_buys` VALUES ('202001010001', '000015', '300006', '20200101', '2.00', '600', '元旦采购');

-- 采购记录
INSERT INTO `tb_buy`  VALUES ('201911110001', '4000', '15400.00', '2019-11-11', '100001', '光棍节采购');
INSERT INTO `tb_buy`  VALUES ('201911110002', '3700', '99800.00', '2019-11-11', '100001', '光棍节采购');
INSERT INTO `tb_buy`  VALUES ('201911240001', '1900', '11650.00', '2019-11-24', '100001', '11月采购');
INSERT INTO `tb_buy`  VALUES ('201911240002', '3700', '99800.00', '2019-11-24', '100001', '11月采购');
INSERT INTO `tb_buy`  VALUES ('201912120001', '4000', '15400.00', '2019-12-12', '100002', '双12节采购');
INSERT INTO `tb_buy`  VALUES ('201912120002', '3700', '99800.00', '2019-12-12', '100002', '双12节采购');
INSERT INTO `tb_buy`  VALUES ('201912250001', '1900', '11650.00', '2019-12-25', '100002', '12月采购');
INSERT INTO `tb_buy`  VALUES ('201912250002', '3700', '99800.00', '2019-12-25', '100002', '12月采购');
INSERT INTO `tb_buy`  VALUES ('202001010001', '4000', '15400.00', '2020-01-01', '100003', '元旦采购');
INSERT INTO `tb_buy`  VALUES ('202001010002', '3700', '99800.00', '2020-01-01', '100003', '元旦采购');
INSERT INTO `tb_buy`  VALUES ('202001140001', '1900', '11650.00', '2020-01-14', '100003', '1月采购');
INSERT INTO `tb_buy`  VALUES ('202001140002', '3700', '99800.00', '2020-01-14', '100003', '1月采购');

-- buysID 采购编号  buyTotal 采购总数 buyAcount 采购总价  buyDate 采购日期  userID 用户编号 note 备注

-- ----------------------------
-- ********入库测试数据********
-- Records of tb_instocks
-- Records of tb_instock
-- ----------------------------
-- 2019.11.11
INSERT INTO `tb_instocks` VALUES ('201911110001', '400001', '000001', '300001', '20191111', '200', '光棍节入库');
INSERT INTO `tb_instocks` VALUES ('201911110001', '400001', '000002', '300001', '20191111', '300', '光棍节入库');
INSERT INTO `tb_instocks` VALUES ('201911110001', '400001', '000003', '300001', '20191111', '100', '光棍节入库');
INSERT INTO `tb_instocks` VALUES ('201911110001', '400001', '000004', '300002', '20191111', '100', '光棍节入库');
INSERT INTO `tb_instocks` VALUES ('201911110001', '400001', '000005', '300002', '20191111', '200', '光棍节入库');
INSERT INTO `tb_instocks` VALUES ('201911110001', '400001', '000006', '300002', '20191111', '100', '光棍节入库');
INSERT INTO `tb_instocks` VALUES ('201911110001', '400001', '000007', '300003', '20191111', '300', '光棍节入库');
INSERT INTO `tb_instocks` VALUES ('201911110001', '400001', '000008', '300003', '20191111', '100', '光棍节入库');
INSERT INTO `tb_instocks` VALUES ('201911110001', '400001', '000009', '300003', '20191111', '200', '光棍节入库');
INSERT INTO `tb_instocks` VALUES ('201911110001', '400001', '000010', '300004', '20191111', '100', '光棍节入库');
INSERT INTO `tb_instocks` VALUES ('201911110001', '400001', '000011', '300004', '20191111', '100', '光棍节入库');
INSERT INTO `tb_instocks` VALUES ('201911110001', '400001', '000012', '300004', '20191111', '100', '光棍节入库');
INSERT INTO `tb_instocks` VALUES ('201911110002', '400002', '000013', '300005', '20191111', '100', '光棍节入库');
INSERT INTO `tb_instocks` VALUES ('201911110002', '400002', '000014', '300005', '20191111', '300', '光棍节入库');
INSERT INTO `tb_instocks` VALUES ('201911110002', '400002', '000015', '300005', '20191111', '200', '光棍节入库');
INSERT INTO `tb_instocks` VALUES ('201911110002', '400002', '000016', '300006', '20191111', '300', '光棍节入库');
INSERT INTO `tb_instocks` VALUES ('201911110002', '400002', '000017', '300006', '20191111', '200', '光棍节入库');
INSERT INTO `tb_instocks` VALUES ('201911110002', '400002', '000018', '300006', '20191111', '500', '光棍节入库');
INSERT INTO `tb_instocks` VALUES ('201911110002', '400002', '000019', '300007', '20191111', '400', '光棍节入库');
INSERT INTO `tb_instocks` VALUES ('201911110002', '400002', '000020', '300007', '20191111', '300', '光棍节入库');
INSERT INTO `tb_instocks` VALUES ('201911110002', '400002', '000021', '300007', '20191111', '500', '光棍节入库');
INSERT INTO `tb_instocks` VALUES ('201911110002', '400002', '000022', '300008', '20191111', '400', '光棍节入库');
INSERT INTO `tb_instocks` VALUES ('201911110002', '400002', '000023', '300008', '20191111', '300', '光棍节入库');
INSERT INTO `tb_instocks` VALUES ('201911110002', '400002', '000024', '300008', '20191111', '200', '光棍节入库');

-- 2019.11.24
INSERT INTO `tb_instocks` VALUES ('201911240001', '400001', '000001', '300001', '20191111', '200', '十一月入库');
INSERT INTO `tb_instocks` VALUES ('201911240001', '400001', '000002', '300001', '20191111', '300', '十一月入库');
INSERT INTO `tb_instocks` VALUES ('201911240001', '400001', '000003', '300001', '20191111', '100', '十一月入库');
INSERT INTO `tb_instocks` VALUES ('201911240001', '400001', '000004', '300002', '20191111', '100', '十一月入库');
INSERT INTO `tb_instocks` VALUES ('201911240001', '400001', '000005', '300002', '20191111', '200', '十一月入库');
INSERT INTO `tb_instocks` VALUES ('201911240001', '400001', '000006', '300002', '20191111', '100', '十一月入库');
INSERT INTO `tb_instocks` VALUES ('201911240001', '400001', '000007', '300003', '20191111', '300', '十一月入库');
INSERT INTO `tb_instocks` VALUES ('201911240001', '400001', '000008', '300003', '20191111', '100', '十一月入库');
INSERT INTO `tb_instocks` VALUES ('201911240001', '400001', '000009', '300003', '20191111', '200', '十一月入库');
INSERT INTO `tb_instocks` VALUES ('201911240001', '400001', '000010', '300004', '20191111', '100', '十一月入库');
INSERT INTO `tb_instocks` VALUES ('201911240001', '400001', '000011', '300004', '20191111', '100', '十一月入库');
INSERT INTO `tb_instocks` VALUES ('201911240001', '400001', '000012', '300004', '20191111', '100', '十一月入库');
INSERT INTO `tb_instocks` VALUES ('201911240002', '400002', '000013', '300005', '20191111', '100', '十一月入库');
INSERT INTO `tb_instocks` VALUES ('201911240002', '400002', '000014', '300005', '20191111', '300', '十一月入库');
INSERT INTO `tb_instocks` VALUES ('201911240002', '400002', '000015', '300005', '20191111', '200', '十一月入库');
INSERT INTO `tb_instocks` VALUES ('201911240002', '400002', '000016', '300006', '20191111', '300', '十一月入库');
INSERT INTO `tb_instocks` VALUES ('201911240002', '400002', '000017', '300006', '20191111', '200', '十一月入库');
INSERT INTO `tb_instocks` VALUES ('201911240002', '400002', '000018', '300006', '20191111', '500', '十一月入库');
INSERT INTO `tb_instocks` VALUES ('201911240002', '400002', '000019', '300007', '20191111', '400', '十一月入库');
INSERT INTO `tb_instocks` VALUES ('201911240002', '400002', '000020', '300007', '20191111', '300', '十一月入库');
INSERT INTO `tb_instocks` VALUES ('201911240002', '400002', '000021', '300007', '20191111', '500', '十一月入库');
INSERT INTO `tb_instocks` VALUES ('201911240002', '400002', '000022', '300008', '20191111', '400', '十一月入库');
INSERT INTO `tb_instocks` VALUES ('201911240002', '400002', '000023', '300008', '20191111', '300', '十一月入库');
INSERT INTO `tb_instocks` VALUES ('201911240002', '400002', '000024', '300008', '20191111', '200', '十一月入库');

-- 2019.12.12
INSERT INTO `tb_instocks` VALUES ('201912120001', '400001', '000001', '300001', '20191212', '200', '双12入库');
INSERT INTO `tb_instocks` VALUES ('201912120001', '400001', '000002', '300001', '20191212', '300', '双12入库');
INSERT INTO `tb_instocks` VALUES ('201912120001', '400001', '000003', '300001', '20191212', '100', '双12入库');
INSERT INTO `tb_instocks` VALUES ('201912120001', '400001', '000004', '300002', '20191212', '100', '双12入库');
INSERT INTO `tb_instocks` VALUES ('201912120001', '400001', '000005', '300002', '20191212', '200', '双12入库');
INSERT INTO `tb_instocks` VALUES ('201912120001', '400001', '000006', '300002', '20191212', '100', '双12入库');
INSERT INTO `tb_instocks` VALUES ('201912120001', '400001', '000007', '300003', '20191212', '300', '双12入库');
INSERT INTO `tb_instocks` VALUES ('201912120001', '400001', '000008', '300003', '20191212', '100', '双12入库');
INSERT INTO `tb_instocks` VALUES ('201912120001', '400001', '000009', '300003', '20191212', '200', '双12入库');
INSERT INTO `tb_instocks` VALUES ('201912120001', '400001', '000010', '300004', '20191212', '100', '双12入库');
INSERT INTO `tb_instocks` VALUES ('201912120001', '400001', '000011', '300004', '20191212', '100', '双12入库');
INSERT INTO `tb_instocks` VALUES ('201912120001', '400001', '000012', '300004', '20191212', '100', '双12入库');
INSERT INTO `tb_instocks` VALUES ('201912120002', '400002', '000013', '300005', '20191212', '100', '双12入库');
INSERT INTO `tb_instocks` VALUES ('201912120002', '400002', '000014', '300005', '20191212', '300', '双12入库');
INSERT INTO `tb_instocks` VALUES ('201912120002', '400002', '000015', '300005', '20191212', '200', '双12入库');
INSERT INTO `tb_instocks` VALUES ('201912120002', '400002', '000016', '300006', '20191212', '300', '双12入库');
INSERT INTO `tb_instocks` VALUES ('201912120002', '400002', '000017', '300006', '20191212', '200', '双12入库');
INSERT INTO `tb_instocks` VALUES ('201912120002', '400002', '000018', '300006', '20191212', '500', '双12入库');
INSERT INTO `tb_instocks` VALUES ('201912120002', '400002', '000019', '300007', '20191212', '400', '双12入库');
INSERT INTO `tb_instocks` VALUES ('201912120002', '400002', '000020', '300007', '20191212', '300', '双12入库');
INSERT INTO `tb_instocks` VALUES ('201912120002', '400002', '000021', '300007', '20191212', '500', '双12入库');
INSERT INTO `tb_instocks` VALUES ('201912120002', '400002', '000022', '300008', '20191212', '400', '双12入库');
INSERT INTO `tb_instocks` VALUES ('201912120002', '400002', '000023', '300008', '20191212', '300', '双12入库');
INSERT INTO `tb_instocks` VALUES ('201912120002', '400002', '000024', '300008', '20191212', '200', '双12入库');

-- 2019.12.25
INSERT INTO `tb_instocks` VALUES ('201912250001', '400001', '000001', '300001', '20191212', '200', '12月入库');
INSERT INTO `tb_instocks` VALUES ('201912250001', '400001', '000002', '300001', '20191212', '300', '12月入库');
INSERT INTO `tb_instocks` VALUES ('201912250001', '400001', '000003', '300001', '20191212', '100', '12月入库');
INSERT INTO `tb_instocks` VALUES ('201912250001', '400001', '000004', '300002', '20191212', '100', '12月入库');
INSERT INTO `tb_instocks` VALUES ('201912250001', '400001', '000005', '300002', '20191212', '200', '12月入库');
INSERT INTO `tb_instocks` VALUES ('201912250001', '400001', '000006', '300002', '20191212', '100', '12月入库');
INSERT INTO `tb_instocks` VALUES ('201912250001', '400001', '000007', '300003', '20191212', '300', '12月入库');
INSERT INTO `tb_instocks` VALUES ('201912250001', '400001', '000008', '300003', '20191212', '100', '12月入库');
INSERT INTO `tb_instocks` VALUES ('201912250001', '400001', '000009', '300003', '20191212', '200', '12月入库');
INSERT INTO `tb_instocks` VALUES ('201912250001', '400001', '000010', '300004', '20191212', '100', '12月入库');
INSERT INTO `tb_instocks` VALUES ('201912250001', '400001', '000011', '300004', '20191212', '100', '12月入库');
INSERT INTO `tb_instocks` VALUES ('201912250001', '400001', '000012', '300004', '20191212', '100', '12月入库');
INSERT INTO `tb_instocks` VALUES ('201912250002', '400002', '000013', '300005', '20191212', '100', '12月入库');
INSERT INTO `tb_instocks` VALUES ('201912250002', '400002', '000014', '300005', '20191212', '300', '12月入库');
INSERT INTO `tb_instocks` VALUES ('201912250002', '400002', '000015', '300005', '20191212', '200', '12月入库');
INSERT INTO `tb_instocks` VALUES ('201912250002', '400002', '000016', '300006', '20191212', '300', '12月入库');
INSERT INTO `tb_instocks` VALUES ('201912250002', '400002', '000017', '300006', '20191212', '200', '12月入库');
INSERT INTO `tb_instocks` VALUES ('201912250002', '400002', '000018', '300006', '20191212', '500', '12月入库');
INSERT INTO `tb_instocks` VALUES ('201912250002', '400002', '000019', '300007', '20191212', '400', '12月入库');
INSERT INTO `tb_instocks` VALUES ('201912250002', '400002', '000020', '300007', '20191212', '300', '12月入库');
INSERT INTO `tb_instocks` VALUES ('201912250002', '400002', '000021', '300007', '20191212', '500', '12月入库');
INSERT INTO `tb_instocks` VALUES ('201912250002', '400002', '000022', '300008', '20191212', '400', '12月入库');
INSERT INTO `tb_instocks` VALUES ('201912250002', '400002', '000023', '300008', '20191212', '300', '12月入库');
INSERT INTO `tb_instocks` VALUES ('201912250002', '400002', '000024', '300008', '20191212', '200', '12月入库');

-- 2020.01.01
INSERT INTO `tb_instocks` VALUES ('202001010001', '400001', '000001', '300001', '20200101', '200', '元旦入库');
INSERT INTO `tb_instocks` VALUES ('202001010001', '400001', '000002', '300001', '20200101', '300', '元旦入库');
INSERT INTO `tb_instocks` VALUES ('202001010001', '400001', '000003', '300001', '20200101', '100', '元旦入库');
INSERT INTO `tb_instocks` VALUES ('202001010001', '400001', '000004', '300002', '20200101', '100', '元旦入库');
INSERT INTO `tb_instocks` VALUES ('202001010001', '400001', '000005', '300002', '20200101', '200', '元旦入库');
INSERT INTO `tb_instocks` VALUES ('202001010001', '400001', '000006', '300002', '20200101', '100', '元旦入库');
INSERT INTO `tb_instocks` VALUES ('202001010001', '400001', '000007', '300003', '20200101', '300', '元旦入库');
INSERT INTO `tb_instocks` VALUES ('202001010001', '400001', '000008', '300003', '20200101', '100', '元旦入库');
INSERT INTO `tb_instocks` VALUES ('202001010001', '400001', '000009', '300003', '20200101', '200', '元旦入库');
INSERT INTO `tb_instocks` VALUES ('202001010001', '400001', '000010', '300004', '20200101', '100', '元旦入库');
INSERT INTO `tb_instocks` VALUES ('202001010001', '400001', '000011', '300004', '20200101', '100', '元旦入库');
INSERT INTO `tb_instocks` VALUES ('202001010001', '400001', '000012', '300004', '20200101', '100', '元旦入库');
INSERT INTO `tb_instocks` VALUES ('202001010002', '400002', '000013', '300005', '20200101', '100', '元旦入库');
INSERT INTO `tb_instocks` VALUES ('202001010002', '400002', '000014', '300005', '20200101', '300', '元旦入库');
INSERT INTO `tb_instocks` VALUES ('202001010002', '400002', '000015', '300005', '20200101', '200', '元旦入库');
INSERT INTO `tb_instocks` VALUES ('202001010002', '400002', '000016', '300006', '20200101', '300', '元旦入库');
INSERT INTO `tb_instocks` VALUES ('202001010002', '400002', '000017', '300006', '20200101', '200', '元旦入库');
INSERT INTO `tb_instocks` VALUES ('202001010002', '400002', '000018', '300006', '20200101', '500', '元旦入库');
INSERT INTO `tb_instocks` VALUES ('202001010002', '400002', '000019', '300007', '20200101', '400', '元旦入库');
INSERT INTO `tb_instocks` VALUES ('202001010002', '400002', '000020', '300007', '20200101', '300', '元旦入库');
INSERT INTO `tb_instocks` VALUES ('202001010002', '400002', '000021', '300007', '20200101', '500', '元旦入库');
INSERT INTO `tb_instocks` VALUES ('202001010002', '400002', '000022', '300008', '20200101', '400', '元旦入库');
INSERT INTO `tb_instocks` VALUES ('202001010002', '400002', '000023', '300008', '20200101', '300', '元旦入库');
INSERT INTO `tb_instocks` VALUES ('202001010002', '400002', '000024', '300008', '20200101', '200', '元旦入库');

-- 2020.01.14
INSERT INTO `tb_instocks` VALUES ('202001140001', '400001', '000001', '300001', '20200101', '200', '1月入库');
INSERT INTO `tb_instocks` VALUES ('202001140001', '400001', '000002', '300001', '20200101', '300', '1月入库');
INSERT INTO `tb_instocks` VALUES ('202001140001', '400001', '000003', '300001', '20200101', '100', '1月入库');
INSERT INTO `tb_instocks` VALUES ('202001140001', '400001', '000004', '300002', '20200101', '100', '1月入库');
INSERT INTO `tb_instocks` VALUES ('202001140001', '400001', '000005', '300002', '20200101', '200', '1月入库');
INSERT INTO `tb_instocks` VALUES ('202001140001', '400001', '000006', '300002', '20200101', '100', '1月入库');
INSERT INTO `tb_instocks` VALUES ('202001140001', '400001', '000007', '300003', '20200101', '300', '1月入库');
INSERT INTO `tb_instocks` VALUES ('202001140001', '400001', '000008', '300003', '20200101', '100', '1月入库');
INSERT INTO `tb_instocks` VALUES ('202001140001', '400001', '000009', '300003', '20200101', '200', '1月入库');
INSERT INTO `tb_instocks` VALUES ('202001140001', '400001', '000010', '300004', '20200101', '100', '1月入库');
INSERT INTO `tb_instocks` VALUES ('202001140001', '400001', '000011', '300004', '20200101', '100', '1月入库');
INSERT INTO `tb_instocks` VALUES ('202001140001', '400001', '000012', '300004', '20200101', '100', '1月入库');
INSERT INTO `tb_instocks` VALUES ('202001140002', '400002', '000013', '300005', '20200101', '100', '1月入库');
INSERT INTO `tb_instocks` VALUES ('202001140002', '400002', '000014', '300005', '20200101', '300', '1月入库');
INSERT INTO `tb_instocks` VALUES ('202001140002', '400002', '000015', '300005', '20200101', '200', '1月入库');
INSERT INTO `tb_instocks` VALUES ('202001140002', '400002', '000016', '300006', '20200101', '300', '1月入库');
INSERT INTO `tb_instocks` VALUES ('202001140002', '400002', '000017', '300006', '20200101', '200', '1月入库');
INSERT INTO `tb_instocks` VALUES ('202001140002', '400002', '000018', '300006', '20200101', '500', '1月入库');
INSERT INTO `tb_instocks` VALUES ('202001140002', '400002', '000019', '300007', '20200101', '400', '1月入库');
INSERT INTO `tb_instocks` VALUES ('202001140002', '400002', '000020', '300007', '20200101', '300', '1月入库');
INSERT INTO `tb_instocks` VALUES ('202001140002', '400002', '000021', '300007', '20200101', '500', '1月入库');
INSERT INTO `tb_instocks` VALUES ('202001140002', '400002', '000022', '300008', '20200101', '400', '1月入库');
INSERT INTO `tb_instocks` VALUES ('202001140002', '400002', '000023', '300008', '20200101', '300', '1月入库');
INSERT INTO `tb_instocks` VALUES ('202001140002', '400002', '000024', '300008', '20200101', '200', '1月入库');

-- 同一商品不同供应商
INSERT INTO `tb_instocks` VALUES ('201911110001', '400001', '000001', '300003', '20191111', '100', '光棍节入库');
INSERT INTO `tb_instocks` VALUES ('201911110001', '400001', '000002', '300003', '20191111', '200', '光棍节入库');
INSERT INTO `tb_instocks` VALUES ('201911110001', '400001', '000003', '300003', '20191111', '300', '光棍节入库');
INSERT INTO `tb_instocks` VALUES ('201911110001', '400001', '000013', '300006', '20191111', '400', '光棍节入库');
INSERT INTO `tb_instocks` VALUES ('201911110001', '400001', '000014', '300006', '20191111', '500', '光棍节入库');
INSERT INTO `tb_instocks` VALUES ('201911110001', '400001', '000015', '300006', '20191111', '600', '光棍节入库');

INSERT INTO `tb_instocks` VALUES ('201912120001', '400001', '000001', '300003', '20191212', '100', '双12入库');
INSERT INTO `tb_instocks` VALUES ('201912120001', '400001', '000002', '300003', '20191212', '200', '双12入库');
INSERT INTO `tb_instocks` VALUES ('201912120001', '400001', '000003', '300003', '20191212', '300', '双12入库');
INSERT INTO `tb_instocks` VALUES ('201912120001', '400001', '000013', '300006', '20191212', '400', '双12入库');
INSERT INTO `tb_instocks` VALUES ('201912120001', '400001', '000014', '300006', '20191212', '500', '双12入库');
INSERT INTO `tb_instocks` VALUES ('201912120001', '400001', '000015', '300006', '20191212', '600', '双12入库');

INSERT INTO `tb_instocks` VALUES ('202001010001', '400001', '000001', '300003', '20200101', '100', '元旦入库');
INSERT INTO `tb_instocks` VALUES ('202001010001', '400001', '000002', '300003', '20200101', '200', '元旦入库');
INSERT INTO `tb_instocks` VALUES ('202001010001', '400001', '000003', '300003', '20200101', '300', '元旦入库');
INSERT INTO `tb_instocks` VALUES ('202001010001', '400001', '000013', '300006', '20200101', '400', '元旦入库');
INSERT INTO `tb_instocks` VALUES ('202001010001', '400001', '000014', '300006', '20200101', '500', '元旦入库');
INSERT INTO `tb_instocks` VALUES ('202001010001', '400001', '000015', '300006', '20200101', '600', '元旦入库');

-- 入库记录
INSERT INTO `tb_instock`  VALUES ('201911110001', '4000', '2019-11-11', '100001', '光棍节入库');
INSERT INTO `tb_instock`  VALUES ('201911110002', '3700', '2019-11-11', '100001', '光棍节入库');
INSERT INTO `tb_instock`  VALUES ('201911240001', '1900', '2019-11-24', '100001', '11月入库');
INSERT INTO `tb_instock`  VALUES ('201911240002', '3700', '2019-11-24', '100001', '11月入库');
INSERT INTO `tb_instock`  VALUES ('201912120001', '4000', '2019-12-12', '100002', '双12节入库');
INSERT INTO `tb_instock`  VALUES ('201912120002', '3700', '2019-12-12', '100002', '双12节入库');
INSERT INTO `tb_instock`  VALUES ('201912250001', '1900', '2019-12-25', '100002', '12月入库');
INSERT INTO `tb_instock`  VALUES ('201912250002', '3700', '2019-12-25', '100002', '12月入库');
INSERT INTO `tb_instock`  VALUES ('202001010001', '4000', '2020-01-01', '100003', '元旦入库');
INSERT INTO `tb_instock`  VALUES ('202001010002', '3700', '2020-01-01', '100003', '元旦入库');
INSERT INTO `tb_instock`  VALUES ('202001140001', '1900', '2020-01-14', '100003', '1月入库');
INSERT INTO `tb_instock`  VALUES ('202001140002', '3700', '2020-01-14', '100003', '1月入库');

-- ----------------------------
-- ********出库测试数据********
-- Records of tb_instocks
-- Records of tb_instock
-- ----------------------------
-- 2019.11.12
INSERT INTO `tb_outstocks` VALUES ('201911120001', '400001', '000001', '300001', '20191111', '100', '11月出库');
INSERT INTO `tb_outstocks` VALUES ('201911120001', '400001', '000002', '300001', '20191111', '100', '11月出库');
INSERT INTO `tb_outstocks` VALUES ('201911120001', '400001', '000003', '300001', '20191111', '50',  '11月出库');
INSERT INTO `tb_outstocks` VALUES ('201911120001', '400001', '000004', '300002', '20191111', '50',  '11月出库');
INSERT INTO `tb_outstocks` VALUES ('201911120001', '400001', '000005', '300002', '20191111', '100', '11月出库');
INSERT INTO `tb_outstocks` VALUES ('201911120001', '400001', '000006', '300002', '20191111', '50',  '11月出库');
INSERT INTO `tb_outstocks` VALUES ('201911120001', '400001', '000007', '300003', '20191111', '100', '11月出库');
INSERT INTO `tb_outstocks` VALUES ('201911120001', '400001', '000008', '300003', '20191111', '50',  '11月出库');
INSERT INTO `tb_outstocks` VALUES ('201911120001', '400001', '000009', '300003', '20191111', '100', '11月出库');
INSERT INTO `tb_outstocks` VALUES ('201911120001', '400001', '000010', '300004', '20191111', '50',  '11月出库');
INSERT INTO `tb_outstocks` VALUES ('201911120001', '400001', '000011', '300004', '20191111', '50',  '11月出库');
INSERT INTO `tb_outstocks` VALUES ('201911120001', '400001', '000012', '300004', '20191111', '50',  '11月出库');
INSERT INTO `tb_outstocks` VALUES ('201911120002', '400002', '000013', '300005', '20191111', '50',  '11月出库');
INSERT INTO `tb_outstocks` VALUES ('201911120002', '400002', '000014', '300005', '20191111', '100', '11月出库');
INSERT INTO `tb_outstocks` VALUES ('201911120002', '400002', '000015', '300005', '20191111', '100', '11月出库');
INSERT INTO `tb_outstocks` VALUES ('201911120002', '400002', '000016', '300006', '20191111', '100', '11月出库');
INSERT INTO `tb_outstocks` VALUES ('201911120002', '400002', '000017', '300006', '20191111', '100', '11月出库');
INSERT INTO `tb_outstocks` VALUES ('201911120002', '400002', '000018', '300006', '20191111', '100', '11月出库');
INSERT INTO `tb_outstocks` VALUES ('201911120002', '400002', '000019', '300007', '20191111', '100', '11月出库');
INSERT INTO `tb_outstocks` VALUES ('201911120002', '400002', '000020', '300007', '20191111', '100', '11月出库');
INSERT INTO `tb_outstocks` VALUES ('201911120002', '400002', '000021', '300007', '20191111', '100', '11月出库');
INSERT INTO `tb_outstocks` VALUES ('201911120002', '400002', '000022', '300008', '20191111', '100', '11月出库');
INSERT INTO `tb_outstocks` VALUES ('201911120002', '400002', '000023', '300008', '20191111', '100', '11月出库');
INSERT INTO `tb_outstocks` VALUES ('201911120002', '400002', '000024', '300008', '20191111', '100', '11月出库');

-- 2019.11.25
INSERT INTO `tb_outstocks` VALUES ('201911250001', '400001', '000001', '300001', '20191111', '100', '11月出库');
INSERT INTO `tb_outstocks` VALUES ('201911250001', '400001', '000002', '300001', '20191111', '100', '11月出库');
INSERT INTO `tb_outstocks` VALUES ('201911250001', '400001', '000003', '300001', '20191111', '50',  '11月出库');
INSERT INTO `tb_outstocks` VALUES ('201911250001', '400001', '000004', '300002', '20191111', '50',  '11月出库');
INSERT INTO `tb_outstocks` VALUES ('201911250001', '400001', '000005', '300002', '20191111', '100', '11月出库');
INSERT INTO `tb_outstocks` VALUES ('201911250001', '400001', '000006', '300002', '20191111', '50',  '11月出库');
INSERT INTO `tb_outstocks` VALUES ('201911250001', '400001', '000007', '300003', '20191111', '100', '11月出库');
INSERT INTO `tb_outstocks` VALUES ('201911250001', '400001', '000008', '300003', '20191111', '50',  '11月出库');
INSERT INTO `tb_outstocks` VALUES ('201911250001', '400001', '000009', '300003', '20191111', '100', '11月出库');
INSERT INTO `tb_outstocks` VALUES ('201911250001', '400001', '000010', '300004', '20191111', '50',  '11月出库');
INSERT INTO `tb_outstocks` VALUES ('201911250001', '400001', '000011', '300004', '20191111', '50',  '11月出库');
INSERT INTO `tb_outstocks` VALUES ('201911250001', '400001', '000012', '300004', '20191111', '50',  '11月出库');
INSERT INTO `tb_outstocks` VALUES ('201911250002', '400002', '000013', '300005', '20191111', '50',  '11月出库');
INSERT INTO `tb_outstocks` VALUES ('201911250002', '400002', '000014', '300005', '20191111', '100', '11月出库');
INSERT INTO `tb_outstocks` VALUES ('201911250002', '400002', '000015', '300005', '20191111', '100', '11月出库');
INSERT INTO `tb_outstocks` VALUES ('201911250002', '400002', '000016', '300006', '20191111', '100', '11月出库');
INSERT INTO `tb_outstocks` VALUES ('201911250002', '400002', '000017', '300006', '20191111', '100', '11月出库');
INSERT INTO `tb_outstocks` VALUES ('201911250002', '400002', '000018', '300006', '20191111', '100', '11月出库');
INSERT INTO `tb_outstocks` VALUES ('201911250002', '400002', '000019', '300007', '20191111', '100', '11月出库');
INSERT INTO `tb_outstocks` VALUES ('201911250002', '400002', '000020', '300007', '20191111', '100', '11月出库');
INSERT INTO `tb_outstocks` VALUES ('201911250002', '400002', '000021', '300007', '20191111', '100', '11月出库');
INSERT INTO `tb_outstocks` VALUES ('201911250002', '400002', '000022', '300008', '20191111', '100', '11月出库');
INSERT INTO `tb_outstocks` VALUES ('201911250002', '400002', '000023', '300008', '20191111', '100', '11月出库');
INSERT INTO `tb_outstocks` VALUES ('201911250002', '400002', '000024', '300008', '20191111', '100', '11月出库');

-- 2019.12.13
INSERT INTO `tb_outstocks` VALUES ('201912130001', '400001', '000001', '300001', '20191212', '100', '12月出库');
INSERT INTO `tb_outstocks` VALUES ('201912130001', '400001', '000002', '300001', '20191212', '100', '12月出库');
INSERT INTO `tb_outstocks` VALUES ('201912130001', '400001', '000003', '300001', '20191212', '50',  '12月出库');
INSERT INTO `tb_outstocks` VALUES ('201912130001', '400001', '000004', '300002', '20191212', '50',  '12月出库');
INSERT INTO `tb_outstocks` VALUES ('201912130001', '400001', '000005', '300002', '20191212', '100', '12月出库');
INSERT INTO `tb_outstocks` VALUES ('201912130001', '400001', '000006', '300002', '20191212', '50',  '12月出库');
INSERT INTO `tb_outstocks` VALUES ('201912130001', '400001', '000007', '300003', '20191212', '100', '12月出库');
INSERT INTO `tb_outstocks` VALUES ('201912130001', '400001', '000008', '300003', '20191212', '50',  '12月出库');
INSERT INTO `tb_outstocks` VALUES ('201912130001', '400001', '000009', '300003', '20191212', '100', '12月出库');
INSERT INTO `tb_outstocks` VALUES ('201912130001', '400001', '000010', '300004', '20191212', '50',  '12月出库');
INSERT INTO `tb_outstocks` VALUES ('201912130001', '400001', '000011', '300004', '20191212', '50',  '12月出库');
INSERT INTO `tb_outstocks` VALUES ('201912130001', '400001', '000012', '300004', '20191212', '50',  '12月出库');
INSERT INTO `tb_outstocks` VALUES ('201912130002', '400002', '000013', '300005', '20191212', '50',  '12月出库');
INSERT INTO `tb_outstocks` VALUES ('201912130002', '400002', '000014', '300005', '20191212', '100', '12月出库');
INSERT INTO `tb_outstocks` VALUES ('201912130002', '400002', '000015', '300005', '20191212', '100', '12月出库');
INSERT INTO `tb_outstocks` VALUES ('201912130002', '400002', '000016', '300006', '20191212', '100', '12月出库');
INSERT INTO `tb_outstocks` VALUES ('201912130002', '400002', '000017', '300006', '20191212', '100', '12月出库');
INSERT INTO `tb_outstocks` VALUES ('201912130002', '400002', '000018', '300006', '20191212', '100', '12月出库');
INSERT INTO `tb_outstocks` VALUES ('201912130002', '400002', '000019', '300007', '20191212', '100', '12月出库');
INSERT INTO `tb_outstocks` VALUES ('201912130002', '400002', '000020', '300007', '20191212', '100', '12月出库');
INSERT INTO `tb_outstocks` VALUES ('201912130002', '400002', '000021', '300007', '20191212', '100', '12月出库');
INSERT INTO `tb_outstocks` VALUES ('201912130002', '400002', '000022', '300008', '20191212', '100', '12月出库');
INSERT INTO `tb_outstocks` VALUES ('201912130002', '400002', '000023', '300008', '20191212', '100', '12月出库');
INSERT INTO `tb_outstocks` VALUES ('201912130002', '400002', '000024', '300008', '20191212', '100', '12月出库');

-- 2019.12.26
INSERT INTO `tb_outstocks` VALUES ('201912260001', '400001', '000001', '300001', '20191212', '100', '12月出库');
INSERT INTO `tb_outstocks` VALUES ('201912260001', '400001', '000002', '300001', '20191212', '100', '12月出库');
INSERT INTO `tb_outstocks` VALUES ('201912260001', '400001', '000003', '300001', '20191212', '50',  '12月出库');
INSERT INTO `tb_outstocks` VALUES ('201912260001', '400001', '000004', '300002', '20191212', '50',  '12月出库');
INSERT INTO `tb_outstocks` VALUES ('201912260001', '400001', '000005', '300002', '20191212', '100', '12月出库');
INSERT INTO `tb_outstocks` VALUES ('201912260001', '400001', '000006', '300002', '20191212', '50',  '12月出库');
INSERT INTO `tb_outstocks` VALUES ('201912260001', '400001', '000007', '300003', '20191212', '100', '12月出库');
INSERT INTO `tb_outstocks` VALUES ('201912260001', '400001', '000008', '300003', '20191212', '50',  '12月出库');
INSERT INTO `tb_outstocks` VALUES ('201912260001', '400001', '000009', '300003', '20191212', '100', '12月出库');
INSERT INTO `tb_outstocks` VALUES ('201912260001', '400001', '000010', '300004', '20191212', '50',  '12月出库');
INSERT INTO `tb_outstocks` VALUES ('201912260001', '400001', '000011', '300004', '20191212', '50',  '12月出库');
INSERT INTO `tb_outstocks` VALUES ('201912260001', '400001', '000012', '300004', '20191212', '50',  '12月出库');
INSERT INTO `tb_outstocks` VALUES ('201912260002', '400002', '000013', '300005', '20191212', '50',  '12月出库');
INSERT INTO `tb_outstocks` VALUES ('201912260002', '400002', '000014', '300005', '20191212', '100', '12月出库');
INSERT INTO `tb_outstocks` VALUES ('201912260002', '400002', '000015', '300005', '20191212', '100', '12月出库');
INSERT INTO `tb_outstocks` VALUES ('201912260002', '400002', '000016', '300006', '20191212', '100', '12月出库');
INSERT INTO `tb_outstocks` VALUES ('201912260002', '400002', '000017', '300006', '20191212', '100', '12月出库');
INSERT INTO `tb_outstocks` VALUES ('201912260002', '400002', '000018', '300006', '20191212', '100', '12月出库');
INSERT INTO `tb_outstocks` VALUES ('201912260002', '400002', '000019', '300007', '20191212', '100', '12月出库');
INSERT INTO `tb_outstocks` VALUES ('201912260002', '400002', '000020', '300007', '20191212', '100', '12月出库');
INSERT INTO `tb_outstocks` VALUES ('201912260002', '400002', '000021', '300007', '20191212', '100', '12月出库');
INSERT INTO `tb_outstocks` VALUES ('201912260002', '400002', '000022', '300008', '20191212', '100', '12月出库');
INSERT INTO `tb_outstocks` VALUES ('201912260002', '400002', '000023', '300008', '20191212', '100', '12月出库');
INSERT INTO `tb_outstocks` VALUES ('201912260002', '400002', '000024', '300008', '20191212', '100', '12月出库');

-- 2020.01.02
INSERT INTO `tb_outstocks` VALUES ('202001020001', '400001', '000001', '300001', '20200101', '100', '1月出库');
INSERT INTO `tb_outstocks` VALUES ('202001020001', '400001', '000002', '300001', '20200101', '100', '1月出库');
INSERT INTO `tb_outstocks` VALUES ('202001020001', '400001', '000003', '300001', '20200101', '50',  '1月出库');
INSERT INTO `tb_outstocks` VALUES ('202001020001', '400001', '000004', '300002', '20200101', '50',  '1月出库');
INSERT INTO `tb_outstocks` VALUES ('202001020001', '400001', '000005', '300002', '20200101', '100', '1月出库');
INSERT INTO `tb_outstocks` VALUES ('202001020001', '400001', '000006', '300002', '20200101', '50',  '1月出库');
INSERT INTO `tb_outstocks` VALUES ('202001020001', '400001', '000007', '300003', '20200101', '100', '1月出库');
INSERT INTO `tb_outstocks` VALUES ('202001020001', '400001', '000008', '300003', '20200101', '50',  '1月出库');
INSERT INTO `tb_outstocks` VALUES ('202001020001', '400001', '000009', '300003', '20200101', '100', '1月出库');
INSERT INTO `tb_outstocks` VALUES ('202001020001', '400001', '000010', '300004', '20200101', '50',  '1月出库');
INSERT INTO `tb_outstocks` VALUES ('202001020001', '400001', '000011', '300004', '20200101', '50',  '1月出库');
INSERT INTO `tb_outstocks` VALUES ('202001020001', '400001', '000012', '300004', '20200101', '50',  '1月出库');
INSERT INTO `tb_outstocks` VALUES ('202001020002', '400002', '000013', '300005', '20200101', '50',  '1月出库');
INSERT INTO `tb_outstocks` VALUES ('202001020002', '400002', '000014', '300005', '20200101', '100', '1月出库');
INSERT INTO `tb_outstocks` VALUES ('202001020002', '400002', '000015', '300005', '20200101', '100', '1月出库');
INSERT INTO `tb_outstocks` VALUES ('202001020002', '400002', '000016', '300006', '20200101', '100', '1月出库');
INSERT INTO `tb_outstocks` VALUES ('202001020002', '400002', '000017', '300006', '20200101', '100', '1月出库');
INSERT INTO `tb_outstocks` VALUES ('202001020002', '400002', '000018', '300006', '20200101', '100', '1月出库');
INSERT INTO `tb_outstocks` VALUES ('202001020002', '400002', '000019', '300007', '20200101', '100', '1月出库');
INSERT INTO `tb_outstocks` VALUES ('202001020002', '400002', '000020', '300007', '20200101', '100', '1月出库');
INSERT INTO `tb_outstocks` VALUES ('202001020002', '400002', '000021', '300007', '20200101', '100', '1月出库');
INSERT INTO `tb_outstocks` VALUES ('202001020002', '400002', '000022', '300008', '20200101', '100', '1月出库');
INSERT INTO `tb_outstocks` VALUES ('202001020002', '400002', '000023', '300008', '20200101', '100', '1月出库');
INSERT INTO `tb_outstocks` VALUES ('202001020002', '400002', '000024', '300008', '20200101', '100', '1月出库');

-- 2020.01.15
INSERT INTO `tb_outstocks` VALUES ('202001150001', '400001', '000001', '300001', '20200101', '100', '1月出库');
INSERT INTO `tb_outstocks` VALUES ('202001150001', '400001', '000002', '300001', '20200101', '100', '1月出库');
INSERT INTO `tb_outstocks` VALUES ('202001150001', '400001', '000003', '300001', '20200101', '50',  '1月出库');
INSERT INTO `tb_outstocks` VALUES ('202001150001', '400001', '000004', '300002', '20200101', '50',  '1月出库');
INSERT INTO `tb_outstocks` VALUES ('202001150001', '400001', '000005', '300002', '20200101', '100', '1月出库');
INSERT INTO `tb_outstocks` VALUES ('202001150001', '400001', '000006', '300002', '20200101', '50',  '1月出库');
INSERT INTO `tb_outstocks` VALUES ('202001150001', '400001', '000007', '300003', '20200101', '100', '1月出库');
INSERT INTO `tb_outstocks` VALUES ('202001150001', '400001', '000008', '300003', '20200101', '50',  '1月出库');
INSERT INTO `tb_outstocks` VALUES ('202001150001', '400001', '000009', '300003', '20200101', '100', '1月出库');
INSERT INTO `tb_outstocks` VALUES ('202001150001', '400001', '000010', '300004', '20200101', '50',  '1月出库');
INSERT INTO `tb_outstocks` VALUES ('202001150001', '400001', '000011', '300004', '20200101', '50',  '1月出库');
INSERT INTO `tb_outstocks` VALUES ('202001150001', '400001', '000012', '300004', '20200101', '50',  '1月出库');
INSERT INTO `tb_outstocks` VALUES ('202001150002', '400002', '000013', '300005', '20200101', '50',  '1月出库');
INSERT INTO `tb_outstocks` VALUES ('202001150002', '400002', '000014', '300005', '20200101', '100', '1月出库');
INSERT INTO `tb_outstocks` VALUES ('202001150002', '400002', '000015', '300005', '20200101', '100', '1月出库');
INSERT INTO `tb_outstocks` VALUES ('202001150002', '400002', '000016', '300006', '20200101', '100', '1月出库');
INSERT INTO `tb_outstocks` VALUES ('202001150002', '400002', '000017', '300006', '20200101', '100', '1月出库');
INSERT INTO `tb_outstocks` VALUES ('202001150002', '400002', '000018', '300006', '20200101', '100', '1月出库');
INSERT INTO `tb_outstocks` VALUES ('202001150002', '400002', '000019', '300007', '20200101', '100', '1月出库');
INSERT INTO `tb_outstocks` VALUES ('202001150002', '400002', '000020', '300007', '20200101', '100', '1月出库');
INSERT INTO `tb_outstocks` VALUES ('202001150002', '400002', '000021', '300007', '20200101', '100', '1月出库');
INSERT INTO `tb_outstocks` VALUES ('202001150002', '400002', '000022', '300008', '20200101', '100', '1月出库');
INSERT INTO `tb_outstocks` VALUES ('202001150002', '400002', '000023', '300008', '20200101', '100', '1月出库');
INSERT INTO `tb_outstocks` VALUES ('202001150002', '400002', '000024', '300008', '20200101', '100', '1月出库');

-- 出库记录
INSERT INTO `tb_outstock`  VALUES ('201911120001', '850',  '2019-11-11', '100003', '11月出库');
INSERT INTO `tb_outstock`  VALUES ('201911120002', '1150', '2019-11-11', '100003', '11月出库');
INSERT INTO `tb_outstock`  VALUES ('201911250001', '850',  '2019-11-24', '100003', '11月出库');
INSERT INTO `tb_outstock`  VALUES ('201911250002', '1150', '2019-11-24', '100003', '11月出库');
INSERT INTO `tb_outstock`  VALUES ('201912130001', '850',  '2019-12-12', '100002', '12月出库');
INSERT INTO `tb_outstock`  VALUES ('201912130002', '1150', '2019-12-12', '100002', '12月出库');
INSERT INTO `tb_outstock`  VALUES ('201912260001', '850',  '2019-12-25', '100002', '12月出库');
INSERT INTO `tb_outstock`  VALUES ('201912260002', '1150', '2019-12-25', '100002', '12月出库');
INSERT INTO `tb_outstock`  VALUES ('202001020001', '850',  '2020-01-01', '100001', '1月出库');
INSERT INTO `tb_outstock`  VALUES ('202001020002', '1150', '2020-01-01', '100001', '1月出库');
INSERT INTO `tb_outstock`  VALUES ('202001150001', '850',  '2020-01-14', '100001', '1月出库');
INSERT INTO `tb_outstock`  VALUES ('202001150002', '1150', '2020-01-14', '100001', '1月出库');

-- ----------------------------
-- ********盘点测试数据********
-- Records of tb_checks
-- Records of tb_check
-- ----------------------------
-- 2019.11.11
INSERT INTO `tb_checks` VALUES ('202001150001', '400001', '000001', '300001', '20191111', '200','200', '数量准确');
INSERT INTO `tb_checks` VALUES ('202001150001', '400001', '000002', '300001', '20191111', '400','400', '数量准确');
INSERT INTO `tb_checks` VALUES ('202001150001', '400001', '000003', '300001', '20191111', '100','100', '数量准确');
INSERT INTO `tb_checks` VALUES ('202001150001', '400001', '000004', '300002', '20191111', '100','100', '数量准确');
INSERT INTO `tb_checks` VALUES ('202001150001', '400001', '000005', '300002', '20191111', '200','200', '数量准确');
INSERT INTO `tb_checks` VALUES ('202001150001', '400001', '000006', '300002', '20191111', '100','100', '数量准确');
INSERT INTO `tb_checks` VALUES ('202001150001', '400001', '000007', '300003', '20191111', '400','400', '数量准确');
INSERT INTO `tb_checks` VALUES ('202001150001', '400001', '000008', '300003', '20191111', '100','100', '数量准确');
INSERT INTO `tb_checks` VALUES ('202001150001', '400001', '000009', '300003', '20191111', '200','200', '数量准确');
INSERT INTO `tb_checks` VALUES ('202001150001', '400001', '000010', '300004', '20191111', '100','100', '数量准确');
INSERT INTO `tb_checks` VALUES ('202001150001', '400001', '000011', '300004', '20191111', '100','100', '数量准确');
INSERT INTO `tb_checks` VALUES ('202001150001', '400001', '000012', '300004', '20191111', '100','100', '数量准确');
INSERT INTO `tb_checks` VALUES ('202001150001', '400002', '000013', '300005', '20191111', '100','100', '数量准确');
INSERT INTO `tb_checks` VALUES ('202001150001', '400002', '000014', '300005', '20191111', '400','400', '数量准确');
INSERT INTO `tb_checks` VALUES ('202001150001', '400002', '000015', '300005', '20191111', '200','200', '数量准确');
INSERT INTO `tb_checks` VALUES ('202001150001', '400002', '000016', '300006', '20191111', '400','400', '数量准确');
INSERT INTO `tb_checks` VALUES ('202001150001', '400002', '000017', '300006', '20191111', '200','200', '数量准确');
INSERT INTO `tb_checks` VALUES ('202001150001', '400002', '000018', '300006', '20191111', '800','800', '数量准确');
INSERT INTO `tb_checks` VALUES ('202001150001', '400002', '000019', '300007', '20191111', '600','600', '数量准确');
INSERT INTO `tb_checks` VALUES ('202001150001', '400002', '000020', '300007', '20191111', '400','400', '数量准确');
INSERT INTO `tb_checks` VALUES ('202001150001', '400002', '000021', '300007', '20191111', '800','800', '数量准确');
INSERT INTO `tb_checks` VALUES ('202001150001', '400002', '000022', '300008', '20191111', '600','600', '数量准确');
INSERT INTO `tb_checks` VALUES ('202001150001', '400002', '000023', '300008', '20191111', '400','400', '数量准确');
INSERT INTO `tb_checks` VALUES ('202001150001', '400002', '000024', '300008', '20191111', '200','200', '数量准确');

-- 2019.12.12
INSERT INTO `tb_checks` VALUES ('202001150001', '400001', '000001', '300001', '20191212', '200','200', '数量准确');
INSERT INTO `tb_checks` VALUES ('202001150001', '400001', '000002', '300001', '20191212', '400','400', '数量准确');
INSERT INTO `tb_checks` VALUES ('202001150001', '400001', '000003', '300001', '20191212', '100','100', '数量准确');
INSERT INTO `tb_checks` VALUES ('202001150001', '400001', '000004', '300002', '20191212', '100','100', '数量准确');
INSERT INTO `tb_checks` VALUES ('202001150001', '400001', '000005', '300002', '20191212', '200','200', '数量准确');
INSERT INTO `tb_checks` VALUES ('202001150001', '400001', '000006', '300002', '20191212', '100','100', '数量准确');
INSERT INTO `tb_checks` VALUES ('202001150001', '400001', '000007', '300003', '20191212', '400','400', '数量准确');
INSERT INTO `tb_checks` VALUES ('202001150001', '400001', '000008', '300003', '20191212', '100','100', '数量准确');
INSERT INTO `tb_checks` VALUES ('202001150001', '400001', '000009', '300003', '20191212', '200','200', '数量准确');
INSERT INTO `tb_checks` VALUES ('202001150001', '400001', '000010', '300004', '20191212', '100','100', '数量准确');
INSERT INTO `tb_checks` VALUES ('202001150001', '400001', '000011', '300004', '20191212', '100','100', '数量准确');
INSERT INTO `tb_checks` VALUES ('202001150001', '400001', '000012', '300004', '20191212', '100','100', '数量准确');
INSERT INTO `tb_checks` VALUES ('202001150001', '400002', '000013', '300005', '20191212', '100','100', '数量准确');
INSERT INTO `tb_checks` VALUES ('202001150001', '400002', '000014', '300005', '20191212', '400','400', '数量准确');
INSERT INTO `tb_checks` VALUES ('202001150001', '400002', '000015', '300005', '20191212', '200','200', '数量准确');
INSERT INTO `tb_checks` VALUES ('202001150001', '400002', '000016', '300006', '20191212', '400','400', '数量准确');
INSERT INTO `tb_checks` VALUES ('202001150001', '400002', '000017', '300006', '20191212', '200','200', '数量准确');
INSERT INTO `tb_checks` VALUES ('202001150001', '400002', '000018', '300006', '20191212', '800','800', '数量准确');
INSERT INTO `tb_checks` VALUES ('202001150001', '400002', '000019', '300007', '20191212', '600','600', '数量准确');
INSERT INTO `tb_checks` VALUES ('202001150001', '400002', '000020', '300007', '20191212', '400','400', '数量准确');
INSERT INTO `tb_checks` VALUES ('202001150001', '400002', '000021', '300007', '20191212', '800','800', '数量准确');
INSERT INTO `tb_checks` VALUES ('202001150001', '400002', '000022', '300008', '20191212', '600','600', '数量准确');
INSERT INTO `tb_checks` VALUES ('202001150001', '400002', '000023', '300008', '20191212', '400','400', '数量准确');
INSERT INTO `tb_checks` VALUES ('202001150001', '400002', '000024', '300008', '20191212', '200','200', '数量准确');

-- 2020.01.01
INSERT INTO `tb_checks` VALUES ('202001150001', '400001', '000001', '300001', '20200101', '200','200', '数量准确');
INSERT INTO `tb_checks` VALUES ('202001150001', '400001', '000002', '300001', '20200101', '400','400', '数量准确');
INSERT INTO `tb_checks` VALUES ('202001150001', '400001', '000003', '300001', '20200101', '100','100', '数量准确');
INSERT INTO `tb_checks` VALUES ('202001150001', '400001', '000004', '300002', '20200101', '100','100', '数量准确');
INSERT INTO `tb_checks` VALUES ('202001150001', '400001', '000005', '300002', '20200101', '200','200', '数量准确');
INSERT INTO `tb_checks` VALUES ('202001150001', '400001', '000006', '300002', '20200101', '100','100', '数量准确');
INSERT INTO `tb_checks` VALUES ('202001150001', '400001', '000007', '300003', '20200101', '400','400', '数量准确');
INSERT INTO `tb_checks` VALUES ('202001150001', '400001', '000008', '300003', '20200101', '100','100', '数量准确');
INSERT INTO `tb_checks` VALUES ('202001150001', '400001', '000009', '300003', '20200101', '200','200', '数量准确');
INSERT INTO `tb_checks` VALUES ('202001150001', '400001', '000010', '300004', '20200101', '100','100', '数量准确');
INSERT INTO `tb_checks` VALUES ('202001150001', '400001', '000011', '300004', '20200101', '100','100', '数量准确');
INSERT INTO `tb_checks` VALUES ('202001150001', '400001', '000012', '300004', '20200101', '100','100', '数量准确');
INSERT INTO `tb_checks` VALUES ('202001150001', '400002', '000013', '300005', '20200101', '100','100', '数量准确');
INSERT INTO `tb_checks` VALUES ('202001150001', '400002', '000014', '300005', '20200101', '400','400', '数量准确');
INSERT INTO `tb_checks` VALUES ('202001150001', '400002', '000015', '300005', '20200101', '200','200', '数量准确');
INSERT INTO `tb_checks` VALUES ('202001150001', '400002', '000016', '300006', '20200101', '400','400', '数量准确');
INSERT INTO `tb_checks` VALUES ('202001150001', '400002', '000017', '300006', '20200101', '200','200', '数量准确');
INSERT INTO `tb_checks` VALUES ('202001150001', '400002', '000018', '300006', '20200101', '800','800', '数量准确');
INSERT INTO `tb_checks` VALUES ('202001150001', '400002', '000019', '300007', '20200101', '600','600', '数量准确');
INSERT INTO `tb_checks` VALUES ('202001150001', '400002', '000020', '300007', '20200101', '400','400', '数量准确');
INSERT INTO `tb_checks` VALUES ('202001150001', '400002', '000021', '300007', '20200101', '800','800', '数量准确');
INSERT INTO `tb_checks` VALUES ('202001150001', '400002', '000022', '300008', '20200101', '600','600', '数量准确');
INSERT INTO `tb_checks` VALUES ('202001150001', '400002', '000023', '300008', '20200101', '400','400', '数量准确');
INSERT INTO `tb_checks` VALUES ('202001150001', '400002', '000024', '300008', '20200101', '200','200', '数量准确');

-- 盘点记录
INSERT INTO `tb_check` VALUES ('202001150001', '1234', '1234', '2020-01-15', '100001', '库存数量准确');
INSERT INTO `tb_check` VALUES ('202001150002', '1234', '1234', '2020-01-15', '100001', '库存数量准确');
INSERT INTO `tb_check` VALUES ('202001150003', '1234', '1234', '2020-01-15', '100001', '库存数量准确');
INSERT INTO `tb_check` VALUES ('202001160001', '1231', '1231', '2020-01-16', '100002', '库存数量准确');
INSERT INTO `tb_check` VALUES ('202001160002', '1231', '1231', '2020-01-16', '100002', '库存数量准确');
INSERT INTO `tb_check` VALUES ('202001160003', '1231', '1231', '2020-01-16', '100002', '库存数量准确');
INSERT INTO `tb_check` VALUES ('202001160004', '1235', '1235', '2020-01-16', '100002', '库存数量准确');
INSERT INTO `tb_check` VALUES ('202001170001', '1235', '1235', '2020-01-17', '100003', '库存数量准确');
INSERT INTO `tb_check` VALUES ('202001170002', '1235', '1235', '2020-01-17', '100003', '库存数量准确');
INSERT INTO `tb_check` VALUES ('202001170003', '1235', '1235', '2020-01-17', '100003', '库存数量准确');
INSERT INTO `tb_check` VALUES ('202001180001', '1235', '1235', '2020-01-18', '100003', '库存数量准确');

-- ----------------------------
-- ********销售测试数据********
-- Records of tb_sales
-- Records of tb_sale
-- ----------------------------
-- 11月份 2019.11.13 - 201911.01.23 不打折 当月批号
-- 销售明细 2019-11-13  
INSERT INTO `tb_sales` VALUES ('201911130001', '000001', '300001', '20191111', '3.00', '20', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201911130001', '000004', '300002', '20191111', '5.00', '10', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201911130001', '000007', '300003', '20191111', '3.50', '30', '非VIP，不打折');

-- 销售明细 2019-11-14 
INSERT INTO `tb_sales` VALUES ('201911140001', '000001', '300001', '20191111', '3.00', '20', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201911140001', '000004', '300002', '20191111', '5.00', '10', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201911140002', '000020', '300007', '20191111', '13.50','10', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201911140002', '000014', '300005', '20191111', '3.50', '20', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201911140002', '000017', '300006', '20191111', '5.00', '10', '非VIP，不打折');

-- 销售明细 2019-11-15 
INSERT INTO `tb_sales` VALUES ('201911150001', '000001', '300001', '20191111', '3.00', '20', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201911150001', '000004', '300002', '20191111', '5.00', '10', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201911150001', '000007', '300003', '20191111', '3.50', '30', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201911150002', '000017', '300006', '20191111', '5.00', '30', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201911150002', '000020', '300007', '20191111', '13.50','20', '非VIP，不打折');

-- 销售明细 2019-11-16 
INSERT INTO `tb_sales` VALUES ('201911160001', '000001', '300002', '20191111', '3.00', '20', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201911160001', '000004', '300004', '20191111', '5.00', '10', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201911160002', '000007', '300003', '20191111', '3.50', '30', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201911160002', '000010', '300004', '20191111', '55.00','10', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201911160002', '000020', '300007', '20191111', '13.50','20', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201911160002', '000017', '300006', '20191111', '5.00', '10', '非VIP，不打折');

-- 销售明细 2019-11-17 
INSERT INTO `tb_sales` VALUES ('201911170001', '000001', '300001', '20191111', '3.00', '20', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201911170001', '000004', '300002', '20191111', '5.00', '10', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201911170001', '000007', '300003', '20191111', '3.50', '30', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201911170001', '000011', '300004', '20191111', '20.00','10', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201911170002', '000012', '300004', '20191111', '8.00', '20', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201911170002', '000008', '300003', '20191111', '3.50', '10', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201911170002', '000002', '300001', '20191111', '3.00', '50', '非VIP，不打折');

-- 销售明细 2019-11-18 
INSERT INTO `tb_sales` VALUES ('201911180001', '000001', '300001', '20191111', '3.00', '20', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201911180001', '000004', '300002', '20191111', '5.00', '10', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201911180001', '000007', '300003', '20191111', '3.50', '30', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201911180001', '000010', '300004', '20191111', '55.00','10', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201911180002', '000014', '300005', '20191111', '3.50', '20', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201911180002', '000017', '300006', '20191111', '5.00', '10', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201911180002', '000020', '300007', '20191111', '13.50','10', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201911180002', '000021', '300007', '20191111', '23.50','10', '非VIP，不打折');

-- 销售明细 2019-11-19 
INSERT INTO `tb_sales` VALUES ('201911190001', '000001', '300001', '20191111', '3.00', '20', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201911190001', '000004', '300002', '20191111', '5.00', '10', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201911190001', '000007', '300003', '20191111', '3.50', '30', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201911190001', '000013', '300005', '20191111', '3.50', '20', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201911190002', '000011', '300004', '20191111', '20.00','20', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201911190002', '000017', '300006', '20191111', '5.00', '10', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201911190002', '000021', '300007', '20191111', '23.50','20', '非VIP，不打折');

-- 销售明细 2019-11-20 
INSERT INTO `tb_sales` VALUES ('201911200001', '000001', '300001', '20191111', '3.00', '20', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201911200001', '000004', '300002', '20191111', '5.00', '10', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201911200001', '000006', '300002', '20191111', '5.00', '50', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201911200002', '000017', '300006', '20191111', '5.00', '10', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201911200002', '000019', '300007', '20191111', '33.50','30', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201911200002', '000021', '300007', '20191111', '23.50','20', '非VIP，不打折');

-- 销售明细 2019-11-21 
INSERT INTO `tb_sales` VALUES ('201911210001', '000001', '300001', '20191111', '3.00', '20', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201911210001', '000004', '300002', '20191111', '5.00', '10', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201911210001', '000007', '300003', '20191111', '3.50', '30', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201911210001', '000013', '300005', '20191111', '3.50', '20', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201911210001', '000018', '300006', '20191111', '8.00', '50', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201911210002', '000017', '300006', '20191111', '5.00', '10', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201911210002', '000018', '300006', '20191111', '8.00', '10', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201911210002', '000021', '300007', '20191111', '23.50','20', '非VIP，不打折');

-- 销售明细 2019-11-22 
INSERT INTO `tb_sales` VALUES ('201911220001', '000001', '300001', '20191111', '3.00', '20', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201911220001', '000004', '300002', '20191111', '5.00', '20', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201911220001', '000007', '300003', '20191111', '3.50', '30', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201911220001', '000009', '300003', '20191111', '3.50', '20', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201911220002', '000011', '300004', '20191111', '20.00','20', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201911220002', '000017', '300006', '20191111', '5.00', '10', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201911220002', '000018', '300006', '20191111', '8.00', '10', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201911220002', '000016', '300006', '20191111', '15.00','20', '非VIP，不打折');

-- 销售明细 2019-11-23 
INSERT INTO `tb_sales` VALUES ('201911230001', '000001', '300001', '20191111', '3.00', '20', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201911230001', '000004', '300002', '20191111', '5.00', '10', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201911230001', '000015', '300005', '20191111', '3.50', '30', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201911230002', '000013', '300005', '20191111', '3.50', '20', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201911230002', '000011', '300004', '20191111', '20.00','20', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201911230002', '000017', '300006', '20191111', '5.00', '10', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201911230002', '000018', '300006', '20191111', '8.00', '20', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201911230002', '000021', '300007', '20191111', '23.50','20', '非VIP，不打折');

-- 12月份 2019.12.14 - 2019.12.24 前5天 打折销售 上月批号
-- 销售明细 2019-12-14
INSERT INTO `tb_sales` VALUES ('201912140001', '000001', '300001', '20191111', '1.00', '30', '非VIP，打折');
INSERT INTO `tb_sales` VALUES ('201912140001', '000004', '300002', '20191111', '3.00', '30', '非VIP，打折');
INSERT INTO `tb_sales` VALUES ('201912140001', '000007', '300003', '20191111', '1.50', '40', '非VIP，打折');
INSERT INTO `tb_sales` VALUES ('201912140002', '000010', '300004', '20191111', '53.00','10', '非VIP，打折');
INSERT INTO `tb_sales` VALUES ('201912140002', '000013', '300005', '20191111', '1.50', '20', '非VIP，打折');
INSERT INTO `tb_sales` VALUES ('201912140002', '000016', '300006', '20191111', '13.00','20', '非VIP，打折');
INSERT INTO `tb_sales` VALUES ('201912140002', '000019', '300007', '20191111', '31.50','20', '非VIP，打折');

-- 销售明细 2019-12-15
INSERT INTO `tb_sales` VALUES ('201912150001', '000001', '300001', '20191111', '1.00', '40', '非VIP，打折');
INSERT INTO `tb_sales` VALUES ('201912150001', '000004', '300002', '20191111', '3.00', '50', '非VIP，打折');
INSERT INTO `tb_sales` VALUES ('201912150001', '000007', '300003', '20191111', '1.50', '20', '非VIP，打折');
INSERT INTO `tb_sales` VALUES ('201912150002', '000013', '300005', '20191111', '1.50', '20', '非VIP，打折');
INSERT INTO `tb_sales` VALUES ('201912150002', '000016', '300006', '20191111', '13.00','20', '非VIP，打折');
INSERT INTO `tb_sales` VALUES ('201912150002', '000022', '300008', '20191111', '98.00','20', '非VIP，打折');

-- 销售明细 2019-12-16
INSERT INTO `tb_sales` VALUES ('201912160001', '000001', '300001', '20191111', '1.00', '40', '非VIP，打折');
INSERT INTO `tb_sales` VALUES ('201912160001', '000004', '300002', '20191111', '3.00', '50', '非VIP，打折');
INSERT INTO `tb_sales` VALUES ('201912160001', '000007', '300003', '20191111', '1.50', '20', '非VIP，打折');
INSERT INTO `tb_sales` VALUES ('201912160002', '000010', '300004', '20191111', '53.00','10', '非VIP，打折');
INSERT INTO `tb_sales` VALUES ('201912160002', '000013', '300005', '20191111', '1.50', '20', '非VIP，打折');
INSERT INTO `tb_sales` VALUES ('201912160002', '000016', '300006', '20191111', '13.00','20', '非VIP，打折');
INSERT INTO `tb_sales` VALUES ('201912160002', '000019', '300007', '20191111', '31.50','20', '非VIP，打折');

-- 销售明细 2019-12-17
INSERT INTO `tb_sales` VALUES ('201912170001', '000001', '300001', '20191111', '1.00', '70', '非VIP，打折');
INSERT INTO `tb_sales` VALUES ('201912170001', '000004', '300002', '20191111', '3.00', '10', '非VIP，打折');
INSERT INTO `tb_sales` VALUES ('201912170001', '000007', '300003', '20191111', '1.50', '20', '非VIP，打折');
INSERT INTO `tb_sales` VALUES ('201912170002', '000010', '300004', '20191111', '53.00','10', '非VIP，打折');
INSERT INTO `tb_sales` VALUES ('201912170002', '000013', '300005', '20191111', '1.50', '20', '非VIP，打折');
INSERT INTO `tb_sales` VALUES ('201912170002', '000016', '300006', '20191111', '13.00','20', '非VIP，打折');

-- 销售明细 2019-12-18
INSERT INTO `tb_sales` VALUES ('201912180001', '000001', '300001', '20191111', '1.00', '40', '非VIP，打折');
INSERT INTO `tb_sales` VALUES ('201912180001', '000004', '300002', '20191111', '3.00', '10', '非VIP，打折');
INSERT INTO `tb_sales` VALUES ('201912180001', '000007', '300003', '20191111', '1.50', '40', '非VIP，打折');
INSERT INTO `tb_sales` VALUES ('201912180002', '000010', '300004', '20191111', '53.00','10', '非VIP，打折');
INSERT INTO `tb_sales` VALUES ('201912180002', '000013', '300005', '20191111', '1.50', '20', '非VIP，打折');
INSERT INTO `tb_sales` VALUES ('201912180002', '000016', '300006', '20191111', '13.00','20', '非VIP，打折');
INSERT INTO `tb_sales` VALUES ('201912180002', '000022', '300008', '20191111', '98.00','10', '非VIP，打折');

-- 12月份 2019.12.14 - 2019.12.24 后6天 不打折 当月批号
-- 销售明细 2019-12-19
INSERT INTO `tb_sales` VALUES ('201912190001', '000001', '300001', '20191212', '3.00', '20', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201912190001', '000002', '300001', '20191212', '3.00', '10', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201912190001', '000003', '300001', '20191212', '2.00', '20', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201912190002', '000011', '300004', '20191212', '20.00','20', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201912190002', '000012', '300004', '20191212', '8.00', '10', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201912190002', '000013', '300005', '20191212', '3.50', '20', '非VIP，不打折');

-- 销售明细 2019-12-20
INSERT INTO `tb_sales` VALUES ('201912200001', '000004', '300002', '20191212', '5.00', '20', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201912200001', '000005', '300002', '20191212', '55.00','10', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201912200001', '000006', '300002', '20191212', '5.00', '30', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201912200002', '000014', '300005', '20191212', '3.50', '20', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201912200002', '000015', '300005', '20191212', '3.50', '40', '非VIP，不打折');

-- 销售明细 2019-12-21
INSERT INTO `tb_sales` VALUES ('201912210001', '000007', '300003', '20191212', '3.50', '20', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201912210001', '000008', '300003', '20191212', '3.50', '10', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201912210001', '000009', '300003', '20191212', '3.50', '30', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201912210002', '000010', '300004', '20191212', '55.00','20', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201912210002', '000011', '300004', '20191212', '20.00','10', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201912210002', '000012', '300004', '20191212', '8.50', '20', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201912210002', '000013', '300005', '20191212', '3.50', '20', '非VIP，不打折');

-- 销售明细 2019-12-22
INSERT INTO `tb_sales` VALUES ('201912220001', '000001', '300001', '20191212', '3.00', '20', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201912220001', '000004', '300002', '20191212', '5.00', '10', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201912220001', '000007', '300003', '20191212', '3.50', '40', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201912220002', '000010', '300004', '20191212', '55.00','20', '非VIP，不打折');

-- 销售明细 2019-12-23
INSERT INTO `tb_sales` VALUES ('201912230001', '000001', '300001', '20191212', '3.00', '20', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201912230001', '000004', '300002', '20191212', '5.00', '10', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201912230001', '000005', '300002', '20191212', '55.00','30', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201912230002', '000012', '300004', '20191212', '8.00', '20', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201912230002', '000013', '300005', '20191212', '3.50', '10', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201912230002', '000014', '300005', '20191212', '3.50', '30', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201912230002', '000015', '300005', '20191212', '3.50', '10', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201912230002', '000021', '300007', '20191212', '23.50','10', '非VIP，不打折');

-- 销售明细 2019-12-24
INSERT INTO `tb_sales` VALUES ('201912240001', '000002', '300001', '20191212', '3.00', '20', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201912240001', '000004', '300002', '20191212', '5.00', '10', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201912240001', '000008', '300003', '20191212', '3.50', '20', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201912240002', '000010', '300004', '20191212', '55.00','20', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201912240002', '000013', '300005', '20191212', '3.50', '10', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201912240002', '000015', '300005', '20191212', '3.50', '30', '非VIP，不打折');
INSERT INTO `tb_sales` VALUES ('201912240002', '000019', '300007', '20191212', '33.50','20', '非VIP，不打折');

-- 1月份 2020.01.03 - 2020.01.13 前5天 打折销售 上月批号
-- 销售明细 2020-01-03 
INSERT INTO `tb_sales` VALUES ('202001030001', '000001', '300001', '20191212', '1.00',  '30', '促销价');
INSERT INTO `tb_sales` VALUES ('202001030001', '000004', '300002', '20191212', '3.00',  '20', '促销价');
INSERT INTO `tb_sales` VALUES ('202001030001', '000007', '300003', '20191212', '1.50',  '10', '促销价');
INSERT INTO `tb_sales` VALUES ('202001030001', '000010', '300004', '20191212', '53.00', '40', '促销价');
INSERT INTO `tb_sales` VALUES ('202001030002', '000013', '300005', '20191212', '1.50',  '10', '促销价');
INSERT INTO `tb_sales` VALUES ('202001030002', '000016', '300006', '20191212', '13.00', '30', '促销价');
INSERT INTO `tb_sales` VALUES ('202001030002', '000019', '300007', '20191212', '31.50', '40', '促销价');
INSERT INTO `tb_sales` VALUES ('202001030002', '000022', '300008', '20191212', '98.00', '20', '促销价');

-- 销售明细 2020-01-04 
INSERT INTO `tb_sales` VALUES ('202001040001', '000001', '300001', '20191212', '1.00',  '20', '促销价');
INSERT INTO `tb_sales` VALUES ('202001040001', '000004', '300002', '20191212', '3.00',  '10', '促销价');
INSERT INTO `tb_sales` VALUES ('202001040001', '000007', '300003', '20191212', '1.50',  '30', '促销价');
INSERT INTO `tb_sales` VALUES ('202001040001', '000010', '300004', '20191212', '53.00', '20', '促销价');
INSERT INTO `tb_sales` VALUES ('202001040002', '000013', '300005', '20191212', '1.50',  '50', '促销价');
INSERT INTO `tb_sales` VALUES ('202001040002', '000016', '300006', '20191212', '13.00', '20', '促销价');
INSERT INTO `tb_sales` VALUES ('202001040002', '000019', '300007', '20191212', '31.50', '40', '促销价');
INSERT INTO `tb_sales` VALUES ('202001040002', '000022', '300008', '20191212', '98.00', '80', '促销价');

-- 销售明细 2020-01-05 
INSERT INTO `tb_sales` VALUES ('202001050001', '000001', '300001', '20191212', '1.00',  '20', '促销价');
INSERT INTO `tb_sales` VALUES ('202001050001', '000016', '300006', '20191212', '13.00', '20', '促销价');
INSERT INTO `tb_sales` VALUES ('202001050001', '000019', '300007', '20191212', '31.50', '40', '促销价');
INSERT INTO `tb_sales` VALUES ('202001050001', '000010', '300004', '20191212', '53.00', '20', '促销价');
INSERT INTO `tb_sales` VALUES ('202001050002', '000013', '300005', '20191212', '1.50',  '50', '促销价');
INSERT INTO `tb_sales` VALUES ('202001050002', '000004', '300002', '20191212', '3.00',  '10', '促销价');
INSERT INTO `tb_sales` VALUES ('202001050002', '000007', '300003', '20191212', '1.50',  '30', '促销价');
INSERT INTO `tb_sales` VALUES ('202001050002', '000022', '300008', '20191212', '98.00', '20', '促销价');

-- 销售明细 2020-01-06
INSERT INTO `tb_sales` VALUES ('202001060001', '000001', '300001', '20191212', '1.00',  '80', '促销价');
INSERT INTO `tb_sales` VALUES ('202001060001', '000016', '300006', '20191212', '13.00', '50', '促销价');
INSERT INTO `tb_sales` VALUES ('202001060001', '000019', '300007', '20191212', '31.50', '20', '促销价');
INSERT INTO `tb_sales` VALUES ('202001060001', '000022', '300008', '20191212', '98.00', '30', '促销价');
INSERT INTO `tb_sales` VALUES ('202001060002', '000010', '300004', '20191212', '53.00', '50', '促销价');
INSERT INTO `tb_sales` VALUES ('202001060002', '000004', '300002', '20191212', '3.00',  '90', '促销价');
INSERT INTO `tb_sales` VALUES ('202001060002', '000007', '300003', '20191212', '1.50',  '40', '促销价');
INSERT INTO `tb_sales` VALUES ('202001060002', '000013', '300005', '20191212', '1.50',  '70', '促销价');

-- 销售明细 2020-01-07
INSERT INTO `tb_sales` VALUES ('202001070001', '000001', '300001', '20191212', '1.00',  '80', '促销价');
INSERT INTO `tb_sales` VALUES ('202001070001', '000010', '300004', '20191212', '53.00', '50', '促销价');
INSERT INTO `tb_sales` VALUES ('202001070001', '000013', '300005', '20191212', '1.50',  '70', '促销价');
INSERT INTO `tb_sales` VALUES ('202001070001', '000019', '300007', '20191212', '31.50', '20', '促销价');
INSERT INTO `tb_sales` VALUES ('202001070002', '000004', '300002', '20191212', '3.00',  '90', '促销价');
INSERT INTO `tb_sales` VALUES ('202001070002', '000007', '300003', '20191212', '1.50',  '40', '促销价');
INSERT INTO `tb_sales` VALUES ('202001070002', '000016', '300006', '20191212', '13.00', '50', '促销价');
INSERT INTO `tb_sales` VALUES ('202001070002', '000022', '300008', '20191212', '98.00', '30', '促销价');

-- 1月份 2020.01.03 - 2020.01.13 后6天 不打折销售 当月批号
-- 销售明细 2020-01-08
INSERT INTO `tb_sales` VALUES ('202001080001', '000001', '300001', '20200101', '3.00',   '90', '原价，不打折');
INSERT INTO `tb_sales` VALUES ('202001080001', '000003', '300001', '20200101', '2.00',   '70', '原价，不打折');
INSERT INTO `tb_sales` VALUES ('202001080001', '000008', '300003', '20200101', '3.50',   '30', '原价，不打折');
INSERT INTO `tb_sales` VALUES ('202001080001', '000010', '300004', '20200101', '55.00',  '10', '原价，不打折');
INSERT INTO `tb_sales` VALUES ('202001080001', '000012', '300004', '20200101', '8.00',   '10', '原价，不打折');
INSERT INTO `tb_sales` VALUES ('202001080001', '000013', '300005', '20200101', '3.50',   '10', '原价，不打折');
INSERT INTO `tb_sales` VALUES ('202001080001', '000018', '300006', '20200101', '8.00',   '10', '原价，不打折');
INSERT INTO `tb_sales` VALUES ('202001080001', '000020', '300007', '20200101', '13.50',  '10', '原价，不打折');
INSERT INTO `tb_sales` VALUES ('202001080001', '000021', '300007', '20200101', '23.50',  '10', '原价，不打折');
INSERT INTO `tb_sales` VALUES ('202001080001', '000022', '300008', '20200101', '100.00', '10', '原价，不打折');
INSERT INTO `tb_sales` VALUES ('202001080001', '000023', '300008', '20200101', '100.00', '10', '原价，不打折');
INSERT INTO `tb_sales` VALUES ('202001080002', '000002', '300001', '20200101', '3.00',   '10', '原价，不打折');
INSERT INTO `tb_sales` VALUES ('202001080002', '000004', '300002', '20200101', '5.00',   '10', '原价，不打折');
INSERT INTO `tb_sales` VALUES ('202001080002', '000005', '300002', '20200101', '55.00',  '10', '原价，不打折');
INSERT INTO `tb_sales` VALUES ('202001080002', '000006', '300002', '20200101', '5.00',   '10', '原价，不打折');
INSERT INTO `tb_sales` VALUES ('202001080002', '000007', '300003', '20200101', '3.50',   '10', '原价，不打折');
INSERT INTO `tb_sales` VALUES ('202001080002', '000009', '300003', '20200101', '3.50',   '10', '原价，不打折');
INSERT INTO `tb_sales` VALUES ('202001080002', '000011', '300004', '20200101', '20.00',  '10', '原价，不打折');
INSERT INTO `tb_sales` VALUES ('202001080002', '000014', '300005', '20200101', '3.50',   '10', '原价，不打折');
INSERT INTO `tb_sales` VALUES ('202001080002', '000015', '300005', '20200101', '3.50',   '10', '原价，不打折');
INSERT INTO `tb_sales` VALUES ('202001080002', '000016', '300006', '20200101', '15.00',  '10', '原价，不打折');
INSERT INTO `tb_sales` VALUES ('202001080002', '000017', '300006', '20200101', '5.00',   '10', '原价，不打折');
INSERT INTO `tb_sales` VALUES ('202001080002', '000019', '300007', '20200101', '33.50',  '10', '原价，不打折');
INSERT INTO `tb_sales` VALUES ('202001080002', '000024', '300008', '20200101', '100.00', '10', '原价，不打折');

-- 销售明细 2020-01-09
INSERT INTO `tb_sales` VALUES ('202001090001', '000002', '300001', '20200101', '3.00',   '10', '原价，不打折');
INSERT INTO `tb_sales` VALUES ('202001090001', '000003', '300001', '20200101', '2.00',   '10', '原价，不打折');
INSERT INTO `tb_sales` VALUES ('202001090001', '000004', '300002', '20200101', '5.00',   '10', '原价，不打折');
INSERT INTO `tb_sales` VALUES ('202001090001', '000009', '300003', '20200101', '3.50',   '10', '原价，不打折');
INSERT INTO `tb_sales` VALUES ('202001090001', '000010', '300004', '20200101', '55.00',  '10', '原价，不打折');
INSERT INTO `tb_sales` VALUES ('202001090001', '000021', '300007', '20200101', '23.50',  '10', '原价，不打折');
INSERT INTO `tb_sales` VALUES ('202001090002', '000003', '300001', '20200101', '2.00',   '80', '原价，不打折');
INSERT INTO `tb_sales` VALUES ('202001090002', '000004', '300002', '20200101', '5.00',   '10', '原价，不打折');
INSERT INTO `tb_sales` VALUES ('202001090002', '000006', '300002', '20200101', '5.00',   '20', '原价，不打折');
INSERT INTO `tb_sales` VALUES ('202001090002', '000007', '300003', '20200101', '3.50',   '10', '原价，不打折');
INSERT INTO `tb_sales` VALUES ('202001090002', '000017', '300006', '20200101', '5.00',   '10', '原价，不打折');
INSERT INTO `tb_sales` VALUES ('202001090002', '000018', '300006', '20200101', '8.00',   '10', '原价，不打折');
INSERT INTO `tb_sales` VALUES ('202001090002', '000019', '300007', '20200101', '33.50',  '10', '原价，不打折');
INSERT INTO `tb_sales` VALUES ('202001090002', '000020', '300007', '20200101', '13.50',  '10', '原价，不打折');

-- 销售明细 2020-01-10
INSERT INTO `tb_sales` VALUES ('202001100001', '000009', '300003', '20200101', '3.50',   '80', '原价，不打折');
INSERT INTO `tb_sales` VALUES ('202001100001', '000010', '300004', '20200101', '55.00',  '10', '原价，不打折');
INSERT INTO `tb_sales` VALUES ('202001100001', '000011', '300004', '20200101', '20.00',  '10', '原价，不打折');
INSERT INTO `tb_sales` VALUES ('202001100001', '000012', '300004', '20200101', '8.00',   '10', '原价，不打折');
INSERT INTO `tb_sales` VALUES ('202001100001', '000013', '300005', '20200101', '3.50',   '20', '原价，不打折');
INSERT INTO `tb_sales` VALUES ('202001100001', '000014', '300005', '20200101', '3.50',   '10', '原价，不打折');
INSERT INTO `tb_sales` VALUES ('202001100001', '000021', '300007', '20200101', '23.50',  '10', '原价，不打折');
INSERT INTO `tb_sales` VALUES ('202001100001', '000022', '300008', '20200101', '100.00', '10', '原价，不打折');
INSERT INTO `tb_sales` VALUES ('202001100002', '000003', '300001', '20200101', '2.00',   '80', '原价，不打折');
INSERT INTO `tb_sales` VALUES ('202001100002', '000004', '300002', '20200101', '5.00',   '10', '原价，不打折');
INSERT INTO `tb_sales` VALUES ('202001100002', '000012', '300004', '20200101', '8.00',   '10', '原价，不打折');
INSERT INTO `tb_sales` VALUES ('202001100002', '000013', '300005', '20200101', '3.50',   '30', '原价，不打折');
INSERT INTO `tb_sales` VALUES ('202001100002', '000019', '300007', '20200101', '33.50',  '10', '原价，不打折');
INSERT INTO `tb_sales` VALUES ('202001100002', '000020', '300007', '20200101', '13.50',  '20', '原价，不打折');
INSERT INTO `tb_sales` VALUES ('202001100002', '000021', '300007', '20200101', '23.50',  '10', '原价，不打折');

-- 销售明细 2020-01-11
INSERT INTO `tb_sales` VALUES ('202001110001', '000002', '300001', '20200101', '3.00',   '50', '原价，不打折');
INSERT INTO `tb_sales` VALUES ('202001110001', '000005', '300002', '20200101', '55.00',  '10', '原价，不打折');
INSERT INTO `tb_sales` VALUES ('202001110001', '000010', '300004', '20200101', '55.00',  '20', '原价，不打折');
INSERT INTO `tb_sales` VALUES ('202001110001', '000011', '300004', '20200101', '20.00',  '70', '原价，不打折');
INSERT INTO `tb_sales` VALUES ('202001110001', '000012', '300004', '20200101', '8.00',   '30', '原价，不打折');
INSERT INTO `tb_sales` VALUES ('202001110001', '000018', '300006', '20200101', '8.00',   '10', '原价，不打折');
INSERT INTO `tb_sales` VALUES ('202001110001', '000024', '300008', '20200101', '100.00', '20', '原价，不打折');
INSERT INTO `tb_sales` VALUES ('202001110002', '000003', '300001', '20200101', '2.00',   '40', '原价，不打折');
INSERT INTO `tb_sales` VALUES ('202001110002', '000004', '300002', '20200101', '5.00',   '10', '原价，不打折');
INSERT INTO `tb_sales` VALUES ('202001110002', '000006', '300002', '20200101', '5.00',   '20', '原价，不打折');
INSERT INTO `tb_sales` VALUES ('202001110002', '000007', '300003', '20200101', '3.50',   '40', '原价，不打折');
INSERT INTO `tb_sales` VALUES ('202001110002', '000009', '300003', '20200101', '3.50',   '30', '原价，不打折');
INSERT INTO `tb_sales` VALUES ('202001110002', '000010', '300004', '20200101', '55.00',  '10', '原价，不打折');
INSERT INTO `tb_sales` VALUES ('202001110002', '000018', '300006', '20200101', '8.00',   '20', '原价，不打折');
INSERT INTO `tb_sales` VALUES ('202001110002', '000019', '300007', '20200101', '33.50',  '10', '原价，不打折');

-- 销售明细 2020-01-12
INSERT INTO `tb_sales` VALUES ('202001120001', '000001', '300001', '20200101', '3.00',   '70', '原价，不打折');
INSERT INTO `tb_sales` VALUES ('202001120001', '000006', '300002', '20200101', '5.00',   '30', '原价，不打折');
INSERT INTO `tb_sales` VALUES ('202001120001', '000017', '300006', '20200101', '5.00',   '90', '原价，不打折');
INSERT INTO `tb_sales` VALUES ('202001120001', '000023', '300008', '20200101', '100.00', '10', '原价，不打折');
INSERT INTO `tb_sales` VALUES ('202001120002', '000005', '300002', '20200101', '55.00',  '30', '原价，不打折');
INSERT INTO `tb_sales` VALUES ('202001120002', '000015', '300005', '20200101', '3.50',   '70', '原价，不打折');
INSERT INTO `tb_sales` VALUES ('202001120002', '000019', '300007', '20200101', '33.50',  '80', '原价，不打折');
INSERT INTO `tb_sales` VALUES ('202001120002', '000020', '300007', '20200101', '13.50',  '30', '原价，不打折');
INSERT INTO `tb_sales` VALUES ('202001120002', '000021', '300007', '20200101', '23.50',  '90', '原价，不打折');
INSERT INTO `tb_sales` VALUES ('202001120002', '000022', '300008', '20200101', '100.00', '20', '原价，不打折');

-- 销售明细 2020-01-13
INSERT INTO `tb_sales` VALUES ('202001130001', '000002', '300001', '20200101', '3.00',   '40', '原价，不打折');
INSERT INTO `tb_sales` VALUES ('202001130001', '000003', '300001', '20200101', '2.00',   '60', '原价，不打折');
INSERT INTO `tb_sales` VALUES ('202001130001', '000011', '300004', '20200101', '20.00',  '20', '原价，不打折');
INSERT INTO `tb_sales` VALUES ('202001130001', '000012', '300004', '20200101', '8.00',   '70', '原价，不打折');
INSERT INTO `tb_sales` VALUES ('202001130001', '000018', '300006', '20200101', '8.00',   '60', '原价，不打折');
INSERT INTO `tb_sales` VALUES ('202001130001', '000019', '300007', '20200101', '33.50',  '30', '原价，不打折');
INSERT INTO `tb_sales` VALUES ('202001130002', '000005', '300002', '20200101', '55.00',  '10', '原价，不打折');
INSERT INTO `tb_sales` VALUES ('202001130002', '000009', '300003', '20200101', '3.50',   '60', '原价，不打折');
INSERT INTO `tb_sales` VALUES ('202001130002', '000015', '300005', '20200101', '3.50',   '70', '原价，不打折');
INSERT INTO `tb_sales` VALUES ('202001130002', '000019', '300007', '20200101', '33.50',  '30', '原价，不打折');
INSERT INTO `tb_sales` VALUES ('202001130002', '000024', '300008', '20200101', '100.00', '40', '原价，不打折');


-- 销售记录
INSERT INTO `tb_sale` VALUES ('201911130001', '60', '215.00',  '220.00',  '5.00',  '64.50',  '2019-11-13', '10:08:00', '100001', DEFAULT, '现金支付');
INSERT INTO `tb_sale` VALUES ('201911140001', '30', '110.00',  '200.00',  '90.00', '33.00',  '2019-11-14', '11:08:00', '100001', DEFAULT, '现金支付');
INSERT INTO `tb_sale` VALUES ('201911140002', '40', '255.00',  '300.00',  '45.00', '76.50',  '2019-11-14', '12:18:00', '100001', DEFAULT, '现金支付');
INSERT INTO `tb_sale` VALUES ('201911150001', '60', '215.00',  '300.00',  '85.00', '64.50',  '2019-11-15', '10:09:10', '100001', DEFAULT, '现金支付');
INSERT INTO `tb_sale` VALUES ('201911150002', '50', '420.00',  '420.00',  '0.00',  '126.00', '2019-11-15', '18:18:20', '100001', DEFAULT, '电子支付');
INSERT INTO `tb_sale` VALUES ('201911160001', '30', '110.00',  '110.00',  '0.00',  '33.00',  '2019-11-16', '10:12:30', '100001', DEFAULT, '电子支付');
INSERT INTO `tb_sale` VALUES ('201911160002', '70', '975.00',  '1000.00', '25.00', '292.50', '2019-11-16', '18:19:40', '100001', DEFAULT, '现金支付');
INSERT INTO `tb_sale` VALUES ('201911170001', '70', '415.00',  '500.00',  '85.00', '124.50', '2019-11-17', '13:08:10', '100001', DEFAULT, '现金支付');
INSERT INTO `tb_sale` VALUES ('201911170002', '80', '345.00',  '345.00',  '0.00',  '103.50', '2019-11-17', '12:18:01', '100001', DEFAULT, '电子支付');
INSERT INTO `tb_sale` VALUES ('201911180001', '70', '765.00',  '800.00',  '45.00', '220.50', '2019-11-18', '10:28:40', '100001', DEFAULT, '现金支付');

INSERT INTO `tb_sale` VALUES ('201911180002', '50', '490.00',  '500.00',  '10.00', '147.00', '2019-11-18', '13:28:10', '100001', DEFAULT,  '现金支付');
INSERT INTO `tb_sale` VALUES ('201911190001', '80', '285.00',  '300.00',  '15.00', '85.50',  '2019-11-19', '13:28:40', '100001', DEFAULT,  '现金支付');
INSERT INTO `tb_sale` VALUES ('201911190002', '50', '920.00',  '920.00',  '0.00',  '276.00', '2019-11-19', '14:18:10', '100001', DEFAULT,  '电子支付');
INSERT INTO `tb_sale` VALUES ('201911200001', '80', '360.00',  '400.00',  '40.00', '108.00', '2019-11-20', '13:28:42', '100001', '200001', '现金支付');
INSERT INTO `tb_sale` VALUES ('201911200002', '60', '1525.00', '1525.00', '0.00',  '457.50', '2019-11-20', '11:18:11', '100001', '200001', '电子支付');
INSERT INTO `tb_sale` VALUES ('201911210001', '130','685.00',  '700.00',  '15.00', '205.50', '2019-11-21', '17:28:41', '100001', '200001', '现金支付');
INSERT INTO `tb_sale` VALUES ('201911210002', '40', '600.00',  '600.00',  '0.00',  '180.00', '2019-11-21', '14:18:13', '100001', '200001', '现金支付');
INSERT INTO `tb_sale` VALUES ('201911220001', '90', '335.00',  '400.00',  '65.00', '102.00', '2019-11-22', '11:18:40', '100001', '200001', '现金支付');
INSERT INTO `tb_sale` VALUES ('201911220002', '60', '830.00',  '830.00',  '0.00',  '249.00', '2019-11-22', '14:34:10', '100001', '200001', '电子支付');
INSERT INTO `tb_sale` VALUES ('201911230001', '60', '215.00',  '300.00',  '85.00', '64.50',  '2019-11-23', '16:28:40', '100001', '200001', '现金支付');

INSERT INTO `tb_sale` VALUES ('201911230002', '90', '1150.00', '1150.00', '0.00',  '345.00', '2019-11-23', '10:18:10', '100001', '200001', '电子支付');
INSERT INTO `tb_sale` VALUES ('201912140001', '100','180.00',  '200.00',  '20.00', '54.00',  '2019-12-14', '06:54:54', '100001', '200002', '现金支付');
INSERT INTO `tb_sale` VALUES ('201912140002', '70', '1450.00', '150.00',  '50.00', '435.00', '2019-12-14', '07:54:54', '100001', '200002', '现金支付');
INSERT INTO `tb_sale` VALUES ('201912150001', '110','220.00',  '220.00',  '0.00',  '66.00',  '2019-12-15', '08:54:54', '100001', '200002', '电子支付');
INSERT INTO `tb_sale` VALUES ('201912150002', '60', '2250.00', '2300.00', '50.00', '675.00', '2019-12-15', '09:54:54', '100001', '200002', '现金支付');
INSERT INTO `tb_sale` VALUES ('201912160001', '110','220.00',  '220.00',  '0.00',  '66.00',  '2019-12-16', '13:54:54', '100001', '200002', '现金支付');
INSERT INTO `tb_sale` VALUES ('201912160002', '70', '1450.00', '1500.00', '50.00', '444.00', '2019-12-16', '15:54:54', '100001', '200002', '现金支付');
INSERT INTO `tb_sale` VALUES ('201912170001', '100','130.00',  '130.00',  '0.00',  '39.00',  '2019-12-17', '16:54:54', '100001', '200002', '现金支付');
INSERT INTO `tb_sale` VALUES ('201912170002', '50', '820.00',  '900.00',  '80.00', '246.00', '2019-12-17', '17:54:54', '100001', '200003', '现金支付');
INSERT INTO `tb_sale` VALUES ('201912180001', '90', '130.00',  '200.00',  '70.00', '39.00',  '2019-12-18', '19:54:54', '100001', '200003', '现金支付');
INSERT INTO `tb_sale` VALUES ('201912180002', '60', '1800.00', '1800.00', '0.00',  '540.00', '2019-12-18', '20:54:54', '100001', '200003', '电子支付');
INSERT INTO `tb_sale` VALUES ('201912190001', '50', '130.00',  '150.00',  '20.00', '39.00',  '2019-12-19', '07:54:54', '100001', '200003', '现金支付');
INSERT INTO `tb_sale` VALUES ('201912190002', '50', '550.00',  '550.00',  '0.00',  '165.00', '2019-12-19', '21:54:54', '100001', '200003', '电子支付');

INSERT INTO `tb_sale` VALUES ('201912200001', '60', '800.00',  '800.00',  '0.00', '240.00',   '2019-12-20', '08:54:54', '100001', '200003', '现金支付');
INSERT INTO `tb_sale` VALUES ('201912200002', '60', '210.00',  '210.00',  '0.00', '63.00',    '2019-12-20', '09:54:54', '100001', '200003', '电子支付');
INSERT INTO `tb_sale` VALUES ('201912210001', '60', '210.00',  '210.00',  '0.00', '63.00',    '2019-12-21', '13:54:54', '100001', '200003', '电子支付');
INSERT INTO `tb_sale` VALUES ('201912210002', '70', '1540.00', '1540.00', '0.00', '462.00',   '2019-12-21', '15:54:54', '100001', '200003', '电子支付');
INSERT INTO `tb_sale` VALUES ('201912220001', '70', '250.00',  '250.00',  '0.00', '75.00',    '2019-12-22', '16:54:54', '100001', '200003', '现金支付');
INSERT INTO `tb_sale` VALUES ('201912220002', '20', '1100.00', '1100.00', '0.00', '330.00',   '2019-12-22', '17:54:54', '100001', '200004', '现金支付');
INSERT INTO `tb_sale` VALUES ('201912230001', '60', '1760.00', '1800.00', '40.00','528.00',   '2019-12-23', '19:54:54', '100001', '200004', '现金支付');
INSERT INTO `tb_sale` VALUES ('201912230002', '80', '570.00',  '600.00',  '30.00', '171.00',  '2019-12-23', '20:54:54', '100001', '200004', '现金支付');
INSERT INTO `tb_sale` VALUES ('201912240001', '50', '180.00',  '200.00',  '20.00', '54.00',   '2019-12-24', '19:54:54', '100001', '200004', '现金支付');
INSERT INTO `tb_sale` VALUES ('201912240002', '80', '1910.00', '2000.00', '90.00', '573.00',  '2019-12-24', '20:54:54', '100001', '200004', '现金支付');

INSERT INTO `tb_sale` VALUES ('202001030001', '100','2225.00', '2225.00', '0.00', '190.05',    '2020-01-03', '10:08:00', '100001', DEFAULT, '电子支付');
INSERT INTO `tb_sale` VALUES ('202001030002', '100','3625.00', '3625.00', '0.00',  '1087.05',  '2020-01-03', '11:08:00', '100001', DEFAULT, '电子支付');
INSERT INTO `tb_sale` VALUES ('202001040001', '80', '1155.00', '1200.00', '45.00', '346.05',   '2020-01-04', '10:08:00', '100001', DEFAULT, '现金支付');
INSERT INTO `tb_sale` VALUES ('202001040002', '190','9435.00', '9500.00', '65.00', '2830.05',  '2020-01-04', '11:08:00', '100001', DEFAULT, '现金支付');
INSERT INTO `tb_sale` VALUES ('202001050001', '100','2600.00', '2600.00', '0.00',  '780.00',   '2020-01-05', '10:08:00', '100001', DEFAULT, '现金支付');
INSERT INTO `tb_sale` VALUES ('202001050002', '110','2110.00', '2200.00', '90.00', '633.00',   '2020-01-05', '11:08:00', '100001', DEFAULT, '现金支付');
INSERT INTO `tb_sale` VALUES ('202001060001', '180','4300.00', '4300.00', '0.00',  '1290.00',  '2020-01-06', '10:08:00', '100001', DEFAULT, '电子支付');
INSERT INTO `tb_sale` VALUES ('202001060002', '250','3085.00', '3100.00', '15.00', '925.05',   '2020-01-06', '11:08:00', '100001', DEFAULT, '现金支付');
INSERT INTO `tb_sale` VALUES ('202001070001', '220','3465.00', '3465.00', '0.00',  '1039.05',  '2020-01-07', '10:08:00', '100001', DEFAULT, '电子支付');
INSERT INTO `tb_sale` VALUES ('202001070002', '210','3920.00', '3920.00', '0.00',  '1176.00',  '2020-01-07', '11:08:00', '100001', DEFAULT, '电子支付');

INSERT INTO `tb_sale` VALUES ('202001080001', '270','3630.00', '3700.00', '70.00', '1089.00', '2020-01-08', '10:08:00', '100001', DEFAULT, '现金支付');
INSERT INTO `tb_sale` VALUES ('202001080002', '130','2555.00', '2600.00', '45.00', '766.00',  '2020-01-08', '11:08:00', '100001', DEFAULT, '现金支付');
INSERT INTO `tb_sale` VALUES ('202001090001', '60', '920.00',  '1000.00', '80.00', '276.00',  '2020-01-09', '10:08:00', '100001', DEFAULT, '现金支付');
INSERT INTO `tb_sale` VALUES ('202001090002', '160','945.00',  '945.00',  '0.00',  '283.00',  '2020-01-09', '11:08:00', '100001', DEFAULT, '电子支付');
INSERT INTO `tb_sale` VALUES ('202001100001', '160','2450.00', '2450.00', '0.00',  '735.00',  '2020-01-10', '10:08:00', '100001', DEFAULT, '电子支付');
INSERT INTO `tb_sale` VALUES ('202001100002', '170','1235.00', '1235.00', '0.00',  '270.00',  '2020-01-10', '11:08:00', '100001', DEFAULT, '现金支付');
INSERT INTO `tb_sale` VALUES ('202001110001', '210','5520.00', '5600.00', '80.00', '1656.00', '2020-01-11', '10:08:00', '100001', DEFAULT, '现金支付');
INSERT INTO `tb_sale` VALUES ('202001110002', '180','1520.00', '2000.00', '80.00', '456.00',  '2020-01-11', '11:08:00', '100001', DEFAULT, '现金支付');
INSERT INTO `tb_sale` VALUES ('202001120001', '200','1810.00', '1900.00', '90.00', '543.00',  '2020-01-12', '10:08:00', '100001', DEFAULT, '现金支付');
INSERT INTO `tb_sale` VALUES ('202001120002', '320','9095.00', '9100.00', '5.00',  '2728.00', '2020-01-12', '11:08:00', '100001', DEFAULT, '现金支付');
INSERT INTO `tb_sale` VALUES ('202001130001', '280','2685.00', '2700.00', '15.00', '805.00',  '2020-01-13', '10:08:00', '100001', DEFAULT, '现金支付');
INSERT INTO `tb_sale` VALUES ('202001130002', '210','6010.00', '6100.00', '90.00', '1803.00', '2020-01-13', '11:08:00', '100001', DEFAULT, '现金支付');





