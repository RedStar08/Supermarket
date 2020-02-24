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
-- *****控制台sql语句*********
-- SQL Query test
-- ----------------------------
select count(*) from `tb_goods`;
select count(*) from `tb_store`;
select count(*) from `tb_supplier`;
select count(*) from `tb_user`;
select salesDate,sum(salesSum) from `tb_sale` where salesDate =  '2019-02-05';
select salesDate,sum(salesSum) from `tb_sale`;


-- ----------------------------
-- *****商品管理sql语句*********
-- SQL Query test
-- ----------------------------
select count(*) from `tb_goods`;
select * from tb_goods;

-- 修改商品后三属性



-- 商品折扣表视图
select tb_discount.goodsID, goodsName, goodsType, goodsPrice, disPrice, tb_discount.produceID, disStart, disEnd, 
date_add(produceDate,interval goodsSave day) 过期日期,tb_discount.note
from tb_discount,tb_goods,tb_goodinfo
where tb_discount.goodsID =tb_goods.goodsID and tb_goodinfo.goodsID = tb_goods.goodsID 
and tb_goodinfo.produceID =tb_discount.produceID;

