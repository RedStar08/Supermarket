---------------------------------------------------------------------------
********************************** 注意事项 ******************************
-- ！！！尽量少使用触发器，不建议使用。

-- 　　假设触发器触发每次执行1s，insert table 500条数据，那么就需要触发500次触发器。
-- 	光是触发器执行的时间就花费了500s，而insert 500条数据一共是1s，那么这个insert的效率就非常低了。
-- 	因此我们特别需要注意的一点是触发器的begin end;之间的语句的执行效率一定要高，资源消耗要小。

-- 　　触发器尽量少的使用，因为不管如何，它还是很消耗资源。
-- 	如果使用的话要谨慎的使用，确定它是非常高效的：触发器是针对每一行的；
-- 	对增删改非常频繁的表上切记不要使用触发器，因为它会非常消耗资源。 

--	触发器只能创建在永久表（Permanent Table）上，不能对临时表（Temporary Table）创建触发器。

--CREATE TRIGGER tri_userAge  
--       { BEFORE} 
--            <触发事件> ON <表名>
--       FOR EACH  {ROW | STATEMENT}
--	<触发动作体>；
--特殊对象：New,   Old
-- *********************************************************************
-------------------------------------------------------------------------

-- insert触发器（若不符合要求则无法插入/无详细提示）：

-- ------------------------------------
-- **************用户表限制*************
-- Table insert constraint for tb_users
-- ------------------------------------
-- 用户表年龄限制
DELIMITER $$
DROP TRIGGER IF EXISTS `insert_userAge`$$
CREATE TRIGGER `insert_userAge` BEFORE INSERT ON `tb_user`
 	FOR EACH ROW begin 
		if ( new.userAge < 18) or ( new.userAge > 65) then
			DELETE FROM tb_user WHERE userID=new.userID;
		end if;
	end
$$

-- 用户表性别限制
DELIMITER $$
DROP TRIGGER IF EXISTS `insert_userSex`$$
CREATE TRIGGER `insert_userSex` BEFORE INSERT ON `tb_user`
	FOR EACH ROW begin 
		if  (new.userSex <> '男') and  (new.userSex <> '女') then
			delete from tb_user where userID=new.userID;
		end if;
	end
$$



-- -------------------------------------
-- **************会员表限制**************
-- Table insert constraint for tb_member
-- -------------------------------------
-- 累计金额限制
DELIMITER $$
DROP TRIGGER IF EXISTS `insert_totalSum`$$
CREATE TRIGGER `insert_totalSum` BEFORE INSERT ON `tb_member`
 	FOR EACH ROW begin 
		if ( new.totalSum < 0) then
			DELETE FROM tb_member WHERE memberID=new.memberID;
		end if;
	end
$$



-- ------------------------------------
-- **************仓库表限制*************
-- Table insert constraint for tb_store
-- ------------------------------------
-- 已用容量-最大容量限制
DELIMITER $$
DROP TRIGGER IF EXISTS `insert_store`$$
CREATE TRIGGER `insert_store` BEFORE INSERT ON `tb_store`
	FOR EACH ROW begin 
		if  (new.storeNum < 0) or (new.storeMax < 0) or (new.storeMax < new.storeNum) then
			delete from tb_store where storeID=new.storeID ;
		end if;
	end
$$



-- ------------------------------------
-- **************商品表限制*************
-- Table insert constraint for tb_goods
-- ------------------------------------
-- 商品价格限制
DELIMITER $$
DROP TRIGGER IF EXISTS `insert_goodsPrice`$$
CREATE TRIGGER `insert_goodsPrice` BEFORE INSERT ON `tb_goods`
	FOR EACH ROW begin 
		if  (new.goodsPrice <= 0) then
			delete from tb_goods where goodsID=new.goodsID;
		end if;
	end
$$

-- 商品保质期限制
DELIMITER $$
DROP TRIGGER IF EXISTS `insert_goodsSave`$$
CREATE TRIGGER `insert_goodsSave` BEFORE INSERT ON `tb_goods`
	FOR EACH ROW begin 
		if  (new.goodsSave <= 0) then
			delete from tb_goods where goodsID=new.goodsID;
		end if;
	end
$$



-- ---------------------------------------
-- ***************促销表限制***************
-- Table insert constraint for tb_discount
-- ---------------------------------------
-- 折扣起止日期限制
DELIMITER $$
DROP TRIGGER IF EXISTS `insert_disStartEnd`$$
CREATE TRIGGER `insert_disStartEnd` BEFORE INSERT ON `tb_discount`
	FOR EACH ROW begin 
		if  unix_timestamp(new.disStart) > unix_timestamp(new.disEnd) then
			delete from tb_discount where goodsID=new.goodsID and produceID=new.produceID;
		end if;
	end
$$

-- 促销价格限制
DELIMITER $$
DROP TRIGGER IF EXISTS `insert_disPrice`$$
CREATE TRIGGER `insert_disPrice` BEFORE INSERT ON `tb_discount`
	FOR EACH ROW begin 
		if  (new.disPrice <= 0) then
			delete from tb_discount where goodsID=new.goodsID and produceID=new.produceID;
		end if;
	end
$$



-- ------------------------------------
-- **************采购表限制*************
-- Table insert constraint for tb_buys
-- ------------------------------------
-- 采购单价限制
DELIMITER $$
DROP TRIGGER IF EXISTS `insert_buyPrice`$$
CREATE TRIGGER `insert_buyPrice` BEFORE INSERT ON `tb_buys`
	FOR EACH ROW begin 
		if  (new.buyPrice <= 0) then
			delete from tb_buys where buysID=new.buysID and goodsID=new.goodsID 
				and supplierID=new.supplierID and produceID=new.produceID;
		end if;
	end
$$
-- 测试数据
-- INSERT INTO `tb_buys` VALUES ('201911120001', '000001', '300001', '20191111', '-1.00',  '200', '光棍节采购');

