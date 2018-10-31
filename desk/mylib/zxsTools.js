function noop(){}

function isArray(arr){
    return Object.prototype.toString.call(arr) === '[object Array]';
}

function isObject(obj){
    return Object.prototype.toString.call(obj) === '[object Object]';
}

function isFunction(fn){
    return typeof fn === 'function';
}

function isString(str){
    return typeof str === 'string';
}

function isNumber(num){
    return typeof num === 'number';
}


function zxsAjaxFn(url,data,sucCb,errCb,comCb){

    if(!url){
        return;
    }

    var opt = {
        url : url,
        type : 'GET',
        dataType : 'json',
        success : noop,
        error : noop,
        complete : noop
    },
    succFn = noop,
    successFn,
    ind = 0;

    if( isObject(arguments[1]) ){
        zxs_tools.mergeParm(data,opt,true);

        isFunction(opt.success) ? ( succFn = opt.success ) : '';
    }
    else{
        
        if( isFunction(data) ){
            ind = 1;
        }
        else{
            data ? (opt.data = data) : '';
        }

        isFunction(arguments[2-ind]) ? ( succFn = arguments[2-ind] ) : '';
        isFunction(arguments[3-ind]) ? ( opt.error = arguments[3-ind] ) : ''; 
        isFunction(arguments[4-ind]) ? ( opt.complete = arguments[4-ind] ) : ''; 
    }

    successFn = function(r){

        if(r.backRunFn){
            try{
                //eval(r.backRunFn);
                eval(r.backRunFn);
                backRunFn(r);
            }
            catch(e){
                console.log(e);
            }
        }

        succFn(r);
    }

    opt.success = successFn;

    $.ajax(opt);

}


