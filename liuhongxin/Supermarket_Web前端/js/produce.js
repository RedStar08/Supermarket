//数据处理函数
$.fn.getList = function(produceData) {

    var goodsMap = [];
    var goodsData = [];

    for(var i in produceData) {
        var goods = produceData[i];
        if(!goodsMap[goods.goodsID]) { //不存在goodsID分类，新建
            goodsData.push({
                "name": (goods.goodsID + goods.goodsName),
                "supplierList": [
                    {"name":(goods.supplierID + goods.supplierName), 
                    "produceList":[goods.produceID]}
                ]
            });
            goodsMap[goods.goodsID] = (goods.goodsID + goods.goodsName);
        }
        else { //存在goodsID分类，追加内容
            for(var j in goodsData) {
                var data = goodsData[j];
                if((goods.goodsID + goods.goodsName) == data.name) { //goods相同，判断supplier
                    var has_supplier = false;
                    for(var k in data.supplierList) { //查找supplier
                        var supplier = data.supplierList[k];
                        if((goods.supplierID + goods.supplierName) == supplier.name) { //supplier存在
                            has_supplier = true;
                            if(goodsData[j].supplierList[k].produceList.indexOf(goods.produceID)>=0){
                                // 重复，不添加
                                break;
                            }
                            else{
                                goodsData[j].supplierList[k].produceList.push(goods.produceID);
                                break;
                            }  
                        }
                    }
                    if(!has_supplier) { //supplier不存在，新增supplier
                       goodsData[j].supplierList.push({
                        "name":(goods.supplierID + goods.supplierName), 
                        "produceList":[goods.produceID]});
                    }
                }
                else { //goods不相同，无需新增元素

                }
            }
        }
    }
    // console.log(goodsMap);
    // console.log(goodsData);
    return goodsData;
}
// 数据绑定
    // 原始数据
    // var produceData = [{"goodsID":"000001","goodsName":"百事可乐","supplierID":"300001","supplierName":"饮品供应商","produceID":"20191111","note":"光棍节促销"},{"goodsID":"000001","goodsName":"百事可乐","supplierID":"300003","supplierName":"食品供应商","produceID":"20191111","note":"光棍节促销"},{"goodsID":"000001","goodsName":"百事可乐","supplierID":"300001","supplierName":"饮品供应商","produceID":"20191212","note":"双12促销"},{"goodsID":"000001","goodsName":"百事可乐","supplierID":"300003","supplierName":"食品供应商","produceID":"20191212","note":"双12促销"},{"goodsID":"000001","goodsName":"百事可乐","supplierID":"300001","supplierName":"饮品供应商","produceID":"20200101","note":"元旦促销"},{"goodsID":"000001","goodsName":"百事可乐","supplierID":"300003","supplierName":"食品供应商","produceID":"20200101","note":"元旦促销"},{"goodsID":"000002","goodsName":"可口可乐","supplierID":"300001","supplierName":"饮品供应商","produceID":"20191111","note":"光棍节促销"},{"goodsID":"000002","goodsName":"可口可乐","supplierID":"300003","supplierName":"食品供应商","produceID":"20191111","note":"光棍节促销"},{"goodsID":"000002","goodsName":"可口可乐","supplierID":"300001","supplierName":"饮品供应商","produceID":"20191212","note":"双12促销"},{"goodsID":"000002","goodsName":"可口可乐","supplierID":"300003","supplierName":"食品供应商","produceID":"20191212","note":"双12促销"},{"goodsID":"000002","goodsName":"可口可乐","supplierID":"300001","supplierName":"饮品供应商","produceID":"20200101","note":"元旦促销"},{"goodsID":"000002","goodsName":"可口可乐","supplierID":"300003","supplierName":"食品供应商","produceID":"20200101","note":"元旦促销"},{"goodsID":"000003","goodsName":"农夫山泉","supplierID":"300001","supplierName":"饮品供应商","produceID":"20191111","note":"光棍节促销"},{"goodsID":"000003","goodsName":"农夫山泉","supplierID":"300003","supplierName":"食品供应商","produceID":"20191111","note":"光棍节促销"},{"goodsID":"000003","goodsName":"农夫山泉","supplierID":"300001","supplierName":"饮品供应商","produceID":"20191212","note":"双12促销"},{"goodsID":"000003","goodsName":"农夫山泉","supplierID":"300003","supplierName":"食品供应商","produceID":"20191212","note":"双12促销"},{"goodsID":"000003","goodsName":"农夫山泉","supplierID":"300001","supplierName":"饮品供应商","produceID":"20200101","note":"元旦促销"},{"goodsID":"000003","goodsName":"农夫山泉","supplierID":"300003","supplierName":"食品供应商","produceID":"20200101","note":"元旦促销"},{"goodsID":"000004","goodsName":"红星笔记本","supplierID":"300002","supplierName":"文具供应商","produceID":"20191111","note":"光棍节促销"},{"goodsID":"000004","goodsName":"红星笔记本","supplierID":"300002","supplierName":"文具供应商","produceID":"20191212","note":"双12促销"},{"goodsID":"000004","goodsName":"红星笔记本","supplierID":"300002","supplierName":"文具供应商","produceID":"20200101","note":"元旦促销"},{"goodsID":"000005","goodsName":"派克钢笔","supplierID":"300002","supplierName":"文具供应商","produceID":"20191111","note":"光棍节促销"},{"goodsID":"000005","goodsName":"派克钢笔","supplierID":"300002","supplierName":"文具供应商","produceID":"20191212","note":"双12促销"},{"goodsID":"000005","goodsName":"派克钢笔","supplierID":"300002","supplierName":"文具供应商","produceID":"20200101","note":"元旦促销"},{"goodsID":"000006","goodsName":"得力订书机","supplierID":"300002","supplierName":"文具供应商","produceID":"20191111","note":"光棍节促销"},{"goodsID":"000006","goodsName":"得力订书机","supplierID":"300002","supplierName":"文具供应商","produceID":"20191212","note":"双12促销"},{"goodsID":"000006","goodsName":"得力订书机","supplierID":"300002","supplierName":"文具供应商","produceID":"20200101","note":"元旦促销"},{"goodsID":"000007","goodsName":"可比克薯片","supplierID":"300003","supplierName":"食品供应商","produceID":"20191111","note":"光棍节促销"},{"goodsID":"000007","goodsName":"可比克薯片","supplierID":"300003","supplierName":"食品供应商","produceID":"20191212","note":"双12促销"},{"goodsID":"000007","goodsName":"可比克薯片","supplierID":"300003","supplierName":"食品供应商","produceID":"20200101","note":"元旦促销"},{"goodsID":"000008","goodsName":"达利园面包","supplierID":"300003","supplierName":"食品供应商","produceID":"20191111","note":"光棍节促销"},{"goodsID":"000008","goodsName":"达利园面包","supplierID":"300003","supplierName":"食品供应商","produceID":"20191212","note":"双12促销"},{"goodsID":"000008","goodsName":"达利园面包","supplierID":"300003","supplierName":"食品供应商","produceID":"20200101","note":"元旦促销"},{"goodsID":"000009","goodsName":"好吃点饼干","supplierID":"300003","supplierName":"食品供应商","produceID":"20191111","note":"光棍节促销"},{"goodsID":"000009","goodsName":"好吃点饼干","supplierID":"300003","supplierName":"食品供应商","produceID":"20191212","note":"双12促销"},{"goodsID":"000009","goodsName":"好吃点饼干","supplierID":"300003","supplierName":"食品供应商","produceID":"20200101","note":"元旦促销"},{"goodsID":"000010","goodsName":"金龙鱼花生油","supplierID":"300004","supplierName":"厨具供应商","produceID":"20191111","note":"光棍节促销"},{"goodsID":"000010","goodsName":"金龙鱼花生油","supplierID":"300004","supplierName":"厨具供应商","produceID":"20191212","note":"双12促销"},{"goodsID":"000010","goodsName":"金龙鱼花生油","supplierID":"300004","supplierName":"厨具供应商","produceID":"20200101","note":"元旦促销"},{"goodsID":"000011","goodsName":"海天酱油","supplierID":"300004","supplierName":"厨具供应商","produceID":"20191111","note":"光棍节促销"},{"goodsID":"000011","goodsName":"海天酱油","supplierID":"300004","supplierName":"厨具供应商","produceID":"20191212","note":"双12促销"},{"goodsID":"000011","goodsName":"海天酱油","supplierID":"300004","supplierName":"厨具供应商","produceID":"20200101","note":"元旦促销"},{"goodsID":"000012","goodsName":"麻辣十三香","supplierID":"300004","supplierName":"厨具供应商","produceID":"20191111","note":"光棍节促销"},{"goodsID":"000012","goodsName":"麻辣十三香","supplierID":"300004","supplierName":"厨具供应商","produceID":"20191212","note":"双12促销"},{"goodsID":"000012","goodsName":"麻辣十三香","supplierID":"300004","supplierName":"厨具供应商","produceID":"20200101","note":"元旦促销"},{"goodsID":"000013","goodsName":"超人牙刷","supplierID":"300005","supplierName":"洗漱品供应商","produceID":"20191111","note":"光棍节促销"},{"goodsID":"000013","goodsName":"超人牙刷","supplierID":"300006","supplierName":"日用品供应商","produceID":"20191111","note":"光棍节促销"},{"goodsID":"000013","goodsName":"超人牙刷","supplierID":"300005","supplierName":"洗漱品供应商","produceID":"20191212","note":"双12促销"},{"goodsID":"000013","goodsName":"超人牙刷","supplierID":"300006","supplierName":"日用品供应商","produceID":"20191212","note":"双12促销"},{"goodsID":"000013","goodsName":"超人牙刷","supplierID":"300005","supplierName":"洗漱品供应商","produceID":"20200101","note":"元旦促销"},{"goodsID":"000013","goodsName":"超人牙刷","supplierID":"300006","supplierName":"日用品供应商","produceID":"20200101","note":"元旦促销"},{"goodsID":"000014","goodsName":"黑人牙膏","supplierID":"300005","supplierName":"洗漱品供应商","produceID":"20191111","note":"光棍节促销"},{"goodsID":"000014","goodsName":"黑人牙膏","supplierID":"300006","supplierName":"日用品供应商","produceID":"20191111","note":"光棍节促销"},{"goodsID":"000014","goodsName":"黑人牙膏","supplierID":"300005","supplierName":"洗漱品供应商","produceID":"20191212","note":"双12促销"},{"goodsID":"000014","goodsName":"黑人牙膏","supplierID":"300006","supplierName":"日用品供应商","produceID":"20191212","note":"双12促销"},{"goodsID":"000014","goodsName":"黑人牙膏","supplierID":"300005","supplierName":"洗漱品供应商","produceID":"20200101","note":"元旦促销"},{"goodsID":"000014","goodsName":"黑人牙膏","supplierID":"300006","supplierName":"日用品供应商","produceID":"20200101","note":"元旦促销"},{"goodsID":"000015","goodsName":"席梦思毛巾","supplierID":"300005","supplierName":"洗漱品供应商","produceID":"20191111","note":"光棍节促销"},{"goodsID":"000015","goodsName":"席梦思毛巾","supplierID":"300006","supplierName":"日用品供应商","produceID":"20191111","note":"光棍节促销"},{"goodsID":"000015","goodsName":"席梦思毛巾","supplierID":"300005","supplierName":"洗漱品供应商","produceID":"20191212","note":"双12促销"},{"goodsID":"000015","goodsName":"席梦思毛巾","supplierID":"300006","supplierName":"日用品供应商","produceID":"20191212","note":"双12促销"},{"goodsID":"000015","goodsName":"席梦思毛巾","supplierID":"300005","supplierName":"洗漱品供应商","produceID":"20200101","note":"元旦促销"},{"goodsID":"000015","goodsName":"席梦思毛巾","supplierID":"300006","supplierName":"日用品供应商","produceID":"20200101","note":"元旦促销"},{"goodsID":"000016","goodsName":"清风抽纸","supplierID":"300006","supplierName":"日用品供应商","produceID":"20191111","note":"光棍节促销"},{"goodsID":"000016","goodsName":"清风抽纸","supplierID":"300006","supplierName":"日用品供应商","produceID":"20191212","note":"双12促销"},{"goodsID":"000016","goodsName":"清风抽纸","supplierID":"300006","supplierName":"日用品供应商","produceID":"20200101","note":"元旦促销"},{"goodsID":"000017","goodsName":"捷达棉签","supplierID":"300006","supplierName":"日用品供应商","produceID":"20191111","note":"光棍节促销"},{"goodsID":"000017","goodsName":"捷达棉签","supplierID":"300006","supplierName":"日用品供应商","produceID":"20191212","note":"双12促销"},{"goodsID":"000017","goodsName":"捷达棉签","supplierID":"300006","supplierName":"日用品供应商","produceID":"20200101","note":"元旦促销"},{"goodsID":"000018","goodsName":"水晶玻璃杯","supplierID":"300006","supplierName":"日用品供应商","produceID":"20191111","note":"光棍节促销"},{"goodsID":"000018","goodsName":"水晶玻璃杯","supplierID":"300006","supplierName":"日用品供应商","produceID":"20191212","note":"双12促销"},{"goodsID":"000018","goodsName":"水晶玻璃杯","supplierID":"300006","supplierName":"日用品供应商","produceID":"20200101","note":"元旦促销"},{"goodsID":"000019","goodsName":"好妈妈拖把","supplierID":"300007","supplierName":"清洁品供应商","produceID":"20191111","note":"光棍节促销"},{"goodsID":"000019","goodsName":"好妈妈拖把","supplierID":"300007","supplierName":"清洁品供应商","produceID":"20191212","note":"双12促销"},{"goodsID":"000019","goodsName":"好妈妈拖把","supplierID":"300007","supplierName":"清洁品供应商","produceID":"20200101","note":"元旦促销"},{"goodsID":"000020","goodsName":"好爸爸抹布","supplierID":"300007","supplierName":"清洁品供应商","produceID":"20191111","note":"光棍节促销"},{"goodsID":"000020","goodsName":"好爸爸抹布","supplierID":"300007","supplierName":"清洁品供应商","produceID":"20191212","note":"双12促销"},{"goodsID":"000020","goodsName":"好爸爸抹布","supplierID":"300007","supplierName":"清洁品供应商","produceID":"20200101","note":"元旦促销"},{"goodsID":"000021","goodsName":"乖儿子扫帚","supplierID":"300007","supplierName":"清洁品供应商","produceID":"20191111","note":"光棍节促销"},{"goodsID":"000021","goodsName":"乖儿子扫帚","supplierID":"300007","supplierName":"清洁品供应商","produceID":"20191212","note":"双12促销"},{"goodsID":"000021","goodsName":"乖儿子扫帚","supplierID":"300007","supplierName":"清洁品供应商","produceID":"20200101","note":"元旦促销"},{"goodsID":"000022","goodsName":"脑白金","supplierID":"300008","supplierName":"保健品供应商","produceID":"20191111","note":"光棍节促销"},{"goodsID":"000022","goodsName":"脑白金","supplierID":"300008","supplierName":"保健品供应商","produceID":"20191212","note":"双12促销"},{"goodsID":"000022","goodsName":"脑白金","supplierID":"300008","supplierName":"保健品供应商","produceID":"20200101","note":"元旦促销"},{"goodsID":"000023","goodsName":"成长快乐","supplierID":"300008","supplierName":"保健品供应商","produceID":"20191111","note":"光棍节促销"},{"goodsID":"000023","goodsName":"成长快乐","supplierID":"300008","supplierName":"保健品供应商","produceID":"20191212","note":"双12促销"},{"goodsID":"000023","goodsName":"成长快乐","supplierID":"300008","supplierName":"保健品供应商","produceID":"20200101","note":"元旦促销"},{"goodsID":"000024","goodsName":"黄金搭档","supplierID":"300008","supplierName":"保健品供应商","produceID":"20191111","note":"光棍节促销"},{"goodsID":"000024","goodsName":"黄金搭档","supplierID":"300008","supplierName":"保健品供应商","produceID":"20191212","note":"双12促销"},{"goodsID":"000024","goodsName":"黄金搭档","supplierID":"300008","supplierName":"保健品供应商","produceID":"20200101","note":"元旦促销"}];    // 预期数据样例
    // 样例数据
    // var goodsList = [{
    //         "name":"000001百事可乐", "supplierList":[          
    //             {"name":"300001饮品供应商", "produceList":["20191111","20191212","20200101"]},          
    //             {"name":"300002食品供应商", "produceList":["20191111","20191212","20200101"]}
    //         ]
    //     },{
    //         "name":"000002可口可乐", "supplierList":[          
    //             {"name":"300001饮品供应商", "produceList":["20191111","20191212","20200101"]},          
    //             {"name":"300002食品供应商", "produceList":["20191111","20191212","20200101"]}
    //         ]
    //     },{
    //         "name":"000003农夫山泉", "supplierList":[          
    //             {"name":"300001饮品供应商", "produceList":["20191111","20191212","20200101"]},          
    //             {"name":"300002食品供应商", "produceList":["20191111","20191212","20200101"]}
    //         ]
    //     }
    // ];
    // 处理原始数据
    // var goodsList = getList(produceData);
    
