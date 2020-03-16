/*
MySQL Code

Host           : localhost:3306
Database       : supermarket
Target Server Type    : MYSQL

Date: 2020-02-02 22:22:22

          ID varchar(100)
备注： 0表示商品ID      000001
      1表示员工ID      100001
      2表示会员ID      200001
      3表示供应商ID    300001
      4表示仓库ID      400001
*/
-- ----------------------------
-- *******控制台sql语句*********
-- ******SQL Query test********
-- ----------------------------

商品数：SELECT count(*) FROM `tb_goods`;
仓库数：SELECT count(*) FROM `tb_store`;
供应商：SELECT count(*) FROM `tb_supplier`;
员工：SELECT count(*) FROM `tb_user`;
今日销售额：SELECT sum(salesSum) FROM `tb_sale` where salesDate ='2019-11-15';
总销售额：SELECT sum(salesSum) FROM `tb_sale`;

-- ----------------------------
-- *******商品管理sql语句*******
-- ******SQL Query test********
-- ----------------------------

-- ----------------------------
-- *********1、商品列表*********
-- ----------------------------
-- 1、增：
INSERT INTO `tb_goods` VALUES ('{$goodsID}', '{$goodsName}', '{$goodsPrice}',  
	'{$goodsType}', '{$goodsSpecs}', '{$goodsSave}', '{$note}');

-- 2、删：
Delete from tb_goods where goodsID ='$goodsID'
Delete from tb_goods where goodsID ='$id' 

-- 3、改：
update tb_goods set goodsName ='$goodsName',goodsPrice='$goodsPrice',goodsType ='$goodsType',
	goodsSpecs = '$goodsSpecs',goodsSave='$goodsSave',note='$note' where goodsID='$goodsID'

-- 4、查：
-- 商品序号
select count(*) from tb_goods where goodsID <= '$goodsID';
-- 从第amount个元组开始显示pagesize个元组
select * from tb_goods limit {$amount},{$pagesize};
-- 商品数量：
select count(*) from `tb_goods`;
-- 指定元组
Select count(*) from tb_goods where goodsID = '$goodsID';
-- 已知商品ID 和 生产批号 要求得到过期日期，商品姓名，原价，商品类型
select distinct date_add(produceDate,interval goodsSave day) expirationDate,goodsName,goodsPrice,goodsType
from tb_goods,tb_goodinfo where tb_goods.goodsID='$goodsID' and produceID='$produceID';

--5、视图



-- ----------------------------
-- ********2、销售商品列表*******
-- ----------------------------
-- tb_goodinfo
-- 1、增：
--INSERT INTO `tb_goodinfo` VALUES ('{$goodsID}' ,'{$supplierID}' ,'{$produceID}' ,'{$produceDate}' ,'{$produceArea}','{$note}' );

-- 2、删：
--delete from tb_goodinfo where goodsID='{$goodsID}' ,supplierID='{$supplierID}' ,produceID='{$produceID}';

-- 3、改：
--update tb_goodinfo set goodsID='{$goodsID}' ,supplierID='{$supplierID}' ,produceID='{$produceID}',produceDate='{$produceDate}' ,
--	produceArea='{$produceArea}',note='{$note}' where goodsID='{$goodsID}' ,supplierID='{$supplierID}' ,produceID='{$produceID}';

-- 4、查：
--select * from tb_goodinfo where goodsID='{$goodsID}' ,supplierID='{$supplierID}' ,produceID='{$produceID}';

-- 5、视图：
create view goods_info as select tb_goods.goodsID,goodsName,goodsType,goodsPrice,goodsSpecs,goodsSave,supplierName,produceID,produceDate,produceArea,tb_goodinfo.note 
from tb_goods,tb_goodinfo,tb_supplier 
where tb_goods.goodsID = tb_goodinfo.goodsID and tb_supplier.supplierID = tb_goodinfo.supplierID

select * from goods_info;
-- ----------------------------
-- *********3、折扣商品*********
-- ----------------------------
-- 1、增：
INSERT INTO `tb_discount` VALUES ('{$goodsID}', '$produceID', '{$disPrice}','{$disStart}','{$disEnd}','{$note}');