-- 采购数量限制
DELIMITER $$
DROP TRIGGER IF EXISTS `insert_buyNum`$$
CREATE TRIGGER `insert_buyNum` BEFORE INSERT ON `tb_buys`
	FOR EACH ROW begin 
		if  (new.buyNum <= 0) then
			delete from tb_buys where buysID=new.buysID and goodsID=new.goodsID 
				and supplierID=new.supplierID and produceID=new.produceID;
		end if;
	end
$$
-- 测试数据
-- INSERT INTO `tb_buys` VALUES ('201911120001', '000001', '300001', '20191111', '1.00',  '-200', '光棍节采购');



-- ----------------------------------------
-- ******************入库表****************
-- Table insert constraint for tb_instocks
-- ----------------------------------------
-- 入库数量限制
DELIMITER $$
DROP TRIGGER IF EXISTS `insert_instockNum`$$
CREATE TRIGGER `insert_instockNum` BEFORE INSERT ON `tb_instocks`
	FOR EACH ROW begin 
		if  (new.instockNum <= 0) then
			delete from tb_instocks where instockID=new.instockID and storeID=new.storeID
				and goodsID=new.goodsID and supplierID=new.supplierID and produceID=new.produceID;
		end if;
	end
$$
-- 测试数据
-- INSERT INTO `tb_instocks` VALUES ('201911110004', '400001', '000001', '300001', '20191111', '-200', '光棍节入库');



-- ----------------------------------------
-- ********************出库表***************
-- Table insert constraint for tb_outstocks
-- ----------------------------------------
-- 出库数量限制
DELIMITER $$
DROP TRIGGER IF EXISTS `insert_outstockNum`$$
CREATE TRIGGER `insert_outstockNum` BEFORE INSERT ON `tb_outstocks`
	FOR EACH ROW begin 
		if  (new.outstockNum <= 0) then
			delete from tb_outstocks where outstockID=new.outstockID and storeID=new.storeID
				and goodsID=new.goodsID and supplierID=new.supplierID and produceID=new.produceID;
		end if;
	end
$$
-- 测试数据
-- INSERT INTO `tb_outstocks` VALUES ('201911120004', '400001', '000001', '300001', '20191111', '-100', '11月出库');



-- -------------------------------------
-- ***************盘点表*****************
-- Table insert constraint for tb_checks
-- -------------------------------------
-- 盘点数量限制
DELIMITER $$
DROP TRIGGER IF EXISTS `insert_checkNum`$$
CREATE TRIGGER `insert_checkNum` BEFORE INSERT ON `tb_checks`
	FOR EACH ROW begin 
		if  (new.checkNum <= 0) then
			delete from tb_checks where checkID=new.checkID and storeID=new.storeID
				and goodsID=new.goodsID and supplierID=new.supplierID and produceID=new.produceID;
		end if;
	end
$$
-- 测试数据
-- INSERT INTO `tb_checks` VALUES ('202001150002', '400001', '000001', '300001', '20191111', '-200', '数量准确');



-- ------------------------------------
-- ***************库存表限制************
-- Table insert constraint for tb_stock
-- ------------------------------------
-- 库存数量-最大容量限制
DELIMITER $$
DROP TRIGGER IF EXISTS `insert_stock`$$
CREATE TRIGGER `insert_stock` BEFORE INSERT ON `tb_stock`
	FOR EACH ROW begin 
		if  (new.stockNum < 0) or (new.stockMax < 0) or (new.stockMax < new.stockNum) then
			delete from tb_stock where storeID=new.storeID and goodsID=new.goodsID 
				and supplierID=new.supplierID and produceID=new.produceID;
		end if;
	end
$$






-- update触发器（若不符合要求则无法更新/无详细提示）：

-- ------------------------------------
-- ***************用户表限制***********
-- Table update constraint for tb_users
-- ------------------------------------
-- 用户表年龄限制
DELIMITER $$
DROP TRIGGER IF EXISTS `update_userAge`$$
CREATE TRIGGER `update_userAge` BEFORE update ON `tb_user`
 	FOR EACH ROW begin 
		if ( new.userAge < 18) or ( new.userAge > 65) then
			DELETE FROM tb_user WHERE userID=new.userID;
		end if;
	end
$$
-- 测试数据
-- update tb_user set userAge = '80' where userID='100000';

-- 用户表性别限制
DELIMITER $$
DROP TRIGGER IF EXISTS `update_userSex`$$
CREATE TRIGGER `update_userSex` BEFORE update ON `tb_user`
	FOR EACH ROW begin 
		if  (new.userSex <> '男') and  (new.userSex <> '女') then
			DELETE FROM tb_user WHERE userID=new.userID;
		end if;
	end
$$
-- 测试数据
-- update tb_user set userSex = '人' where userID='100000';



-- -------------------------------------
-- ***************会员表限制*************
-- Table update constraint for tb_member
-- -------------------------------------
-- 累计金额限制
DELIMITER $$
DROP TRIGGER IF EXISTS `update_totalSum`$$
CREATE TRIGGER `update_totalSum` BEFORE update ON `tb_member`
 	FOR EACH ROW begin 
		if ( new.totalSum < 0) then
			DELETE FROM tb_member WHERE memberID=new.memberID;
		end if;
	end
$$
-- 测试数据



-- ------------------------------------
-- ***************仓库表限制************
-- Table update constraint for tb_store
-- ------------------------------------
-- 已用容量-最大容量限制
DELIMITER $$
DROP TRIGGER IF EXISTS `update_store`$$
CREATE TRIGGER `update_store` BEFORE update ON `tb_store`
	FOR EACH ROW begin 
		if  (new.storeNum < 0) or (new.storeMax < 0) or (new.storeMax < new.storeNum) then
			delete from tb_store where storeID=new.storeID ;
		end if;
	end
$$
-- 测试数据
-- update tb_store set storeNum = '-1' where storeID='400001';
-- update tb_store set storeMax = '-1' where storeID='400001';
-- update tb_store set storeNum = '10',storeMax = '1' where storeID='400001';