//三级联动
$.fn.goodsProduce = function(goodsID,supplierID,produceID,goodsList){

    var goods = $(this).find('select[lay-filter=goods]');
    var supplier = $(this).find('select[lay-filter=supplier]');
    var produce = $(this).find('select[lay-filter=produce]');
    // console.log(goods);
    
    var supplierList = [];
    var produceList = [];

    showGoods(goodsList);
    showSupplier(supplierList);
    showProduce(produceList);

    function showGoods(goodsList) {
        goods.html("<option value=''>商品</option>");
        for (var i in goodsList) {
            // console.log(i);
            if(goodsID==goodsList[i].name){
                supplierList = goodsList[i].supplierList;
                // console.log(goodsID);
                goods.append("<option selected value='"+goodsList[i].name+"'>"+goodsList[i].name+"</option>")
            }else{
                goods.append("<option value='"+goodsList[i].name+"'>"+goodsList[i].name+"</option>")
            }
        }  
    }

    function showSupplier(supplierList) {
        supplier.html("<option value=''>供应商</option>");
        for (var i in supplierList) {
            if(supplierID==supplierList[i].name){
                produceList = supplierList[i].produceList;
                supplier.append("<option selected value='"+supplierList[i].name+"'>"+supplierList[i].name+"</option>")
            }else{
                supplier.append("<option value='"+supplierList[i].name+"'>"+supplierList[i].name+"</option>")
            }
        }
    }

    function showProduce(produceList) {
        produce.html("<option value=''>生产批号</option>");
        for (var i in produceList) {
            if(produceID==produceList[i]){
                produce.append("<option selected value='"+produceList[i]+"'>"+produceList[i]+"</option>")
            }else{
                produce.append("<option value='"+produceList[i]+"'>"+produceList[i]+"</option>")
            }
        }
    }
    // 渲染下拉框
    form.render('select');
    // 监听更新-回调
    form.on('select(goods)', function(obj){
        // console.log(obj);
        goodsID = obj.value;
        showGoods(goodsList);
        showSupplier(supplierList);
        showProduce(produceList);
        form.render('select');
    });

    form.on('select(supplier)', function(obj){
        supplierID = obj.value;
        showSupplier(supplierList);
        showProduce(produceList);
        form.render('select');
    });

}