-- 2、删：
Delete from tb_discount where goodsID ='$goodsIDSet[$i]'and produceID ='$produceSet[$i]';

-- 3、改：
update tb_discount set goodsID ='$goodsID',produceID='$produceID',disPrice ='$disPrice',
	disStart = '$disStart',disEnd='$disEnd',note='$note' where goodsID='$goodsID' and produceID = '$produceID'

-- 4、查：
-- 已知开始日期，截止日期
select * from goods_discount where ((disStart >= '{$disStart}' and disStart <= '{$disEnd}')
	or (disEnd >= '{$disStart}' and disEnd <= '{$disEnd}'));

-- 已知商品ID
select * from goods_discount where goodsID = '{$goodsID}';

-- 检查重复
select count(*) from tb_discount where goodsID = '{$goodsID}' and produceID ='{$produceID}';
--折扣商品数量：
select count(*) from `tb_discount`;

-- 5、视图
-- 折扣商品视图
create view goods_discount as select distinct tb_discount.goodsID, goodsName, goodsType, goodsPrice, disPrice,tb_discount.produceID, disStart, disEnd,
date_add(produceDate,interval goodsSave day) expirationDate,tb_discount.note 
from tb_discount,tb_goods,tb_goodinfo 
where tb_discount.goodsID = tb_goods.goodsID and tb_discount.goodsID = tb_goodinfo.goodsID 
and tb_goodinfo.goodsID = tb_goods.goodsID and tb_goodinfo.produceID =tb_discount.produceID


-- ----------------------------
-- *******账单管理sql语句*******
-- ******SQL Query test********
-- ----------------------------

-- ----------------------------
-- *********1、销售订单*********
-- ----------------------------
-- 1、增：

-- 2、删：

-- 3、改：

-- 4、查：
SELECT sum(salesSum) FROM `tb_sale` group by salesDate having salesDate='$data'
SELECT sum(salesSum) FROM `tb_sale`

-- 5、视图：
select salesID,salesSum,salesMoney,salesChange,CONCAT_WS('  ',salesDate,salesTime ),note
from tb_sale where salesID = '{$salesID}';

-- ----------------------------
-- ********1.1、订单详情********
-- ----------------------------
-- 1、增：

-- 2、删：

-- 3、改：

-- 4、查：
--商品数量：
select count(*) from tb_sales where salesID = '{$salesID}';
--应收款：
select salesSum from tb_sale where salesID = '{$salesID}';
--实收款：
select salesMoney from tb_sale where salesID = '{$salesID}';
--找零：
select salesChange from tb_sale where salesID = '{$salesID}';

-- 5、视图
select goodsName,salesPrice,salesNum,salesPrice*salesNum as 小计,tb_sales.note from tb_sales,tb_goods 
where tb_sales.goodsID = tb_goods.goodsID and salesID = '{$salesID}';


-- ----------------------------
-- *********2、盈亏状况*********
-- ----------------------------
-- 1、增：

-- 2、删：

-- 3、改：

-- 4、查：

-- 5、视图：




-- ----------------------------
-- ******供应商管理sql语句******
-- ******SQL Query test********
-- ----------------------------
-- ----------------------------
-- ********1、供应商列表*********
-- ----------------------------
-- 1、增：
INSERT INTO `tb_supplier` VALUES ('{$supplierID}', '{$supplierName}','{$supplierManager}',
	'{$supplierPhone}','{$supplierAddress}','{$note}');
-- 2、删：
Delete from tb_supplier where supplierID ='$supplierID'
Delete from tb_supplier where supplierID ='$id'

-- 3、改：
update tb_supplier set supplierID='{$supplierID}' ,supplierName='{$supplierName}' ,supplierManager='{$supplierManager}' ,
supplierPhone='{$supplierPhone}' ,supplierAddress='{$supplierAddress}' ,note='{$note}' where supplierID='{$supplierID}';