-- ------------------------------------
-- ***************商品表限制************
-- Table update constraint for tb_goods
-- ------------------------------------
--商品价格限制
DELIMITER $$
DROP TRIGGER IF EXISTS `update_goodsPrice`$$
CREATE TRIGGER `update_goodsPrice` BEFORE update ON `tb_goods`
	FOR EACH ROW begin 
		if  (new.goodsPrice <= 0) then
			delete from tb_goods where goodsID=new.goodsID;
		end if;
	end
$$

-- 商品保质期限制
DELIMITER $$
DROP TRIGGER IF EXISTS `update_goodsSave`$$
CREATE TRIGGER `update_goodsSave` BEFORE update ON `tb_goods`
	FOR EACH ROW begin 
		if  (new.goodsSave <= 0) then
			delete from tb_goods where goodsID=new.goodsID;
		end if;
	end
$$
-- 测试数据
-- update tb_goods set goodsPrice = '-1' where goodsID='000001';
-- update tb_goods set goodsSave='-1' where goodsID='000001';

-- 商品保质期限制


-- ---------------------------------------
-- ***************促销表限制**************
-- Table update constraint for tb_discount
-- ---------------------------------------
-- 折扣起止日期限制
DELIMITER $$
DROP TRIGGER IF EXISTS `update_disStartEnd`$$
CREATE TRIGGER `update_disStartEnd` BEFORE update ON `tb_discount`
	FOR EACH ROW begin 
		if  unix_timestamp(new.disStart) > unix_timestamp(new.disEnd) then
			delete from tb_discount where goodsID=new.goodsID and produceID=new.produceID;
		end if;
	end
$$
-- 测试数据
-- update tb_discount set disStart = '2019-12-25' where goodsID='000001' and produceID='20191111';

-- 促销价格限制
DELIMITER $$
DROP TRIGGER IF EXISTS `update_disPrice`$$
CREATE TRIGGER `update_disPrice` BEFORE update ON `tb_discount`
	FOR EACH ROW begin 
		if  (new.disPrice <= 0) then
			delete from tb_discount where goodsID=new.goodsID and produceID=new.produceID;
		end if;
	end
$$
-- 测试数据
-- update tb_discount set disPrice = '-1' where goodsID='000001' and produceID='20191111';



-- ------------------------------------
-- **************采购表限制************
-- Table update constraint for tb_buys
-- ------------------------------------
-- 采购单价限制
DELIMITER $$
DROP TRIGGER IF EXISTS `update_buyPrice`$$
CREATE TRIGGER `update_buyPrice` BEFORE update ON `tb_buys`
	FOR EACH ROW begin 
		if  (new.buyPrice <= 0) then
			delete from tb_buys where buysID=new.buysID and goodsID=new.goodsID 
				and supplierID=new.supplierID and produceID=new.produceID;
		end if;
	end
$$
-- 测试数据
-- update tb_buys set buyPrice = '-1' where buysID='201911110001' and goodsID='000001' and supplierID='300001' and produceID='20191111';

-- 采购数量限制
DELIMITER $$
DROP TRIGGER IF EXISTS `update_buyNum`$$
CREATE TRIGGER `update_buyNum` BEFORE update ON `tb_buys`
	FOR EACH ROW begin 
		if  (new.buyNum <= 0) then
			delete from tb_buys where buysID=new.buysID and goodsID=new.goodsID 
				and supplierID=new.supplierID and produceID=new.produceID;
		end if;
	end
$$
-- 测试数据
-- update tb_buys set buyNum = '-1' where buysID='201911110001' and goodsID='000001' and supplierID='300001' and produceID='20191111';



-- ---------------------------------------
-- *****************入库表*****************
-- Table update constraint for tb_instocks
-- ---------------------------------------
-- 入库数量限制
DELIMITER $$
DROP TRIGGER IF EXISTS `update_instockNum`$$
CREATE TRIGGER `update_instockNum` BEFORE update ON `tb_instocks`
	FOR EACH ROW begin 
		if  (new.instockNum <= 0) then
			delete from tb_instocks where instockID=new.instockID and storeID=new.storeID
				and goodsID=new.goodsID and supplierID=new.supplierID and produceID=new.produceID;
		end if;
	end
$$
-- 测试数据
-- update tb_instocks set instockNum = '-1' where instockID='201911110001' and storeID='400001'and goodsID='000001' and supplierID='300001' and produceID='20191111';



-- -----------------------------------------
-- *****************出库表******************
-- Table update constraint for tb_outstocks
-- -----------------------------------------
-- 出库数量限制
DELIMITER $$
DROP TRIGGER IF EXISTS `update_outstockNum`$$
CREATE TRIGGER `update_outstockNum` BEFORE update ON `tb_outstocks`
	FOR EACH ROW begin 
		if  (new.outstockNum <= 0) then
			delete from tb_outstocks where outstockID=new.outstockID and storeID=new.storeID
				and goodsID=new.goodsID and supplierID=new.supplierID and produceID=new.produceID;
		end if;
	end
$$
-- 测试数据
-- INSERT INTO `tb_outstocks` VALUES ('201911120004', '400001', '000001', '300001', '20191111', '-100', '11月出库');
-- update tb_outstocks set outstockNum = '-1' where outstockID='201911120001' and storeID='400001'and goodsID='000001' and supplierID='300001' and produceID='20191111';



-- -------------------------------------
-- ***************盘点表*****************
-- Table update constraint for tb_checks
-- -------------------------------------
-- 盘点数量限制
DELIMITER $$
DROP TRIGGER IF EXISTS `update_checkNum`$$
CREATE TRIGGER `update_checkNum` BEFORE update ON `tb_checks`
	FOR EACH ROW begin 
		if  (new.checkNum <= 0) then
			delete from tb_checks where checkID=new.checkID and storeID=new.storeID
				and goodsID=new.goodsID and supplierID=new.supplierID and produceID=new.produceID;
		end if;
	end
