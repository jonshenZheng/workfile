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
    };

    if( isObject(arguments[1]) ){
        zxs_tools.mergeParm(data,opt,true);
    }
    else{
        
        data ? (opt.data = data) : '';
        isFunction(sucCb) ? ( opt.success = sucCb ) : ''; 
        isFunction(errCb) ? ( opt.error = errCb ) : ''; 
        isFunction(comCb) ? ( opt.complete = comCb ) : ''; 
    }

    $.ajax(opt);

}


var zxs_tools = {

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
                let = letter || ' ',
                fh;

            for( ; i < len ;i++){

                fh = '';

                if( ( len2 = arr[i][lvKey] - 1 ) > 0 ){
                    i2 = 0;
                    for(;i2<len2;i2++){
                        //fh += '-- ';
                        fh += let;
                    }

                }

                str += '<option value="'+arr[i][vlKey]+'">'+fh+arr[i][txKey]+'</option>';
            }

            return str;
        }


    },

    check : {

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
        whichBroser : function(version){
            var Browser = {
              ie6 : 'MSIE 6.0',
              ie7 : 'MSIE 7.0',
              ie8 : 'MSIE 8.0',
              ie9 : 'MSIE 9.0',
              ie10 : 'MSIE 10.0',
              FF : 'Firefox',
              Chrome : 'Chrome'
            },
            BroserVersion = navigator.userAgent,
            regx;

            if(!Browser[version]){
                return;
            }

            regx = new RegExp(Browser[version]);

            return regx.test(BroserVersion);
        }

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


    }


}
