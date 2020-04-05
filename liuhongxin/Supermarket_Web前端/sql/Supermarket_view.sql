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
-- ----------------------------
-- *****视图sql语句*********
-- SQL Query test
-- ----------------------------


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
stockMax,stockAlarm,tb_stock.note
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