$$
-- 测试数据
-- INSERT INTO `tb_checks` VALUES ('202001150002', '400001', '000001', '300001', '20191111', '-200', '数量准确');
-- update tb_checks set checkNum = '-1' where checkID='202001150001' and storeID='400001'and goodsID='000001' and supplierID='300001' and produceID='20191111';



-- ------------------------------------
-- ***************库存表限制************
-- Table update constraint for tb_stock
-- ------------------------------------
-- 库存数量-最大容量限制
DELIMITER $$
DROP TRIGGER IF EXISTS `update_stock`$$
CREATE TRIGGER `update_stock` BEFORE update ON `tb_stock`
	FOR EACH ROW begin 
		if  (new.stockNum < 0) or (new.stockMax < 0) or (new.stockMax < new.stockNum) then
			delete from tb_stock where storeID=new.storeID and goodsID=new.goodsID 
				and supplierID=new.supplierID and produceID=new.produceID;
		end if;
	end
$$
-- 测试数据
-- update tb_stock set stockNum = '-1' where storeID='400001' and goodsID='000001' and supplierID='300001' and produceID='20191111';
-- update tb_stock set stockMax = '-1' where storeID='400001' and goodsID='000001' and supplierID='300001' and produceID='20191111';
-- update tb_stock set stockNum = '10',stockMax = '1' where storeID='400001' and goodsID='000001' and supplierID='300001' and produceID='20191111';



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
		update tb_stock set stockNum = stockNum + new.instockNum where tb_stock.storeID=new.storeID and tb_stock.goodsID=new.goodsID 
			and tb_stock.supplierID=new.supplierID and tb_stock.produceID=new.produceID;
		update tb_store set storeNum = storeNum + new.instockNum where tb_store.storeID=new.storeID;
	end
$$
-- 测试数据
-- INSERT INTO `tb_instocks` VALUES ('201911110004', '400001', '000001', '300001', '20191111', '200', '光棍节入库');



-- ---------------------------------------------------------------
-- ************************出库-库存限制/仓库**********************
-- Table update constraint for tb_outstocks and tb_stock/ tb_store
-- ---------------------------------------------------------------
-- 插入出库-更新库存/仓库
DELIMITER $$
DROP TRIGGER IF EXISTS `insert_outstock_stock_store`$$
CREATE TRIGGER `insert_outstock_stock_store` after INSERT ON `tb_outstocks`
	FOR EACH ROW begin 
		update tb_stock set stockNum = stockNum - new.outstockNum where tb_stock.storeID=new.storeID and tb_stock.goodsID=new.goodsID 
			and tb_stock.supplierID=new.supplierID and tb_stock.produceID=new.produceID;
		update tb_store set storeNum = storeNum - new.outstockNum where tb_store.storeID=new.storeID;
	end
$$
-- 测试数据
-- INSERT INTO `tb_outstocks` VALUES ('201911110004', '400001', '000001', '300001', '20191111', '200', '光棍节出库');





-- ---------------------------------------------------------------
-- *****************非空属性限制(update and insert)****************
-- *****************Table not_null constraint*********************
-- ---------------------------------------------------------------
-- 商品表
DELIMITER $$
DROP TRIGGER IF EXISTS `not_null_update_goods`$$
CREATE TRIGGER `not_null_update_goods` BEFORE update ON `tb_goods`
	FOR EACH ROW begin 
		if  (new.goodsID  = '') or (new.goodsName = '') or (new.goodsPrice = '') 
		or (new.goodsType = '') or (new.goodsSpecs  = '') or (new.goodsSave  = '') then
			delete from tb_goods where goodsID=new.goodsID;
		end if;
	end
$$
-- 测试数据
-- update tb_goods set goodsID = '' where goodsID='000001';
-- update tb_goods set goodsName = '' where goodsID='000001';
-- update tb_goods set goodsPrice = '' where goodsID='000001';
-- update tb_goods set goodsType = '' where goodsID='000001';
-- update tb_goods set goodsSpecs = '' where goodsID='000001';
-- update tb_goods set goodsSave = '' where goodsID='000001';

DELIMITER $$
DROP TRIGGER IF EXISTS `not_null_insert_goods`$$
CREATE TRIGGER `not_null_insert_goods` BEFORE  insert ON `tb_goods`
	FOR EACH ROW begin 
		if  (new.goodsID  = '') or (new.goodsName = '') or (new.goodsPrice = '') 
		or (new.goodsType = '') or (new.goodsSpecs  = '') or (new.goodsSave  = '') then
			delete from tb_goods where goodsID=new.goodsID;
		end if;
	end
$$
-- 测试数据
-- INSERT INTO `tb_goods` VALUES ('000050', '',    '3.00',  '饮品',     '瓶', '180', '夏季增加采购');



-- 供应商表
DELIMITER $$
DROP TRIGGER IF EXISTS `not_null_update_supplier`$$
CREATE TRIGGER `not_null_update_supplier` BEFORE update ON `tb_supplier`
	FOR EACH ROW begin 
		if  (new.supplierID  = '') or (new.supplierName = '') or (new.supplierManager = '') 
		or (new.supplierPhone = '') or (new.supplierAddress  = '')  then
			delete from tb_supplier where supplierID=new.supplierID;
		end if;
	end
$$
-- 测试数据
-- update tb_supplier set supplierID = '' where supplierID='300001';
-- update tb_supplier set supplierName = '' where supplierID='300001';
-- update tb_supplier set supplierManager = '' where supplierID='300001';
-- update tb_supplier set supplierPhone = '' where supplierID='300001';
-- update tb_supplier set supplierAddress = '' where supplierID='300001';

