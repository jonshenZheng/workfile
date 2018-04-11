/* 
* @Author: RainCloud
* @Date:   2018-01-30 10:50:02
* @Last Modified by:   RainCloud
* @Last Modified time: 2018-01-30 10:51:13
*/

/*其他库的封装*/

/*
* bootstrap 弹窗方法
* 参数
*   opt 类型为 obeject
*
* 参数说明
*   til 标题
*   msg、 tpls模板
*   btnNum 按钮数量 0为没有按钮
*   size  弹窗尺寸 值为'wide'时为宽尺寸
*   btnName 按钮名字 小标为零的为确认按钮，小标为1的为取消按钮 类型为数组 (只有一个按钮的情况下默认按钮名为确定，改功能未测试) 换名字的时候 opt.btnName = ['关闭']；此时btnNum的值一定为1，不然超过1就会报错
*   ready 弹窗展示时执行的回调
*   fasleFn 点击弹窗取消按钮的回调  (回调报错是能关闭弹窗，改功能未测试)
*   trueFn 点击弹窗确认按钮的回调 (回调报错是能关闭弹窗，改功能未测试)
*   cb 弹窗关闭执行的回调（有两个个按钮的情况下，点击确定按钮才能执行回调）
* 
*/
function PublicPop(opt){
    
    if(!opt || Object.prototype.toString.call(opt) !== '[object Object]' ){
        return;
    }

    var opts = {
            til : '提示',
            msg : '',
            tpls : '',
            size : '',
            btnName : ['确定','取消'],
            btnNum : 2,
            ready : function(tplJqObj){},
            fasleFn : function(){},
            trueFn : function(){},
            cb : function(){}
        },
        key,
        btnObj,
        $content = null;

    function runFn(fn){
        try{
            return fn();
        }
        catch(e){
            console.log(e.message);//不支持IE6，如要支持if(console){console.log(e.message);}else{alert(e.message);}
            return false;
        }
    }

    for (key in opts) {

        if(opts.hasOwnProperty(key)){

            if( Object.prototype.toString.call(key) === '[object Aarray]'){
                var len = key.length;

                for(;len--;){
                    if(opt[key][len]){
                        opts[key][len] = opt[key][len];
                    }
                }

            }
            else if(opt[key] || opt[key] === 0){
                opts[key] = opt[key];
            }

        }
    }
    if(opts.btnNum === 2){
        btnObj = [{
            label: opts.btnName[0],
            cssClass: 'btn-primary',
            action: function (dialog) {

                if(!runFn(opts.trueFn)){
                    dialog.close();
                }  

                opts.cb();

            }
        }, {
            label: opts.btnName[1],
            action: function (dialog) {

                if( !runFn(opts.fasleFn)){
                    dialog.close();
                }
   
            }
        }];
    }
    else if(opts.btnNum === 1){ 
        btnObj = [{
            label: opts.btnName[0],
            cssClass: 'btn-primary',
            action: function (dialog) {
                dialog.close();
            }
        }];
    }
    else if(opts.btnNum == 0){ 
        btnObj = [];
    }

    BootstrapDialog.show({
        title: opts.til,
        message: function (dialog){
            
            if(opts.tpls){
                $content = opts.tpls;
            }
            else if(opts.msg){
                $content = $(opts.msg);
            }

            if(opts.size === 'wide'){
                dialog.setSize(BootstrapDialog.SIZE_WIDE);
            }
            return $content;
        },
        onshown: function(dialogRef){
            opts.ready(dialogRef,$content);
        },
        buttons: btnObj
    });
}

function publicIsEmail(email){
    return publicRegx.emial.test(email);
}