-- 4、查：
-- 指定元组
select count(*) from tb_supplier where supplierID = '{$supplierID}'
-- 元组序号
select count(*) from tb_supplier where supplierID <= '$supplierID';
-- 元组个数
select count(*) from tb_supplier;
-- 从第amount个元组开始显示pagesize个元组
select * from tb_supplier limit {$amount},{$pagesize};

-- 5、视图：



-- ----------------------------
-- *********2、供应批次*********
-- ----------------------------

-- 1、增
INSERT INTO `tb_produce` VALUES ('{$goodsID}' ,'{$supplierID}' ,'{$produceID}' ,'{$note}' );

-- 2、删
-- 单项删除
delete from tb_produce where goodsID = '{$goodsID}' and supplierID='{$supplierID}' and produceID='{$produceID}';
-- 批量删除
delete  from tb_produce where goodsID = '{$goodsIDSet[$i]}' and supplierID='{$supplierIDSet[$i]}' and produceID='{$produceIDSet[$i]}';

-- 3、改
update tb_produce set goodsID = '{$goodsID}', supplierID='{$supplierID}', produceID='{$produceID}', note='{$note}' 
where goodsID = '{$goodsID}', supplierID='{$supplierID}', produceID='{$produceID}';

-- 4、查
-- 基本表指定元组
select * from tb_produce where goodsID = '{$goodsID}' and supplierID='{$supplierID}' and produceID='{$produceID}';
-- 查询重复
select count(*) from tb_produce where goodsID = '{$goodsID}' and supplierID='{$supplierID}' and produceID='{$produceID}';
-- 视图指定元组
select * from produce where goodsID='{$goodsID}'
-- 元组个数
select count(*) from `tb_produce`;
-- 从第amount个元组开始显示pagesize个元组
select * from produce limit {$amount},{$pagesize};

-- 5、视图：
create view produce as select tb_produce.goodsID,goodsName,tb_produce.supplierID,supplierName,produceID,tb_produce.note 
from tb_goods,tb_supplier,tb_produce 
where tb_produce.goodsID = tb_goods.goodsID 
and tb_produce.supplierID = tb_supplier.supplierID


-- ----------------------------
-- *******采购管理sql语句*******
-- ******SQL Query test********
-- ----------------------------

-- ----------------------------
-- *********1、商品采购*********
-- ----------------------------
-- 1、增：

-- 2、删：

-- 3、改：

-- 4、查：

-- 5、视图：

select buysID,tb_buys.goodsID,goodsName ,tb_buys.supplierID ,supplierName,produceID ,buyPrice ,buyNum ,tb_buys.note  
from tb_buys,tb_goods,tb_supplier
where tb_buys.goodsID = tb_goods.goodsID and tb_buys.supplierID = tb_supplier.supplierID;

-- ----------------------------
-- *********2、采购记录*********
-- ----------------------------
-- 1、增：

-- 2、删：

-- 3、改：

-- 4、查：

-- 5、视图：

select * from tb_buy;



-- ----------------------------
-- *******库存管理sql语句*******
-- ******SQL Query test********
-- ----------------------------

-- ----------------------------
-- *********1、仓库列表*********
-- ----------------------------
-- 1、增：
INSERT INTO `tb_store` VALUES ('{$storeID}', '{$storeName}', '{$storeNum}', '{$storeMax}', 
'{$storeManager}', '{$storePhone}', '{$storeAddress}', '{$note}');

-- 2、删：
Delete from tb_store where storeID ='$storeID'
Delete from tb_store where storeID ='$id'

-- 3、改：
update tb_store set storeID= '{$storeID}',storeName='{$storeName}' ,storeNum='{$storeNum}' ,storeMax='{$storeMax}' ,
storeManager='{$storeManager}' ,storePhone='{$storePhone}',storeAddress='{$storeAddress}' ,note='{$note}' where storeID='{$storeID}';


-- 4、查：
-- 指定元组
Select count(*) from tb_store where storeID = '$storeID'
-- 元组序号
select count(*) from tb_store where storeID <= '$storeID';
-- 元组个数
select count(*) from `tb_store`;
-- 从第amount个元组开始显示pagesize个元组
select * from tb_store limit {$amount},{$pagesize};