DELIMITER $$
DROP TRIGGER IF EXISTS `not_null_insert_supplier`$$
CREATE TRIGGER `not_null_insert_supplier` BEFORE insert ON `tb_supplier`
	FOR EACH ROW begin 
		if  (new.supplierID  = '') or (new.supplierName = '') or (new.supplierManager = '') 
		or (new.supplierPhone = '') or (new.supplierAddress  = '')  then
			delete from tb_supplier where supplierID=new.supplierID;
		end if;
	end
$$
-- 测试数据



-- 生产表
DELIMITER $$
DROP TRIGGER IF EXISTS `not_null_update_produce`$$
CREATE TRIGGER `not_null_update_produce` BEFORE update ON `tb_produce`
	FOR EACH ROW begin 
		if  (new.goodsID  = '') or (new.supplierID = '') or (new.produceID = '') then
			delete from tb_produce where produceID=new.produceID and goodsID=new.goodsID and supplierID=new.supplierID;
		end if;
	end
$$
-- 测试数据
-- update tb_produce set goodsID = '' where supplierID='300001';
-- update tb_produce set produceID = '' where supplierID='300001';
-- update tb_produce set supplierID = '' where supplierID='300001';

DELIMITER $$
DROP TRIGGER IF EXISTS `not_null_insert_produce`$$
CREATE TRIGGER `not_null_insert_produce` BEFORE insert ON `tb_produce`
	FOR EACH ROW begin 
		if  (new.goodsID  = '') or (new.supplierID = '') or (new.produceID = '') then
			delete from tb_produce where produceID=new.produceID and goodsID=new.goodsID and supplierID=new.supplierID;
		end if;
	end
$$
-- 测试数据
-- INSERT INTO `tb_produce` VALUES ('000018', '300006', '20191212', '双12促销');



-- 商品信息表
DELIMITER $$
DROP TRIGGER IF EXISTS `not_null_update_goodinfo`$$
CREATE TRIGGER `not_null_update_goodinfo` BEFORE update ON `tb_goodinfo`
	FOR EACH ROW begin 
		if  (new.goodsID  = '') or (new.supplierID = '') or (new.produceID = '')
		or (new.produceDate = '') or (new.produceArea  = '') then
			delete from tb_goods where produceID=new.produceID and goodsID=new.goodsID and supplierID=new.supplierID;
		end if;
	end
$$
-- 测试数据
-- update tb_goodinfo set goodsID = '' where supplierID='300001';
-- update tb_goodinfo set produceID = '' where supplierID='300001';
-- update tb_goodinfo set supplierID = '' where supplierID='300001';
-- update tb_goodinfo set produceDate = '' where supplierID='300001';
-- update tb_goodinfo set produceArea = '' where supplierID='300001';

DELIMITER $$
DROP TRIGGER IF EXISTS `not_null_insert_goodinfo`$$
CREATE TRIGGER `not_null_insert_goodinfo` BEFORE insert ON `tb_goodinfo`
	FOR EACH ROW begin 
		if  (new.goodsID  = '') or (new.supplierID = '') or (new.produceID = '')
		or (new.produceDate = '') or (new.produceArea  = '') then
			delete from tb_goods where produceID=new.produceID and goodsID=new.goodsID and supplierID=new.supplierID;
		end if;
	end
$$
-- 测试数据



-- 促销表
DELIMITER $$
DROP TRIGGER IF EXISTS `not_null_update_discount`$$
CREATE TRIGGER `not_null_update_discount` BEFORE update ON `tb_discount`
	FOR EACH ROW begin 
		if  (new.goodsID  = '') or (new.produceID = '') or (new.disPrice = '')
		or (new.disStart = '') or (new.disEnd  = '') then
			delete from tb_goods where produceID=new.produceID and goodsID=new.goodsID;
		end if;
	end
$$
-- 测试数据
-- update tb_discount set goodsID = '' where supplierID='300001';
-- update tb_discount set produceID = '' where supplierID='300001';
-- update tb_discount set supplierID = '' where supplierID='300001';
-- update tb_discount set produceDate = '' where supplierID='300001';
-- update tb_discount set produceArea = '' where supplierID='300001';

DELIMITER $$
DROP TRIGGER IF EXISTS `not_null_insert_discount`$$
CREATE TRIGGER `not_null_insert_discount` BEFORE insert ON `tb_discount`
	FOR EACH ROW begin 
		if  (new.goodsID  = '') or (new.produceID = '') or (new.disPrice = '')
		or (new.disStart = '') or (new.disEnd  = '') then
			delete from tb_goods where produceID=new.produceID and goodsID=new.goodsID;
		end if;
	end
$$
-- 测试数据



-- 采购明细表
DELIMITER $$
DROP TRIGGER IF EXISTS `not_null_update_buys`$$
CREATE TRIGGER `not_null_update_buys` BEFORE update ON `tb_buys`
	FOR EACH ROW begin 
		if  (new.goodsID  = '') or (new.supplierID = '') or (new.produceID = '')
		or (new.buysID = '') or (new.buyPrice  = '') and (new.buyNum  = '') then
			delete from tb_buys where produceID=new.produceID and goodsID=new.goodsID 
				and supplierID=new.supplierID and buysID=new.buysID;
		end if;
	end
$$
-- 测试数据
-- update tb_buys set goodsID = '' where supplierID='300001';
-- update tb_buys set produceID = '' where supplierID='300001';
-- update tb_buys set supplierID = '' where supplierID='300001';
-- update tb_buys set buysID = '' where supplierID='300001';
-- update tb_buys set buyPrice = '' where supplierID='300001';
-- update tb_buys set buyNum = '' where supplierID='300001';

DELIMITER $$
DROP TRIGGER IF EXISTS `not_null_insert_buys`$$
CREATE TRIGGER `not_null_insert_buys` BEFORE insert ON `tb_buys`
	FOR EACH ROW begin 
		if  (new.goodsID  = '') or (new.supplierID = '') or (new.produceID = '')
		or (new.buysID = '') or (new.buyPrice  = '') and (new.buyNum  = '') then
			delete from tb_buys where produceID=new.produceID and goodsID=new.goodsID 
				and supplierID=new.supplierID and buysID=new.buysID;
		end if;
	end
