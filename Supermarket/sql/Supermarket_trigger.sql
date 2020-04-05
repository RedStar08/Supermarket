---------------------------------------------------------------------------
-- ********************************** 注意事项 ******************************
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


-- 数据流触发器（ 入库-库存/仓库 和 出库-库存/仓库 数量自动变化（插入-更新））：

-- --------------------------------------------------------------
-- ************************入库-库存限制/仓库*********************
-- Table update constraint for tb_instocks and tb_stock/ tb_store
-- --------------------------------------------------------------
-- 插入入库-更新库存/仓库
-- DELIMITER $$
-- DROP TRIGGER IF EXISTS `insert_instock_stock_store`$$
-- CREATE TRIGGER `insert_instock_stock_store` after INSERT ON `tb_instocks`
-- 	FOR EACH ROW begin 
-- 		update tb_stock set stockNum = stockNum + new.instockNum where tb_stock.storeID=new.storeID and tb_stock.goodsID=new.goodsID 
-- 			and tb_stock.supplierID=new.supplierID and tb_stock.produceID=new.produceID;
-- 		update tb_store set storeNum = storeNum + new.instockNum where tb_store.storeID=new.storeID;
-- 	end
-- $$

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
			then update tb_member set totalSum = totalSum + new.salesSum 
			where tb_member.memberID = new.memberID;
		end if;
	end
$$
-- 测试数据
-- INSERT INTO `tb_sale` VALUES ('201911130005', '6', '21.50', '25.00', '3.50', '2019-11-13', '10:08:00', '100001', '200001', '现金支付');
