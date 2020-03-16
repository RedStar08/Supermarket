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
create view goods_info as select tb_goods.goodsID,goodsName,goodsType,goodsPrice,goodsSpecs,goodsSave,supplierName,produceID,produceDate,produceArea,tb_goodinfo.note 
from tb_goods,tb_goodinfo,tb_supplier 
where tb_goods.goodsID = tb_goodinfo.goodsID and tb_supplier.supplierID = tb_goodinfo.supplierID;

-- 商品折扣表视图
create view goods_discount as select distinct tb_discount.goodsID, goodsName, goodsType, goodsPrice, disPrice,tb_discount.produceID, disStart, disEnd,
date_add(produceDate,interval goodsSave day) expirationDate,tb_discount.note 
from tb_discount,tb_goods,tb_goodinfo 
where tb_discount.goodsID = tb_goods.goodsID and tb_discount.goodsID = tb_goodinfo.goodsID 
and tb_goodinfo.goodsID = tb_goods.goodsID and tb_goodinfo.produceID =tb_discount.produceID;

-- 供应批次视图
create view produce as select tb_produce.goodsID,goodsName,tb_produce.supplierID,supplierName,produceID,tb_produce.note 
from tb_goods,tb_supplier,tb_produce 
where tb_produce.goodsID = tb_goods.goodsID 
and tb_produce.supplierID = tb_supplier.supplierID;


INSERT INTO `tb_user` VALUES ('100050', 'admin', '刘宏鑫', '男', '23', '0', '数据库管理员','18856307075', '0');