$$
-- 测试数据
-- INSERT INTO `tb_buys` VALUES ('201911110001', '000024', '300001', '20191111', '',  '200', '光棍节采购');



-- 采购记录表
DELIMITER $$
DROP TRIGGER IF EXISTS `not_null_update_buy`$$
CREATE TRIGGER `not_null_update_buy` BEFORE update ON `tb_buy`
	FOR EACH ROW begin 
		if  (new.buysID  = '') or (new.buyDate = '') then
			delete from tb_buy where buysID=new.buysID;
		end if;
	end
$$
-- 测试数据
-- update tb_buy set buysID = '' where buyID='201911110001';
-- update tb_buy set buyDate = '' where buyID='201911110001';

DELIMITER $$
DROP TRIGGER IF EXISTS `not_null_insert_buy`$$
CREATE TRIGGER `not_null_insert_buy` BEFORE insert ON `tb_buy`
	FOR EACH ROW begin 
		if  (new.buysID  = '') or (new.buyDate = '') then
			delete from tb_buy where buysID=new.buysID;
		end if;
	end
$$
-- 测试数据



-- 仓库表
DELIMITER $$
DROP TRIGGER IF EXISTS `not_null_update_store`$$
CREATE TRIGGER `not_null_update_store` BEFORE update ON `tb_store`
	FOR EACH ROW begin 
		if  (new.storeID  = '') or (new.storeName = '') or (new.storeNum = '') or (new.storePhone = '')
		or (new.storeMax = '') or (new.storeManager = '') or (new.storeAddress = '')then
			delete from tb_store where storeID=new.storeID;
		end if;
	end
$$
-- 测试数据
-- update tb_store set storeID = '' where storeID='400001';
-- update tb_store set storeName= '' where storeID='400001';
-- update tb_store set storeNum = '' where storeID='400001';
-- update tb_store set storePhone = '' where storeID='400001';
-- update tb_store set storeMax = '' where storeID='400001';
-- update tb_store set storeManager = '' where storeID='400001';
-- update tb_store set storeAddress = '' where storeID='400001';

DELIMITER $$
DROP TRIGGER IF EXISTS `not_null_insert_store`$$
CREATE TRIGGER `not_null_insert_store` BEFORE insert ON `tb_store`
	FOR EACH ROW begin 
		if  (new.storeID  = '') or (new.storeName = '') or (new.storeNum = '') or (new.storePhone = '')
		or (new.storeMax = '') or (new.storeManager = '') or (new.storeAddress = '')then
			delete from tb_store where storeID=new.storeID;
		end if;
	end
$$
-- 测试数据



-- 入库明细表
DELIMITER $$
DROP TRIGGER IF EXISTS `not_null_update_instocks`$$
CREATE TRIGGER `not_null_update_instocks` BEFORE update ON `tb_instocks`
	FOR EACH ROW begin 
		if  (new.goodsID  = '') or (new.supplierID = '') or (new.produceID = '')
		or (new.instockID = '') or (new.storeID  = '') and (new.instockNum  = '') then
			delete from tb_instocks where produceID=new.produceID and goodsID=new.goodsID 
				and supplierID=new.supplierID and storeID=new.storeID and instockID=new.instockID;
		end if;
	end
$$
-- 测试数据
-- update tb_instocks set goodsID = '' where supplierID='300001';
-- update tb_instocks set produceID = '' where supplierID='300001';
-- update tb_instocks set supplierID = '' where supplierID='300001';
-- update tb_instocks set instockID = '' where supplierID='300001';
-- update tb_instocks set storeID = '' where supplierID='300001';
-- update tb_instocks set instockNum = '' where supplierID='300001';

DELIMITER $$
DROP TRIGGER IF EXISTS `not_null_insert_instocks`$$
CREATE TRIGGER `not_null_insert_instocks` BEFORE insert ON `tb_instocks`
	FOR EACH ROW begin 
		if  (new.goodsID  = '') or (new.supplierID = '') or (new.produceID = '')
		or (new.instockID = '') or (new.storeID  = '') and (new.instockNum  = '') then
			delete from tb_instocks where produceID=new.produceID and goodsID=new.goodsID 
				and supplierID=new.supplierID and storeID=new.storeID and instockID=new.instockID;
		end if;
	end
$$



-- 入库记录表
DELIMITER $$
DROP TRIGGER IF EXISTS `not_null_update_instock`$$
CREATE TRIGGER `not_null_update_instock` BEFORE update ON `tb_instock`
	FOR EACH ROW begin 
		if  (new.instockID  = '') or (new.inDate = '') then
			delete from tb_instock where instockID=new.instockID;
		end if;
	end
$$
-- 测试数据
-- update tb_instock set instockID = '' where instockID='201911110001';
-- update tb_instock set inDate = '' where instockID='201911110001';

DELIMITER $$
DROP TRIGGER IF EXISTS `not_null_insert_instock`$$
CREATE TRIGGER `not_null_insert_instock` BEFORE insert ON `tb_instock`
	FOR EACH ROW begin 
		if  (new.instockID  = '') or (new.inDate = '') then
			delete from tb_instock where instockID=new.instockID;
		end if;
	end
$$
-- 测试数据



-- 出库明细表
DELIMITER $$
DROP TRIGGER IF EXISTS `not_null_update_outstocks`$$
CREATE TRIGGER `not_null_update_outstocks` BEFORE update ON `tb_outstocks`
	FOR EACH ROW begin 
		if  (new.goodsID  = '') or (new.supplierID = '') or (new.produceID = '')
		or (new.outstockID = '') or (new.storeID  = '') and (new.outstockNum  = '') then
			delete from tb_outstocks where produceID=new.produceID and goodsID=new.goodsID 
				and supplierID=new.supplierID and storeID=new.storeID and outstockID=new.outstockID;
		end if;
	end