-- 5、视图：
select * from tb_store;


-- ----------------------------
-- *********2、库存状况*********
-- ----------------------------
-- 1、增：

-- 2、删：

-- 3、改：

-- 4、查：

-- 5、视图：
select tb_stock.storeID ,storeName ,tb_stock.goodsID ,goodsName,tb_stock.supplierID ,supplierName,produceID ,
stockNum ,stockMax ,stockAlarm ,tb_stock.note  
from tb_stock,tb_store,tb_goods,tb_supplier 
where tb_stock.goodsID = tb_goods.goodsID and tb_stock.supplierID = tb_supplier.supplierID 
and tb_stock.storeID = tb_store.storeID;

-- ----------------------------
-- *********3、商品出库*********
-- ----------------------------
-- 1、增：

-- 2、删：

-- 3、改：

-- 4、查：

-- 5、视图：
select * from tb_outstock;


-- ----------------------------
-- *********4、商品入库*********
-- ----------------------------
-- 1、增：

-- 2、删：

-- 3、改：

-- 4、查：

-- 5、视图：

-- ----------------------------
-- *********5、库存盘点*********
-- ----------------------------
-- 1、增：

-- 2、删：

-- 3、改：

-- 4、查：

-- 5、视图：



-- ----------------------------
-- ******管理员管理sql语句******
-- ******SQL Query test********
-- ----------------------------

-- ----------------------------
-- *********1、员工管理*********
-- ----------------------------
-- 1、增：
INSERT INTO `tb_user` VALUES ('{$userID}', '{$userPassword}', '{$userName}', '{$userSex}', 
'{$userAge}', '{$userType}', '{$userJob}','{$userPhone}', '{$note}');

-- 2、删：
-- 单项删除
delete from tb_user where userID='{$userID}';
-- 批量删除
Delete from tb_user where userID ='$id';

-- 3、改：
-- 修改元组
update tb_user set userID='{$userID}' ,userPassword='{$userPassword}' ,userName='{$userName}' ,userSex='{$userSex}' ,
userAge='{$userAge}' ,userType='{$userType}' ,userJob='{$userJob}' ,userPhone='{$userPhone}' ,note='{$note}' where userID='{$userID}';
-- 修改密码
Update tb_user set userPassword ='{$new}' where userID ='{$uid}'

-- 4、查：
-- 指定元组
select * from tb_user where userID='{$userID}';
-- 元组个数
Select count(*) from tb_user where userID = '$userID'
-- 密码查询
Select userPassword from tb_user where userID ='$uid'
-- 密码核对
SELECT * FROM tb_user WHERE  userID='$uid' and userPassword='$pw'

-- 5、视图：
select * from tb_user;




-- ----------------------------
-- *********2、会员管理*********
-- ----------------------------
-- 1、增：
INSERT INTO `tb_member` VALUES ('{$memberID}', '{$memberName}', '{$memberPhone}', '{$totalSum}', '{$createDate}',  '{$note}');

-- 2、删：
-- 单项删除
delete from tb_member where memberID='{$memberID}';
-- 批量删除
Delete from tb_member where memberID ='$id'

-- 3、改：
update tb_member set memberID='{$memberID}' ,memberName='{$memberName}' ,memberPhone='{$memberPhone}' ,
totalSum='{$totalSum}' ,createDate='{$createDate}' ,note='{$note}'where memberID='{$memberID}';

-- 4、查：
-- 重复查询
Select count(*) from tb_member where memberID= '$memberID'
-- 元组序号
select count(*) from tb_member where memberID <= '$memberID';
-- 指定元组
select * from tb_member where memberID='{memberID}';

-- 5、视图：
select * from tb_member;







--排版模板
-- ----------------------------
-- *******账单管理sql语句*******
-- ******SQL Query test********
-- ----------------------------

-- ----------------------------
-- *********1、销售订单*********
-- ----------------------------
-- 1、增：

-- 2、删：

-- 3、改：

-- 4、查：

-- 5、视图：
