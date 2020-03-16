layui.use(['form','layer'], function(){
    var form = layui.form
    ,layer = layui.layer;
    
    //自定义验证规则
    form.verify({
        goodsID: function(value){
          if(value < 0){
            return '商品ID必须为6位数且在000000-099999之间';
          }
          if(value >= 100000){
            return '商品ID必须为6位数且在000000-099999之间';
          }
          if(value.length != 6){
            return '商品ID为6个字符';
          }
        }
        ,goodsPrice: function(value){
          if(value <= 0){
            return '商品价格必须大于0';
          }
        }
        ,goodsSave: function(value){
            if(value <= 0){
                return '保质期必须大于0';
            }
        }
        ,goodsProduce: function(value){
                if(value <= 20191110){
                  return '商品生产批号过早';
              }
        }
        ,supplierID: function(value){
          if(value < 300000){
            return '供应商ID必须为6位数且在300000-399999之间';
          }
          if(value >= 400000){
            return '供应商ID必须为6位数且在300000-399999之间';
          }
          if(value.length != 6){
            return '供应商ID为6个字符';
          }
        }
        ,storeID: function(value){
          if(value < 400000){
            return '仓库ID必须为6位数且在400000-499999之间';
          }
          if(value >= 500000){
            return '仓库ID必须为6位数且在400000-499999之间';
          }
          if(value.length != 6){
            return '仓库ID为6个字符';
          }
        }
        ,storeNum: function(value){
          if(value < 0){
            return '已用容量必须大于等于0';
          }
        }
        ,storeMax: function(value){
            if(value <= 0){
              return '仓库容量必须大于0';
            }
            var Num = $('#storeNum').val();
            var Max = value;
            // console.log( Num );
            // console.log(Max);
            if(Number(Num) > Number(Max)){
              // console.log(' Num ');
              $('#storeMax').val(Number(Num));
              return '仓库容量必须大于已用容量'
            }
        }
        ,userID: function(value){
          if(value < 100000){
            return '用户ID必须为6位数且在100000-199999之间';
          }
          if(value >= 200000){
            return '用户ID必须为6位数且在100000-199999之间';
          }
          if(value.length != 6){
            return '用户ID为6个字符';
          }
        }
        ,userAge: function(value){
          if(value < 18){
            return '用户年龄必须大于18岁，小于65岁';
          }
          if(value >= 65){
            return '用户年龄必须大于18岁，小于65岁';
          }
        }

    });
      
});