$$
-- 测试数据
-- update tb_outstocks set goodsID = '' where supplierID='300001';
-- update tb_outstocks set produceID = '' where supplierID='300001';
-- update tb_outstocks set supplierID = '' where supplierID='300001';
-- update tb_outstocks set outstockID = '' where supplierID='300001';
-- update tb_outstocks set storeID = '' where supplierID='300001';
-- update tb_outstocks set outstockNum = '' where supplierID='300001';

DELIMITER $$
DROP TRIGGER IF EXISTS `not_null_insert_outstocks`$$
CREATE TRIGGER `not_null_insert_outstocks` BEFORE insert ON `tb_outstocks`
	FOR EACH ROW begin 
		if  (new.goodsID  = '') or (new.supplierID = '') or (new.produceID = '')
		or (new.outstockID = '') or (new.storeID  = '') and (new.outstockNum  = '') then
			delete from tb_outstocks where produceID=new.produceID and goodsID=new.goodsID 
				and supplierID=new.supplierID and storeID=new.storeID and outstockID=new.outstockID;
		end if;
	end
$$
-- 测试数据



-- 出库记录表
DELIMITER $$
DROP TRIGGER IF EXISTS `not_null_update_outstock`$$
CREATE TRIGGER `not_null_update_outstock` BEFORE update ON `tb_outstock`
	FOR EACH ROW begin 
		if  (new.outstockID  = '') or (new.outDate = '') then
			delete from tb_outstock where outstockID=new.outstockID;
		end if;
	end
$$
-- 测试数据
-- update tb_outstock set outstockID = '' where outstockID='201911120001';
-- update tb_outstock set outDate = '' where outstockID='201911120001';

DELIMITER $$
DROP TRIGGER IF EXISTS `not_null_insert_outstock`$$
CREATE TRIGGER `not_null_insert_outstock` BEFORE insert ON `tb_outstock`
	FOR EACH ROW begin 
		if  (new.outstockID  = '') or (new.outDate = '') then
			delete from tb_outstock where outstockID=new.outstockID;
		end if;
	end
$$
-- 测试数据



-- 库存表
DELIMITER $$
DROP TRIGGER IF EXISTS `not_null_update_stock`$$
CREATE TRIGGER `not_null_update_stock` BEFORE update ON `tb_stock`
	FOR EACH ROW begin 
		if  (new.storeID  = '') or (new.goodsID  = '') or (new.supplierID = '') or (new.produceID = '')
		or (new.stockMax = '') or (new.stockNum = '') or (new.stockAlarm = '')then
			delete from tb_stock where produceID=new.produceID and goodsID=new.goodsID 
				and supplierID=new.supplierID and storeID=new.storeID;
		end if;
	end
$$
-- 测试数据
-- update tb_stock set storeID = '' where storeID='400001';
-- update tb_stock set goodsID= '' where storeID='400001';
-- update tb_stock set supplierID = '' where storeID='400001';
-- update tb_stock set produceID = '' where storeID='400001';
-- update tb_stock set stockMax = '' where storeID='400001';
-- update tb_stock set stockNum = '' where storeID='400001';
-- update tb_stock set stockAlarm = '' where storeID='400001';

DELIMITER $$
DROP TRIGGER IF EXISTS `not_null_insert_stock`$$
CREATE TRIGGER `not_null_insert_stock` BEFORE insert ON `tb_stock`
	FOR EACH ROW begin 
		if  (new.storeID  = '') or (new.goodsID  = '') or (new.supplierID = '') or (new.produceID = '')
		or (new.stockMax = '') or (new.stockNum = '') or (new.stockAlarm = '')then
			delete from tb_stock where produceID=new.produceID and goodsID=new.goodsID 
				and supplierID=new.supplierID and storeID=new.storeID;
		end if;
	end
$$
-- 测试数据



-- 盘点明细表
DELIMITER $$
DROP TRIGGER IF EXISTS `not_null_update_checks`$$
CREATE TRIGGER `not_null_update_checks` BEFORE update ON `tb_checks`
	FOR EACH ROW begin 
		if  (new.storeID  = '') or (new.goodsID  = '') or (new.supplierID = '') 
		or (new.produceID = '') or (new.checkID = '') or (new.checkNum = '') then
			delete from tb_checks where produceID=new.produceID and goodsID=new.goodsID 
				and supplierID=new.supplierID and storeID=new.storeID and checkID=new.checkID;
		end if;
	end
$$
-- 测试数据
-- update tb_checks set storeID = '' where storeID='400001';
-- update tb_checks set goodsID= '' where storeID='400001';
-- update tb_checks set supplierID = '' where storeID='400001';
-- update tb_checks set produceID = '' where storeID='400001';
-- update tb_checks set checkID = '' where storeID='400001';
-- update tb_checks set checkNum = '' where storeID='400001';

DELIMITER $$
DROP TRIGGER IF EXISTS `not_null_insert_checks`$$
CREATE TRIGGER `not_null_insert_checks` BEFORE insert ON `tb_checks`
	FOR EACH ROW begin 
		if  (new.storeID  = '') or (new.goodsID  = '') or (new.supplierID = '') 
		or (new.produceID = '') or (new.checkID = '') or (new.checkNum = '') then
			delete from tb_checks where produceID=new.produceID and goodsID=new.goodsID 
				and supplierID=new.supplierID and storeID=new.storeID and checkID=new.checkID;
		end if;
	end
$$
-- 测试数据



-- 盘点记录表
DELIMITER $$
DROP TRIGGER IF EXISTS `not_null_update_check`$$
CREATE TRIGGER `not_null_update_check` BEFORE update ON `tb_check`
	FOR EACH ROW begin 
		if  (new.checkID  = '') or (new.checkTime = '') then
			delete from tb_check where checkID=new.checkID;
		end if;
	end
$$
-- 测试数据
-- update tb_check set checkID = '' where checkID='202001150001';
-- update tb_check set checkTime = '' where checkID='202001150001';

