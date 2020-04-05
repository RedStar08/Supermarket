layui.use(['form','layer'], function(){
    var form = layui.form
    ,layer = layui.layer;
    
    //自定义验证规则
    form.verify({
        goodsID: function(value){
          if(value.length != 6){
            return '商品ID为6位数字';
          }
          if(value < 0){
            return '商品ID必须在000000-099999之间';
          }
          if(value >= 100000){
            return '商品ID必须在000000-099999之间';
          }
        }
        ,goodsPrice: function(value){
          if(value <= 0){
            return '商品价格必须大于0';
          }
        }
        ,goodsNum: function(value){
          // console.log(value);
          if(value <= 0){
            return '商品数量必须>=0';
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
          if(value.length != 6){
            return '供应商ID为6位数字';
          }
          if(value < 300000){
            return '供应商ID必须在300000-399999之间';
          }
          if(value >= 400000){
            return '供应商ID必须在300000-399999之间';
          }
        }
        ,storeID: function(value){
          if(value.length != 6){
            return '仓库ID为6位数字';
          }
          if(value < 400000){
            return '仓库ID必须在400000-499999之间';
          }
          if(value >= 500000){
            return '仓库ID必须在400000-499999之间';
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
        ,instockID: function(value){
          if(value.length != 12){

            return '入库单号为12个字符(日期-编号2019-01-01-0001)';
          }
          if(value < 201911100000){
            return '入库单号必须在201911100000-205001010000之间';
          }
          if(value >= 205001010000){
            return '入库单号必须在201911100000-205001010000之间';
          }
        }
        ,instockNum: function(value){
          if(value <= 0){
            return '入库数量必须大于0';
          }
        }
        ,outstockID: function(value){
          if(value.length != 12){
            // console.log(value.length);
            return '出库单号为12个字符(日期-编号组成2019-01-01-0001)';
          }
          if(value < 201911100000){
            return '出库单号必须在201911100000-205001010000之间';
          }
          if(value >= 205001010000){
            return '出库单号必须在201911100000-205001010000之间';
          }
        }
        ,outstockNum: function(value){
          // console.log(value);
          if(value <= 0){
            return '出库数量必须大于0';
          }
        }
        ,checkID: function(value){
          if(value.length != 12){
            // console.log(value.length);
            return '报表单号为12个字符(日期-编号组成2019-01-01-0001)';
          }
          if(value < 201911100000){
            return '报表单号必须在201911100000-205001010000之间';
          }
          if(value >= 205001010000){
            return '报表单号必须在201911100000-205001010000之间';
          }
        }
        ,checkNum: function(value){
          // console.log(value);
          if(value < 0){
            return '盘点数量必须>=0';
          }
        }
        ,buysID: function(value){
          if(value.length != 12){
            // console.log(value.length);
            return '采购单号为12个字符(日期-编号组成2019-01-01-0001)';
          }
          if(value < 201911100000){
            return '采购单号必须在201911100000-205001010000之间';
          }
          if(value >= 205001010000){
            return '采购单号必须在201911100000-205001010000之间';
          }
        }
        ,salesID: function(value){
          if(value.length != 12){
            // console.log(value.length);
            return '销售单号为12个字符(日期-编号组成2019-01-01-0001)';
          }
          if(value < 201911100000){
            return '销售单号必须在201911100000-205001010000之间';
          }
          if(value >= 205001010000){
            return '销售单号必须在201911100000-205001010000之间';
          }
        },salesMoney: function(value){
          if(value <= 0){
            return '收款金额不正确！';
          }
        }
        ,userID: function(value){
          if(value.length != 6){
            return '用户ID为6位数字';
          }
          if(value < 100000){
            return '用户ID必须在100000-199999之间';
          }
          if(value >= 200000){
            return '用户ID必须在100000-199999之间';
          }
        }
        ,pass: function(value){
          if(value.length < 6 || value.length > 12){
            return '密码必须6到12位，且不能出现空格';
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
    //获取url参数
    function getQueryVariable(name) {
      var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); 
      var paramName = window.location.search.substr(1).match(reg); 
      if(paramName != null){
         //decodeURIComponent 处理中文乱码
          return decodeURIComponent(paramName[2]);
      }
      return(false);
    }