var zxs_tools = {

    RegexpObj : {
        num       : /^[+\-]?(\d+\.)?\d+$/,          //数字(不能匹配科学计数法eg:623.E12)
        num_z     : /^[+]?(\d+\.)?\d+$/,            //正数
        num_f     : /^-(\d+\.)?\d+$/,               //负数
        num_int   : /^[+\-]?\d+$/,                  //整数
        num_int_z : /^[+]?\d+$/,                    //正整数
        num_int_f : /^-\d+$/,                       //负整数
        date      : /^\d{4}-\d{1,2}-\d{1,2}$/,      //简单日期格式(缺少月数，和天数的的正确范围)
        trim      : /^\s+|\s+$/g,                   //匹配到开头和末尾的空格，正则存在分组，没有g的话匹配到第一条分支就结束了。一般/^\s*((\S\s*\S*)+)\s*$/来匹配含有前后的空格的字符串，不是匹配空格，再用第一个括号的匹配到的文本进行替换到达去掉两边空格的效果。但不建议使用。匹配复杂，替换文本多都会耗时长
        oneSpace :　/\s{2,}/g,                       //匹配空格（至少两个空格，用来统一成一个空格）ie可能不支持，要看下JQ怎么写的
        chinese : /[\u4e00-\u9fa5]/,                //匹配中文
        email : /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+/,     //匹配邮箱
        password : /(^.*?[a-zA-Z]+.*?\d+.*?$)|(^.*?\d+.*?[a-zA-Z]+.*?$)/,  //密码不能为纯数字或纯英文且不能为中文
        phone : /^1[13456789][0-9]{9}$/,             //匹配手机号
        telephone : /^0\d{2,3}-?\d{7,8}$/,          //匹配固话（必须加区号）
        noIntNumber : /^0|\D/,                       //匹配非整数（填写表单的时候，用来去掉一些非整数的字符） 
        words : /[\u4e00-\u9fa5\s\w]/,              //匹配数字空格大小写字母和中文
    },

    //原生事件绑定
    easyLibEvent : {
        getEvent : function(e){
            return e?e:window.Event;
        },
        stopPropagation : function(e){

            var e = easyLibEvent.getEvent(e);

            if(e.stopPropagation){
                e.stopPropagation();
            }
            else{
                e.cancelable = true;
            }
        },
        preventDefault : function(e){

            var e = easyLibEvent.getEvent(e);

            if(e.preventDefault){
                e.preventDefault();
            }
            else{
                e.returnValue = false;
            }
        },
        addEvent : function(obj,type,fn){
            if(obj.addEventListener){
                obj.addEventListener(type,fn,false);
            }
            else if(obj.attachEvent){
                obj.attachEvent('on'+type,fn);
            }
            else{
                obj['on'+type] = fn;
            }
        },
        removeEvent : function(obj,type,fn){
            if(obj.removeEventListener){
                obj.removeEventListener(type,fn,false);
            }
            else if(obj.detachEvent){
                obj.detachEvent('on'+type,fn);
            }
            else{
                obj['on'+type] = null;
            }
        }
    },
    //数据运算操作
    Method : {
        /* 初始化数组 
        *   arr 要初始化的数组
        *   len 指定数组长度 
        *   val 初始化的值
        */
        initArr : function(arr,len,val){

            let i = len > 0 ? len : 0;

            arr.splice(0,arr.length);

            for(;i;i--){
                arr.push(val);
            }

        },
        /* 设置数组指定范围的值
        *
        * beg起始位置
        * end终止位置（包含此位置）
        * val 要设置的值
        * 
        */
        setArrVal : function(arr,beg,end,val){

            let len = arr.length,
                max = len - 1,
                begin,
                temp,
                last;

            begin = beg || 0;   
            last = end || max;

            if(begin > max){
                return arr;
            }
            else if(begin < 0){
                begin = 0;
            }

            if(last < 0){
                last = 0
            }
            else if(last > max){
                return arr;
            }

            if(last < begin){
                temp = begin;
                begin = last;
                last = temp;
            }


            for(;begin <= last;begin++){
                arr[begin] = val;
            }

        }, 
        /*
        *返回数组的所有组合
        *arr : 获取组合源数据，类型为数组
        *max ： 最多长度的组合（包括最大长度下的组合）
        *curLen : 返回指定长度的组合
        */  
        getCombination : function(arr,max,curLen){

            var runFn;

            if(max >= 6 || arr.length >= 6){
                //递归的层级太多就不能用递归，改为循环(长度为10内存溢出)
                runFn = function getpw(arr,max,curLen){

                    if( Object.prototype.toString.call(arr) !== '[object Array]' || !arr.length){
                        return [];
                    }
            
                    let keyWd = arr,
                        keyWdLen = keyWd.length,
                        maxLen = keyWdLen - 1,
                        keyWd_max = max || keyWdLen, //不能小于数组的长度
                        startValLen = 1,
                        val_cmm = [],
                        for_ind = [],
                        temp_ind = 0,
                        layer = 1,
                        overLen,
                        resArr = [],
                        deep = 0;  // 循环到那一层的
                        

                    function commV(){
                        
                        while(1){

                            if(deep >= overLen){

                                temp_ind = for_ind[deep]+1;
                                for_ind[deep] = temp_ind;
                                val_cmm[deep] = keyWd[temp_ind];

                                resArr.push(val_cmm.join(','));

                                let i = overLen;

                                for(;i>=-1;i--){

                                    if( for_ind[i] < maxLen){
                                        break;
                                    }   
                                }

                                if(i <= -1){
                                    return;
                                }

                                deep = i;

                                Method.setArrVal(for_ind,deep+1,'',-1); 
                                
                            }
                            else{
                                temp_ind = for_ind[deep]+1;
                                for_ind[deep] = temp_ind;
                                val_cmm[deep] = keyWd[temp_ind];
                                deep++;
                            }

                        }

                    } 
                  
                   
                    for(;layer <= keyWd_max;layer++){
                        deep = 0;
                        overLen = layer - 1;
                        Method.initArr(for_ind,layer,-1);
                        commV();
                    }

                    return resArr;

                }

            }
            else{
                runFn = function(arr,max,curLen){

                    if( Object.prototype.toString.call(arr) !== '[object Array]' || !arr.length){
                        return [];
                    }

                    let keyWd = arr,
                        keyWdLen = keyWd.length,
                        keyWd_max = max || keyWdLen,
                        startLen = 1,
                        restArr = [],
                        justLen = 0,
                        cmm = [];


                    if(curLen && curLen > 0){
                        justLen = curLen >=  keyWd_max ? keyWd_max : curLen;
                    }
                           
                    function getCommStr(deep) {

                        if (deep > 0){

                            let arrInd = startLen - deep,
                                i = 0;

                            deep--;

                            for (; i < keyWdLen;i++){

                                cmm[arrInd] = keyWd[i];

                                if (deep > 0){
                                  getCommStr(deep);
                                }
                                else{
                                  restArr.push(cmm.join('')) 
                                }

                            }

                        }

                    }


                    for (; startLen <= keyWd_max; startLen++){

                        if(justLen && justLen !== startLen){
                            continue;
                        }

                        cmm = [];
                        getCommStr(startLen);
                    }    
                      
                    return restArr
                }
            }

            return runFn(arr,max,curLen);   

        },
        /*解析返回来是字符串数据，里面json变为字符串，还加了<pre>标签*/
        parseStrData : function(strData){
            var res,
                datas,
                dataInd;

            dataInd = data.indexOf('{');
         
            if(dataInd < 0){
                return;
            }

            res = data.slice(dataInd,-6);   
            datas = JSON.parse(res);

            return datas;
            
        },
        /* 将对象的key或数组的索引存到一个数组上 */
        getkeyToArr : function(obj){

            if( !isArray(obj) || !isObject(obj) ){
                return;
            }

            var arr = [];

            for(key in obj){
                arr.push(key);
            }

            return arr;

        },
        /*获取 函数名*/
        getFnName : function(fn){

            if(typeof fn !== 'function'){
                return;
            }

            var str = String(fn),
                end = str.indexOf('('),
                name = '';

            str = str.slice(8,end);
            name = trim(str);

            return name;     

        },
        //通过多个索引来删除数组 (有问题，改变原数组的索引，要修正)
        arrDeleteEles : function(arr,delArrInd){

            var len = arr.length,
                o_len = len-1,
                indLen = delArrInd.length,
                o_indLen = indLen,
                ind,
                indArr = Method.getNumIndArr(len), //洗牌之后索引位置
                realKey,
                temp;

            for(; indLen-- ;){

                ind = delArrInd[indLen];
                ind = indArr[ind];

                if( ind === o_len){
                    o_len--;
                    continue;
                }

                //正真的索引位置
                realKey = indArr[o_len];
                temp = arr[realKey];
                arr[ind] = temp; 
                //更新索引
                indArr[realKey] = ind;
                indArr[ind] = realKey;

                o_len--;

            }

            arr.splice( len-o_indLen,o_indLen);

        },
        //生成索引数组
        getNumIndArr : function(len){

            var i = 0,
                arr = [];

            for(i; i< len;i++){
                arr[i] = i;
            }

            return arr;
        },
        //改数组的里面的条目的key名
        //eg1 : 将数组arr1每一项的fdstr改成name
        //      arr1 = [{ fdstr : 'cc', id : 1 },{ fdstr : 'bb', id : 2 }]
        //      使用 arr1 = setDataValName( arr1 , 'fdstr' , 'name' );
        //      结果 ： arr = [{ name : 'cc', id : 1 },{ name : 'bb', id : 2 }]
        //
        //eg2 : 将数组arr1每一项的fdstr和count分别改成name和val
        //      arr2 = [{ fdstr : 'cc', count : 6 ,id : 1 },{ fdstr : 'bb', count : 18 , id : 2 }]           
        //      使用 arr2 = setDataValName( arr2 , ['fdstr','count'] , ['name','val'] );
        //      结果 ： arr = [{ name : 'cc', val : 6 ,id : 1 },{ name : 'bb', val : 18 , id : 2 }] 
        //
        setDataValName : function(arr,oldKey,newKey){

            if( !isArray(arr) ){
                return;
            }

            var newArr = [],
                len = arr.length,
                i = 0,
                temp,
                key,
                fn,
                oldKeyStr;

            if( isArray(oldKey) && isArray(newKey) ){

                oldKeyStr = ';' + oldKey.join(';') + ';';

                fn = function(ind,key){

                var sKey = ';'+key+';',
                        temp,
                        newKeyName,
                        nInd = oldKeyStr.indexOf( sKey );

                    if( nInd !== -1 ){

                        if( nInd !== 0 ){
                            temp = oldKeyStr.slice(1, nInd);
                            nInd = temp.split(';').length;
                        }

                        newKeyName = newKey[nInd];

                        newArr[ind][newKeyName] = arr[ind][key];

                    }
                    else{
                        newArr[ind][key] = arr[ind][key];
                    }

                };
            }
            else{
                fn = function(ind,key){
                    if( key === oldKey ){
                        newArr[ind][newKey] = temp[key];
                    }
                    else{
                        newArr[ind][key] = temp[key];
                    }
                };
            }

            for(;i<len; i++){

                temp = arr[i];

                newArr[i] = {};

                for( key in temp ){

                    fn(i,key);

                }
            }
            return newArr;

        },
        //换key名    （深拷贝 拷贝的对象是数组是对象，以及对象嵌套数组，数组嵌套对象都行，目前只能手动设置要改的key名)
        formatterData : function(data){
            var nArr,
                len,
                i = 0;


            if( isArray(data) ){
                nArr = [];
                len = data.length;

                for(;i<len;i++){

                    if( isObject(data[i]) ){
                        nArr[i] = {};
                        copyObj(nArr[i],data[i]);
                    }
                    else if( isArray(data[i]) ){
                        nArr[i] = [];
                        copyArr(nArr[i],data[i]);
                    }
                    else{
                        nArr[i] = data[i];
                    }

                }

            }
            else if( isObject(data) ){
            
                nArr = {};
                copyObj(nArr,data);

            }   

            return nArr;

        },
        //深拷贝数组 （不是通用，要改）
        copyArr : function(obj,cobj){
            var len = cobj.length,
                i = 0;

            for(;i<len;i++){

                if(isArray(cobj[i])){
                    obj[i] = [];
                    Method.copyArr(obj[i],cobj[i]);
                }
                else if( isObject(cobj[i])){
                    obj[i] = {};
                    Method.copyObj(obj[i],cobj[i]);
                }
                else{
                    obj[i] = cobj[i];
                }
             
            }

        },
        //深拷贝对象（不是通用,要改）
        copyObj : function(obj,cObj){

            if( Object.prototype.toString.call(cObj) === '[object Array]' ){
                obj = [];
                copyArr(obj,cObj);

            }
            else{
                for(key in cObj){

                    if( key == 'pid'){
                        if(cObj.pid.length){   //这里要改
                            obj['children'] = [];
                            Method.copyArr(obj['children'],cObj.pid);
                        }
                    }
                    else if( key == 'id' ){
                        obj['value'] = cObj[key];
                    }
                    else if( key == 'name' ){
                        obj['name'] = cObj[key];
                    }
                    else{
                        //obj[key] = cObj[key];
                    }

                }
            }

        },
        //找到对象中 id=12所在位置，在这里添加一个属性active:true, ((可以利用回调执行属性增删)
        //eg setObjVal('id','12',function(o){o['active'] = true; },data);
        setObjVal : function(key,val,cb,data){

            var setKey = key,
                isBreck = false,
                setVal = val,
                doSome = cb;

            setDataAttt(data);

            function setDataAttt(data){
            
                if(isBreck){
                    return;
                }

                if( isArray(data) ){

                    var len = data.length,
                        i = 0;      

                    for(;i<len;i++){

                        if(isBreck){
                            return;
                        }

                        setDataAttt(data[i]);
                    }

                }
                else if( isObject(data) ){

                    for( var key in data ){

                        if(isBreck){
                            return;
                        }

                        if( isArray(data[key]) || isObject(data[key]) ){
                            setDataAttt(data[key]);
                        }
                        else{

                            if( key === setKey && data[key] === setVal ){
                                doSome(data);
                                isBreck = true;
                                return; 
                            }
                        }
                    }
                }
            }
        }
        dataType : function(val,type){

            var ObjProtoStr =  Object.prototype.toString;
            
            if(!type || val != undefined ){
                return;
            }

            switch(type){
                /*数字(不能匹配科学计数法eg:623.E12)*/
                case 'num'      :   return RegexpObj.num.test(val);
                    break;
                //正数
                case 'num_z'    :   return RegexpObj.num_z.test(val);
                    break;
                //负数
                case 'num_f'    :   return RegexpObj.num_f.test(val);
                    break;      
                //整数
                case 'num_int'  :   return RegexpObj.num_int.test(val);
                    break;
                //正整数
                case 'num_int_z' :      return RegexpObj.num_int_z.test(val);
                    break;
                //负整数
                case 'num_int_f' :      return RegexpObj.num_int_f.test(val);
                    break;
                case 'array'    :   return ObjProtoStr.call(val) === '[object Array]';  
                    break;
                case 'boolean'  :   return ObjProtoStr.call(val) === '[object Boolean]';
                    break;
                //判断是不是日期对象而不是检测日期格式
                case 'date'     :   return ObjProtoStr.call(val) === '[object Date]'; 
                    break;
                case 'regExp'   :   return ObjProtoStr.call(val) === '[object RegExp]';
                    break;
                case 'function' :   return ObjProtoStr.call(val) === '[object Function]';
                    break;
                case 'object'   :   return ObjProtoStr.call(val) === '[object Object]';
                    break;          
            }
        },

        StrSplit : function (date,ops){
            var val = String(date),
                handle = String(ops),
                temp,
                temp_len,
                i = 0,
                obj = {};
            if(ops === 'date'){
                temp = val.split('-');
                if(temp.length === 2){
                    return {yy:parseInt(temp[0]),mm:parseInt(temp[1])};
                }
                return temp.length===3 && {yy:parseInt(temp[0]),mm:parseInt(temp[1]),dd:parseInt(temp[2])};
            }

            temp = val.split(handle);
            temp_len = temp.length;

            if(temp_len && temp_len===1){
                return false;
            }
            for (; i < temp_len; i++) {
                obj[i] = temp[i];
            }

            return obj;
        }
        //格式化字符串，去掉首尾空格，中两个以上的空格全部变为一个空格
        formatCName : function(str){
            return str.replace(RegexpObj.trim,'').replace(RegexpObj.oneSpace,' ');
        },

        //替换Jquery中的方法
        addClass : function (obj,cName){

            function acn(CN){
                if(!CN && typeof CN !== 'string'){
                    return;
                }

                var Ele = this,
                    k;

                if(Ele.length){

                    k = Ele.length;

                    for(;k--;){
                        aCName(Ele[k],CN);
                    }

                }
                else{
                    aCName(Ele,CN);
                }
            }
            
            function aCName(ele,CN){

                if(ele.nodeType !== 1){
                    return;
                }

                var old_name,
                    temp_name,
                    name,
                    temp_cn,
                    i = 0;

                old_name = ele.className;

                //格式化要添加的类名
                name = formatCName(CN);
                name = name.split(' ');

                //格式化旧类名
                old_name = old_name ? ' '+formatCName(old_name)+' ' : ' ';

                temp_name = old_name;

                
                while(temp_cn = name[i++]){
                    //不存在的类名时加上类名
                    if(temp_name.indexOf(' '+temp_cn+' ') === -1){
                        temp_name += temp_cn+' ';
                    }
                }

                if(old_name !== temp_name){
                    ele.className = trim(temp_name);
                }
            }

            acn.call(obj,cName);

        },
        //替换Jquery中的方法
        removeClass : function (obj,cName){

            function rcn(CN){
                if(!CN || typeof CN !== 'string'){
                    return;
                }

                var Ele = this,
                    k;

                if(Ele.length){

                    k = Ele.length;

                    for(;k--;){
                        rCName(Ele[k],CN);
                    }

                }
                else{
                    rCName(Ele,CN);
                }
            }

            function rCName(ele,CN){

                var old_name,
                    temp_name,
                    name,
                    temp_cn,
                    i = 0;  

                old_name = ele.className;

                if(ele.nodeType !== 1 || !old_name){
                    return;
                }

                name = formatCName(CN);
                name = name.split(' ');

                //格式化旧类名
                old_name = ' '+formatCName(old_name)+' ';

                temp_name = old_name;

                while(temp_cn = name[i++]){
                    //不存在的类名时加上类名
                    if(temp_name.indexOf(' '+temp_cn+' ') > -1){
                        temp_name = temp_name.replace(temp_cn+' ','');
                    }
                }

                if(old_name !== temp_name){
                    ele.className = trim(temp_name);
                }
            }

            rcn.call(obj,cName);

        }









    },

    //排序函数
    sortMethod : {

        //冒泡排序法和直插法结合（不稳定性，越乱越久，最长N阶乘,最短为数组的长度，原来就是取每一轮的最大值，第一轮就数组末尾最大值，第二轮就数组倒数第二位置插入第二大值，第三轮就数组倒数第三位置插入第三大值，以此类推，n*(n-1)*(n-2)*(n-3)...*1）
        easySort : function(arr){
            var len = arr.length-1,
                j,
                i,
                temp,
                swop_times = 0;

            for (i = 0; i < len; i++) {

                for (j = 0; j < len-i; j++) {
                    
                    if(arr[j]>arr[j+1]){
                        swop_times++;
                        temp = arr[j];
                        arr[j] = arr[j+1];
                        arr[j+1] = temp;
                    }

                };

                if(swop_times === 0){
                    break;
                }
                else{
                    swop_times = 0;
                }
            };
        },
        quickSort : function(array){  //不是快速排序，要改 （写成固定了）

            function sort(prev, numsize){

                var nonius = prev,
                    j = numsize -1,
                    flag = array[prev];

                if ((numsize - prev) > 1) {

                    while(nonius < j){
                        for(; nonius < j; j--){
                            if (array[j] < flag) {
                                array[nonius++] = array[j];　//a[i] = a[j]; i += 1;
                                break;
                            };
                        }
                        for( ; nonius < j; nonius++){
                            if (array[nonius] > flag){
                                array[j--] = array[nonius];
                                break;
                            }
                        }
                    }

                    array[nonius] = flag;
                    sort(0, nonius);
                    sort(nonius + 1, numsize);
                }
            }

            sort(0, array.length);

            return array;
        }

    },

    /** 用于合并参数 （无返回值 会改变第二个参数的内容）
     * 
     * 必填 dataObj  object类型  传入的函数的参数
     * 必填 updateObj  object类型  函数中的默认参数
     * 选填 isCover boolean类型 默认参数没有的属性是否从传参添加进来 默认不添加
     * 
     */
    mergeParm : function(dataObj,updateObj,isCover){
        var cover = !!isCover,
            fn,
            key;
          
        if( !isObject(dataObj) || !isObject(updateObj) ){
            return;
        }
        
        if(cover){
            fn = function(){
                for( key in  dataObj){
                    updateObj[key] = dataObj[key];
                }
            };
        }
        else{
            fn = function(){
                for( key in  dataObj){
                    if( updateObj.hasOwnProperty(key) ){
                        updateObj[key] = dataObj[key];    
                    }
                }
            };
        }
        
        fn();
    },
    //格式化字符串
    toString : function(val) {
        return val == null
        ? ''
        : is() typeof val === 'object'
          ? JSON.stringify(val, null, 2)
          : String(val);
    },
    //去掉首尾空格
    trim：function(str){
        return str.replace(zxs_tools.RegexpObj.trim,'');
    },
    /*格式化所有空格，变为一个空格*/
    contOneSpace : function(str){
        str = this.trim(str);
        return str.replace(RegexpObj.oneSpace,' ');
    },
    getParmVal : function(parmName,url){

        var isArr = Object.prototype.toString.call(parmName) === '[object Array]',
            url_search,
            url = url ? url : location.href,
            url_search_temp,
            parmName_len,
            parmName_i = 0,
            parmName_key,
            split_one,
            parmV;

        if(!url || !parmName || typeof url !== 'string' || (typeof parmName !== 'string'  && !isArr)){
            console.log('传进的参数有问题,返回值为false');
            return false;
        }

        //url_search = url.split('?')[1].split('#')[0];
        url_search = url.split('?');

        if( url_search.length > 1 ){
            url_search = url_search[1].split('#')[0];
        }
        else{
            url_search = '';
        }

        if(!url_search){
            console.log('此url不带参数,返回值为false');
            return false;
        }

        split_one = function(){

            if(url_search.indexOf(parmName) !== -1){
                
                if(url_search.indexOf('&') !== -1){
                    url_search_temp = zxs_tools.splitParm(url_search,['&','=']);
                    parmV = url_search_temp[parmName];
                }
                else{
                    url_search_temp = url_search.split(parmName+'=')[1];
                    parmV = url_search_temp.split('&')[0];
                }

            }
            else{
                console.log('找不到该参数名,返回值为false');
                return false;
            }
        }

        
        // '?' 作为参数的值，或者url其他地方出现'?'下面的处理就会出错


        if(!isArr){


            if(parmName === 'all'){          
                parmV = zxs_tools.splitParm(url_search,['&','=']);
            }
            else{
                split_one();
            }
            
        }
        else{
            
            parmV = {};

            url_search_temp = zxs_tools.splitParm(url_search,['&','=']);

            parmName_len = parmName.length;

            for(;parmName_i < parmName_len;parmName_i++){
                parmName_key = parmName[parmName_i];
                if(!url_search_temp[parmName_key]){
                    console.log('找不到参数名:'+parmName_key);
                    continue;
                }
                parmV[parmName_key] = url_search_temp[parmName_key];
            }

            
            
        }


        return parmV;
        
    },
    /*
        通过分隔符来获取对应的参数名和值
    */
    splitParm : function(str,decollate){
        
        var isArr = Object.prototype.toString.call(decollate) === '[object Array]',
            splitFn,
            deepSplitFn,
            temp_arr = [],
            reg_str,
            len,
            key,
            val,
            parmObj = {};

        if(!decollate || (typeof decollate !== 'string' &&　!isArr )){
            return false;
        }

        splitFn = function(str,decollate){
            var temp_str = str.split(decollate);
            parmObj[temp_str[0]] = temp_str[1]; 

        };

        deepSplitFn = function(str_split,ind){

            var str_split_temp,
                str_split_temp_arr,
                str_split_temp_len,
                str_split_res,
                split_fh = decollate[len - ind],
                split_next_fh,
                str_split_temp_i = 0;
                

            if(ind > 1){
                
                str_split_temp = str_split.split(split_fh);

                str_split_temp_len = str_split_temp.length;

                split_next_fh = decollate[len - ind + 1];

                str_split_temp_arr = [].concat(str_split_temp);

                for(;str_split_temp_i < str_split_temp_len;str_split_temp_i++){
                    if(str_split_temp[str_split_temp_i].indexOf(split_next_fh) === -1){
                        str_split_temp_arr.splice(str_split_temp_i,1);
                    }
                }
               
               str_split_res = str_split_temp_arr.join('羴');

               deepSplitFn(str_split_res,--ind);

            }
            else{

                str_split_temp = str_split.replace(reg_str,'羴');

                str_split_res = str_split_temp.split('羴');

                str_split_temp_len = str_split_res.length;

                for(;str_split_temp_i < str_split_temp_len;str_split_temp_i+=2){
                    parmObj[str_split_res[str_split_temp_i]] = str_split_res[str_split_temp_i+1]
                }

                
            }

        };

        if(!isArr){
            splitFn(str,decollate);
        }
        else{
        

            len = decollate.length;

            reg_str = new RegExp(decollate[len-1],'g');

            deepSplitFn(str,len);

        }

        return parmObj

    },

    //找到对象中 id=3所在位置，在这个位置可以增删属性
    setObjVal : function(key,val,cb,data){

        var setKey = key,
            isBreck = false,
            setVal = val,
            doSome = cb;

        setDataAttt(data);

        function setDataAttt(data){
        
            if(isBreck){
                return;
            }


            if( isArray(data) ){

                var len = data.length,
                    i = 0;      

                for(;i<len;i++){

                    if(isBreck){
                        return;
                    }

                    setDataAttt(data[i]);
                }


            }
            else if( isObject(data) ){

                for( var key in data ){

                    if(isBreck){
                        return;
                    }

                    if( isArray(data[key]) || isObject(data[key]) ){
                        setDataAttt(data[key]);
                    }
                    else{

                        if( key === setKey && data[key] === setVal ){
        
                            doSome(data);
                            isBreck = true;
                            return; 

                        }

                    }

                }


            }



        }
    },

    //判断数组是否已经存在该值(每一条数据都不用对象包住)
    isInArrVal : function(arr,val){

        var len = arr.length,
            i = 0;

        for(;i < len; i++){

            if( arr[i] === val ){
                return true;
            }

        } 

        return false;

    },
    //判断数组是否已经存在该值(每一条数据都用对象包住)
    isInArrObjVal : function(arr,key,val){
        var len = arr.length,
            i = 0;

        for(;i < len; i++){

            if( arr[i][key] === val ){
                return true;
            }
        } 

        return false;
    },
    //判断数组是否已经存在该值(用于数字或字符串数字，区分不了数值和字符串类型)
    isInArr : function(arr,val){

        var str = ';' + arr.join(';') + ';',
            valStr = ';'+val+';';
          
      return str.indexOf(valStr) !== -1;

    },

    //通过元素的值来删除该元素(每一条数据都不用对象包住)
    delArrByVal : function(arr,val){

        var len = arr.length,
            i = 0;

        for(;i < len; i++){

            if( arr[i] === val ){
                arr.splice(i,1);
                break;
            }

        }    

    },
    //通过元素的值来删除该元素(每一条数据都用对象包住)
    delArrByObjVal : function(arr,key,val){

        var len = arr.length,
            i = 0;

        for(;i < len; i++){

            if( arr[i][key] === val ){ 
                arr.splice(i,1);
                break;
            }

        }    

    },
    //返回值在数组的索引 不在返回'none' (数组里面每一项用对象包住)
    getArrObjInd : function(arr,key,val){
        var len = arr.length,
            i = 0,
            ind = 'none';

        for(;i < len; i++){

            if( arr[i][key] === val ){
                return ind = i;
            }
        } 
        return ind;
    },
    //返回值在数组的索引 不在返回'none' (数组里面每一项不用对象包住)
    getArrInd : function(arr,val){
        var len = arr.length,
            i = 0,
            ind = 'none';

        for(;i < len; i++){

            if( arr[i] === val ){
                return ind = i;
            }

        } 
        return ind;
    },
    //简单数组转对象(数组的值为整数)
    arrToObj : function(arr){
        var o = {},
            i = 0,
            len = arr.length,
            val;

        for(;i<len;i++){
            val = arr[i];
            o[val] = val;
        }

        return o;

    },

    rander : {

        //传参数要改成 判断第一个参数是否为对象，复制这个对象，否则按参数个数取值
        randerSelect : function (arr,title,vKeyName,tKeyName,$el,selVal,selText){

            if( isArrary(arr) ){
                return;
            }

            var i = 0,
                len,
                til = title || '请选择',
                kVal = vKeyName || 'id',
                kTxt = tKeyName || 'name',
                str = '<option value="">'+til+'</option>';

            len = arr.length;

            for( ;i<len; i++){
                str += '<option value="'+arr[i][kVal]+'">'+arr[i][kTxt]+'</option>';
            }

            if( $el ){
                $el.html(str);

                if( selVal ){
                    $el.val(selVal);
                }
                else if( selText ){
                    $el.find("option:contains('"+selText+"')").prop("selected",true);
                }

            }
            else{
                return str;
            }
            
        }

    }, 

    //格式化数据和格式化显示效果
    formetter : {

        /**
         * 格式化层级的下拉框显示样子
         *
         *  arr 要渲染的数组 层级值必须为数值类型且从1开始  eg [{id : 3,name : '66',level : 1},{id : 7,name : '99',level : 2}]
         *  选填  title 第一个选项的文字                默认为 请选择
         *  选填  letter 格式显示用的字符               默认为 一个空格
         *
         *  选填  arrLevalKey 层级的属性名              默认为 level
         *  选填  arrValKey 每一项的值的属性名          默认为 id
         *  选填  arrTextKey 每一项显示文字的属性名     默认为 name
         *
         *  返回值 String
         */

        formatterPlatformId : function(arr,title,letter,arrLevalKey,arrValKey,arrTextKey){

            if( !isArray(arr) ){
                return '';
            }

            var til = title || '请选择',
                str = '<option value="">'+til+'</option>',
                len = arr.length,
                i = 0,
                len2,
                i2,
                lvKey = arrLevalKey || 'level',
                vlKey = arrValKey || 'id',
                txKey = arrTextKey || 'name',
                lett = letter || ' ',
                fh;

            for( ; i < len ;i++){

                fh = '';

                if( ( len2 = arr[i][lvKey] - 1 ) > 0 ){
                    i2 = 0;
                    for(;i2<len2;i2++){
                        //fh += '-- ';
                        fh += lett;
                    }

                }

                str += '<option value="'+arr[i][vlKey]+'">'+fh+arr[i][txKey]+'</option>';
            }

            return str;
        },
        /*格式化数组，按分隔符链接成一个字符串*/
        formatIndSrt : function(arr,separator){
            var sep = separator || ';';
            if(!type(arr,'array')){
                return '';
            }
            return sep+(arr.join(sep))+sep;
        },


    },

    check : {

        /*检查是否支持css3*/
        support_css3 : function(prop){
           var div = document.createElement('div'),
               vendors = 'Ms O Moz Webkit'.split(' '),
               len = vendors.length;
           
           if ( prop in div.style ) return true;
           
           prop = prop.replace(/^[a-z]/, function(val) {
              return val.toUpperCase();
           });
           
           while(len--) {
               if ( vendors[len] + prop in div.style ) {
                  return true;
               } 
           }
           return false;
        },
        /*是否原始值*/
        isPrimitive : function(value) {
          return (
            typeof value === 'string' ||
            typeof value === 'number' ||
            // $flow-disable-line
            typeof value === 'symbol' ||
            typeof value === 'boolean'
          )
        },
        /*判断是否为整数且不能为无穷值，可以用来判断是为数组的索引*/
        isValidArrayIndex : function(val) {
          var n = parseFloat(String(val));
          return n >= 0 && Math.floor(n) === n && isFinite(val)
        },
        //检测浏览器有没有开启flash，没开启有可能是没装flash
        checkFlashIsOpen : function(){
            var flag = false;
            var flashVersion = 0;　　 //flash版本
            if(window.ActiveXObject){
                try{
                    var swf = new ActiveXObject("ShockwaveFlash.ShockwaveFlash");
                    if(swf){
                        flag = true;
                    }
                }catch(e){}
            }else{
                try{
                    var swf = navigator.plugins['Shockwave Flash'];
                    if(swf){
                        flag = true;
                    }
                }catch(e){}
            }

            return flag;
        },
        //是是否是哪个浏览器
        whichBroser : function(version){
            var Browser = {
              ie6 : 'MSIE 6.0',
              ie7 : 'MSIE 7.0',
              ie8 : 'MSIE 8.0',
              ie9 : 'MSIE 9.0',
              ie10 : 'MSIE 10.0',
              ie11 : 'rv:11.0) like Gecko',
              edge : 'Edge',
              firefox : 'Firefox',
              chrome : 'Chrome',
              safari : 'Safari'
            },
            BroserVersion = navigator.userAgent,
            regx;

            if(!Browser[version]){
                return;
            }

            regx = new RegExp(Browser[version]);

            return regx.test(BroserVersion);
        },
        //判断是否是电脑端，是返回TURE
        isPc : function() {
            var userAgentInfo = navigator.userAgent,
                Agents = ["Android", "iPhone", "SymbianOS", "Windows Phone", "iPad", "iPod"],
                flag = true;
                
            for (var v = 0; v < Agents.length; v++) {
                if (userAgentInfo.indexOf(Agents[v]) > 0) {
                    flag = false;
                    break;
                }
            }
            return flag;
        },
        isIe : function(){  
            //edge 浏览器不包含在里面
            return !!window.ActiveXObject;
        }
        isEdge  : function(){
            return zxs_tools.check.whichBroser('edge');
        }

    },

    formCheck : {
        /*检查是否是中文*/
        isChinese : function(str){
            var s = ''+str;
            return RegexpObj.chinese.test(s);
        },
        /*是否为座机号*/
        isTelephone : function(s){
            var s = ''+s;
            return RegexpObj.telephone.test(s);
        },
        /*是否为手机号*/
        isPhone : function(s){
            var s = ''+s;
            return RegexpObj.phone.test(s);
        },
        /*是否为邮箱*/
        isEmail : function(s){
            var s = ''+s;
            return RegexpObj.email.test(s);
        },
        /*密码不能包含中文*/
        isPassword : function(s){
            var s = ''+s;
            return RegexpObj.password.test(s);
        },
        /*输入框只能是数字，不是数字就为空*/
        inputOnlyNum : function(jq_el){
            
            var val = jq_el.val();
            
            if(val.indexOf('.') !== -1){
                val = parseFloat(val);
            }
            else{
                val = parseInt(val);
            }

            if( isNaN(val)){
                val = '';
            }
            jq_el.val(val);
        },
        inputNumber : function re(v){
            var temp = v;
            temp = v.replace(/[^\d.]/g,'');

            var arr = temp.split('.');

            if(arr.length>0){
                arr[0] += '.';
                temp = arr.join('');
            }
            return temp;
        },
    },

    ObjectJoin : function(obj,letter){

        if( !isObject(obj) ){
            return;
        }

        var leter = letter || ' ',
            key,
            res = '';

        for( key in obj){
            res += obj[key] + letter;
        }

        if( letter && res.split(letter).length > 1 ){
            res = res.slice(0,-(letter.length));
        }

        return res;

    },

    fillLetter : function(num,length,letter){

        if( (!num && num != 0 ) || !length ){
            return;
        }

        var res = String(num),
            i = res.length,
            leter = letter || '0';

        for( ;i < length; i++){
            res = leter + res;
        }

        return res;

    },

    cumulative : function(arr,letter,end){

        if( !isArray(arr) ){
            return;
        }

        var len = arr.length,
            i = 0,
            fn,
            ys = letter || '+',
            over,
            res;

        if( end == 0 || end){
            over = end;
        }
        else{
            over = len;
        }

        switch(ys){

            case '+' :  res = 0;
                        fn = function(a){
                            res += a;
                        };
                break;

            case '*' :  res = 1;
                        fn = function(a){
                            res *= a;
                        };
                break;
        }

        for(;i<len;i++){
            fn( arr[i] );
            if( i == over){
                break
            }
        }

        return res;

    },
    showUseTime : function(beg,cur,fillObj){

        if(!beg){
            return;
        }

        var start = beg,
            now,
            timeNum,
            timeStr,
            f_key,
            isBreak = false,
            dateObj = {
                year : '',
                mouth : '',
                day : '',
                hour : '',
                minute : '',
                second : '',
                msec : ''
            },
            dateKey = ['msec','second','minute','hour','day','mouth','year'],
            level = [1000,60,60,24,30,12]; //30天算一个月

        if( isObject(fillObj) ){
            for( f_key in fillObj){
                dateObj[f_key] = fillObj[f_key];
            }
        }

        if( typeof beg === 'string' && ( beg.split('-').length > 1 || beg.split('/').length > 1  ) ){
            //转化为时间戳
            start = new Date(start).getTime();
        }

        if(cur){

            if( typeof cur === 'string' && ( beg.split('-').length > 1 || beg.split('/').length > 1  ) ){
                //转化为时间戳
                now = new Date(cur).getTime();
            }
            else{
                now = cur;                    
            }

        }
        else{
            now = 0;
        }

        if(now < start){
            timeNum = now;
            now = start;
            start = timeNum;
        }

        timeNum = now - start;

        function count(lev){

            if( isBreak || lev >= 7){
                return;
            }

            var temp = zxs_tools.cumulative(level,'*',lev),
                temp2,
                temp3 = lev > 0 ? zxs_tools.cumulative(level,'*',lev-1) : level[lev],
                key = dateKey[lev];

            if( timeNum >= temp ){
                count(lev+1);
            }

            temp2 = parseInt(timeNum / temp3);
            timeNum = timeNum % temp3;

            if(lev < 1){
                temp2 = zxs_tools.fillLetter(timeNum,3);
            }
            else if( lev < 4 ){
                temp2 = zxs_tools.fillLetter(temp2,2);
            }

            switch(lev){

                case 0 : dateObj[key] = temp2;
                    break;
                case 1 : dateObj[key] = temp2 + ' ';
                    break;
                case 2 : ;
                case 3 : dateObj[key] = temp2+':';
                    break;
                case 4 : dateObj[key] = temp2+'天 '; 
                    break;
                case 5 : dateObj[key] = temp2+'月 '; 
                    break;
                case 6 : dateObj[key] = temp2+'年 ';
                    break;
            }


        }

        count(0);

        return dateObj;  

    },
    /*
    *
     */
    randerUseTime : function(el,beg,cur,end){

        var data,
            hideMescond = true,
            timeStr,
            isOver = false,
            speed = 1000,
            timer;

        beg = (new Date(beg)).getTime();
        cur = (new Date(cur)).getTime();
        end = (new Date(end)).getTime();

        if(end < cur){
            isOver = true;
            cur = end;
        }

        function runder(){

            data = zxs_tools.showUseTime(beg,cur,{
                hour : '00:',
                minute : '00:'
            });
            timeStr = zxs_tools.ObjectJoin(data,'');

            if(hideMescond){
                timeStr = timeStr.slice(0,-4);
            }

            if(el.jquery){
                el = el[0];
            }

            el.innerHTML = timeStr;
        }

        runder();

        if(isOver){
            return;
        }

        timer = setInterval(function(){
            cur += speed;
            runder();
        },speed);


    },
    /**
     * 高性能的 重复填充字符串
     * @param  string lett  要重复的字符串
     * @param  number count 重复的次数
     * @return string
     *
     * 看看能不能把dofn单独抽出来
     */
    repeateStr : function (lett,count){

        if( !lett || typeof lett !== 'string' || !count ){
            conosle.log('%c 请检查入参','color:#f00');
            return '';
        }

        if(count === 1){
            return lett;
        }

        var str = '';

        function dofn(c){
            
            var depth = 1;
            var temp = lett;
            var end;

            while( c >= 2 ){ coo++;
                c = c / 2;
                temp += temp;     
                depth *= 2;
            }

            str += temp; 

            if(c > 1){
                end = (c - 1) * depth;

                if( end > 0 ){
                    dofn(end);
                }
            }

        }

        dofn(count);

        return str;
    },

    getWindowInfo : function(query){
        var api = {
            windowWidth : function(){
                //window 能显示网页内容 的宽度  或用 window.outWidth 一样的效果
                return window.innerWidth;
            },
            windowHeight : function(){
                //window 能显示网页内容 的高度  获取包含地址栏等的高度用 window.outHeight
                return window.innerHeight;
            },
            windowScrollTop : function(){
                //window 的滚动条距离顶部高度
                return $(window).scrollTop();
            },
            windowScrollLeft : function(){
                //window 的滚动条距离左边宽度
                return $(window).scrollLeft();
            },
            //获取操作系统的信息
            getOSInfo : function() {
                var ua = navigator.userAgent.toLowerCase(),
                    name,
                    version,
                    uaArray;

                if (_Lib.inObject(ua, 'android')) {
                    name = 'Android';
                } else if (_Lib.inObject(ua, 'iphone os') || _Lib.inObject(ua, 'ipad')) {
                    name = 'iOS';
                } else if (_Lib.inObject(ua, 'windows phone')) {
                    name = 'Windows Phone';
                } else if (_Lib.inObject(ua, 'windows nt')) {
                    name = 'Windows';
                } else if (_Lib.inObject(ua, 'linux')) {
                    name = 'Linux';
                } else if (_Lib.inObject(ua, 'macintosh')) {
                    name = 'OS X';
                };

                if (name == 'Windows') {
                    if (_Lib.inObject(ua, 'nt 5.1')) {
                        version = 'XP';
                    } else if (_Lib.inObject(ua, 'nt 5.2')) {
                        version = '2003';
                    } else if (_Lib.inObject(ua, 'nt 6.0')) {
                        version = 'Vista';
                    } else if (_Lib.inObject(ua, 'nt 6.1')) {
                        version = '7';
                    } else if (_Lib.inObject(ua, 'nt 6.2')) {
                        version = '8';
                    } else if (_Lib.inObject(ua, 'nt 10.0')) {
                        version = '10';
                    };
                } else if (name === 'iOS') {
                    uaArray = ua.split(';');
                    for (var i = 0, length = uaArray.length; i < length; i++) {
                        if (_Lib.inObject(uaArray[i], 'iphone os')) {
                            version = uaArray[i].split(' ')[4].replace(/_/g, '.');
                            break;
                        } else if (_Lib.inObject(uaArray[i], 'cpu os')) {
                            version = uaArray[i].split(' ')[3].replace(/_/g, '.');
                            break;
                        };
                    };
                } else if (name === 'Android') {
                    uaArray = ua.split(';');
                    for (var i = 0, length = uaArray.length; i < length; i++) {
                        if (_Lib.inObject(uaArray[i], 'android')) {
                            version = uaArray[i].split(' ')[2];
                            break;
                        };
                    };
                } else if (name === 'Windows Phone') {
                    uaArray = ua.split(';');
                    for (var i = 0, length = uaArray.length; i < length; i++) {
                        if (_Lib.inObject(uaArray[i], 'windows phone')) {
                            version = uaArray[i].split(' ')[3];
                            break;
                        };
                    };
                } else if (name == 'OS X') {
                    version = ua.split(' ')[6].slice(0, -1).replace(/_/g, '.');
                };
                return {
                    name : name,
                    version : version,
                    mobile : name === 'iOS' || name === 'Android' || name === 'Windows Phone' ? true : false
                };
            },






        }
    },
    /*
     * 获取得一个范围
     */
    getRange : function(min, max) {
        var range = max - min,
            rand = Math.random();
        return min + Math.round(rand * range);
    },
    /*获取文件名和扩展名*/
    getFileName : function(filePath,type){
        var fName,
            ind,
            extName;
        
        if( !publicIsType('string',filePath) ){
            return;
        }   
        
        ind = filePath.lastIndexOf('/');
        
        if(ind === -1){
            fName = filePath.split('.');
            if(fName.length >= 1){
                return;
            }
            extName = fName[1];
            fName = fName[0];
            
        }
        else{
            fName = filePath.slice(-ind).split('.');
            extName = fName[1];
            fName = fName[0];
        }
        
        if(type){
            return {fName:fName+'.'+extName,name:fName,ext:extName};
        }
        else{
            return fName+'.'+extName;
        }
 
    }

}