DELIMITER $$
DROP TRIGGER IF EXISTS `not_null_insert_check`$$
CREATE TRIGGER `not_null_insert_check` BEFORE insert ON `tb_check`
	FOR EACH ROW begin 
		if  (new.checkID  = '') or (new.checkTime = '') then
			delete from tb_check where checkID=new.checkID;
		end if;
	end
$$
-- 测试数据



-- 销售明细表
DELIMITER $$
DROP TRIGGER IF EXISTS `not_null_update_sales`$$
CREATE TRIGGER `not_null_update_sales` BEFORE update ON `tb_sales`
	FOR EACH ROW begin 
		if  (new.salesID  = '') or (new.goodsID  = '') or (new.supplierID = '') 
		or (new.produceID = '') or (new.salesPrice = '') or (new.salesNum = '') then
			delete from tb_sales where produceID=new.produceID and goodsID=new.goodsID 
				and supplierID=new.supplierID and salesID=new.salesID;
		end if;
	end
$$
-- 测试数据
-- update tb_sales set salesID = '' where storeID='400001';
-- update tb_sales set goodsID= '' where storeID='400001';
-- update tb_sales set supplierID = '' where storeID='400001';
-- update tb_sales set produceID = '' where storeID='400001';
-- update tb_sales set salesDate = '' where storeID='400001';
-- update tb_sales set salesTime = '' where storeID='400001';

DELIMITER $$
DROP TRIGGER IF EXISTS `not_null_insert_sales`$$
CREATE TRIGGER `not_null_insert_sales` BEFORE insert ON `tb_sales`
	FOR EACH ROW begin 
		if  (new.salesID  = '') or (new.goodsID  = '') or (new.supplierID = '') 
		or (new.produceID = '') or (new.salesPrice = '') or (new.salesNum = '') then
			delete from tb_sales where produceID=new.produceID and goodsID=new.goodsID 
				and supplierID=new.supplierID and salesID=new.salesID;
		end if;
	end
$$
-- 测试数据



-- 销售记录表
DELIMITER $$
DROP TRIGGER IF EXISTS `not_null_update_sale`$$
CREATE TRIGGER `not_null_update_sale` BEFORE update ON `tb_sale`
	FOR EACH ROW begin 
		if  (new.salesID  = '') or (new.salesSum = '') or (new.salesMoney = '') 
		or (new.salesChange = '') or (new.salesDate = '') or (new.salesTime = '') then
			delete from tb_sale where salesID=new.salesID;
		end if;
	end
$$
-- 测试数据
-- update tb_sale set salesID = '' where salesID='201911130001';
-- update tb_sale set salesTime = '' where salesID='201911130001';

DELIMITER $$
DROP TRIGGER IF EXISTS `not_null_insert_sale`$$
CREATE TRIGGER `not_null_insert_sale` BEFORE insert ON `tb_sale`
	FOR EACH ROW begin 
		if  (new.salesID  = '') or (new.salesSum = '') or (new.salesMoney = '') 
		or (new.salesChange = '') or (new.salesDate = '') or (new.salesTime = '') then
			delete from tb_sale where salesID=new.salesID;
		end if;
	end
$$
-- 测试数据



-- 用户表
DELIMITER $$
DROP TRIGGER IF EXISTS `not_null_update_user`$$
CREATE TRIGGER `not_null_update_user` BEFORE update ON `tb_user`
	FOR EACH ROW begin 
		if  (new.userID  = '') or (new.userPassword  = '') or (new.userName = '') or (new.userSex = '') 
		or (new.userAge = '') or (new.userType = '') or (new.userJob = '') or (new.userPhone = '') then
			delete from tb_user where userID=new.userID;
		end if;
	end
$$
-- 测试数据
-- update tb_user set userID = '' where userID='100000';
-- update tb_user set userPassword= '' where userID='100000';
-- update tb_user set userName = '' where userID='100000';
-- update tb_user set userSex = '' where userID='100000';
-- update tb_user set userAge = '' where userID='100000';
-- update tb_user set salesTime = '' where userID='100000';
-- update tb_user set salesTime = '' where userID='100000';
-- update tb_user set salesTime = '' where userID='100000';

DELIMITER $$
DROP TRIGGER IF EXISTS `not_null_insert_user`$$
CREATE TRIGGER `not_null_insert_user` BEFORE insert ON `tb_user`
	FOR EACH ROW begin 
		if  (new.userID  = '') or (new.userPassword  = '') or (new.userName = '') or (new.userSex = '') 
		or (new.userAge = '') or (new.userType = '') or (new.userJob = '') or (new.userPhone = '') then
			delete from tb_user where userID=new.userID;
		end if;
	end
$$
-- 测试数据



-- 会员表
DELIMITER $$
DROP TRIGGER IF EXISTS `not_null_update_member`$$
CREATE TRIGGER `not_null_update_member` BEFORE update ON `tb_member`
	FOR EACH ROW begin 
		if  (new.memberID  = '') or (new.memberName  = '') or (new.memberPhone = '') 
		or (new.totalSum = '') or (new.createDate = '') then
			delete from tb_member where memberID=new.memberID;
		end if;
	end
$$
-- 测试数据
-- update tb_member set memberID = '' where userID='200001';
-- update tb_member set memberName = '' where userID='200001';
-- update tb_member set memberPhone = '' where userID='200001';
-- update tb_member set totalSum = '' where userID='200001';
-- update tb_member set createDate = '' where userID='200001';

DELIMITER $$
DROP TRIGGER IF EXISTS `not_null_insert_member`$$
CREATE TRIGGER `not_null_insert_member` BEFORE insert ON `tb_member`
	FOR EACH ROW begin 
		if  (new.memberID  = '') or (new.memberName  = '') or (new.memberPhone = '') 
		or (new.totalSum = '') or (new.createDate = '') then
			delete from tb_member where memberID=new.memberID;
		end if;
	end
$$
-- 测试数据