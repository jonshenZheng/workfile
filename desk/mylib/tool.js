注意
/* '' == null            false
'' == undefined          false
false == null            false
false == undefined       false
0 == null                false
0 == undefined           false

NaN == ''                false
NaN == null              false
NaN == undefined         false
NaN == 0                 false
NaN == false             false
NaN == NaN               false

0 == ''                  true
undefined == null        true
'' == false              true
null和undefined是一个特殊的对象转化为布尔值true,NaN比较永远为false  */

/*常用方法*/
function isArray(v){
	return type(v,'array');
}
function isObject(v){
	return type(v,'object');
}

/*格式对象为一个字符串
* 必填 obj 要格式化的对象
* 选填 letter string类型 默认为一个空格
*/
function ObjectJoin(obj,letter){
	
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

}



/*是否原始值*/
function isPrimitive (value) {
  return (
    typeof value === 'string' ||
    typeof value === 'number' ||
    // $flow-disable-line
    typeof value === 'symbol' ||
    typeof value === 'boolean'
  )
}

/*判断是否为整数且不能为无穷值，可以用来判断是为数组的索引*/
function isValidArrayIndex (val) {
  var n = parseFloat(String(val));
  return n >= 0 && Math.floor(n) === n && isFinite(val)
}

function toString (val) {
  return val == null
    ? ''
    : is() typeof val === 'object'
      ? JSON.stringify(val, null, 2)
      : String(val)
}


/*去除首尾空格*/
function trim(str){
    return str.replace(RegexpObj.trim,'');
}

// 返回e很当前节点 后面缓存单例
function EvenFn(e,IsStopPreventDefault){
	var ev = e || window.e;

	//阻止事件传播
	if(e.stopPropagation){
		e.stopPropagation();
	}
	else{
		e.cancelBubble = true;
	}

	if(IsStopPreventDefault){
		if(e.preventDefault){
			e.preventDefault();
		}
		else{
			e.returnValue = false;
		}
		
	}

	return {
		e : e,
		el : e.currentTarget
	}

}


/*翻转字符串*/
function strReverse(str){
  return str.split('').reverse().join('');
}

/**
 * 获取某个字符在字符串出现的位置（从字符串末尾开始匹配，索引也是从字符串末尾开始）
 * str 字符串
 * v 要匹配的字符
 */
function lastIndexOfInd(str,v){
  
  var temp = strReverse(str),
      st;

  if(v.length > 1){
    st = strReverse(v);
  }    

  return temp.indexOf(st);

}

/*常用方法end*/


var RegexpObj = {
	num       : /^[+\-]?(\d+\.)?\d+$/,			//数字(不能匹配科学计数法eg:623.E12)
	num_z     : /^[+]?(\d+\.)?\d+$/, 			//正数
	num_f     : /^-(\d+\.)?\d+$/,				//负数
	num_int   : /^[+\-]?\d+$/,		        	//整数
	num_int_z : /^[+]?\d+$/,		        	//正整数
	num_int_f : /^-\d+$/,						//负整数
	date      : /^\d{4}-\d{1,2}-\d{1,2}$/,		//简单日期格式(缺少月数，和天数的的正确范围)
	trim      : /^\s+|\s+$/g,					//匹配到开头和末尾的空格，正则存在分组，没有g的话匹配到第一条分支就结束了。一般/^\s*((\S\s*\S*)+)\s*$/来匹配含有前后的空格的字符串，不是匹配空格，再用第一个括号的匹配到的文本进行替换到达去掉两边空格的效果。但不建议使用。匹配复杂，替换文本多都会耗时长
	oneSpace :　/\s{2,}/g,        				//匹配空格（至少两个空格，用来统一成一个空格）ie可能不支持，要看下JQ怎么写的
	chinese : /[\u4e00-\u9fa5]/,				//匹配中文
	email : /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+/,     //匹配邮箱
    password : /(^.*?[a-zA-Z]+.*?\d+.*?$)|(^.*?\d+.*?[a-zA-Z]+.*?$)/,  //密码不能为纯数字或纯英文且不能为中文
    phone : /^1[13456789][0-9]{9}$/,             //匹配手机号
    telephone : /^0\d{2,3}-?\d{7,8}$/,          //匹配固话（必须加区号）
    noIntNumber : /^0|\D/,                       //匹配非整数（填写表单的时候，用来去掉一些非整数的字符） 
    words : /[\u4e00-\u9fa5\s\w]/,			    //匹配数字空格大小写字母和中文
};


var easyLibEvent = {
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
};



var UiMethod = {

	//是哪个浏览器或版本
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
    },

	/*检查是否支持css3*/
	support_css3 :function(prop){
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
	//判断是否是电脑端，是返回TURE
	IsPC : function() {
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
	getWindowSize : function(){

		var hei,
			wid;

		if(window.innerHeight){
			wid = window.innerWidth;
			hei = window.innerHeight;
		}
		else if(document.documentElement){
			if(document.documentElement.clientWidth){
				wid = document.documentElement.clientWidth;
				hei = document.documentElement.clientHeight;
			}
		}

		return {width: wid,height : hei}

	}

};



var FormMethod = {

	/*ajax用来下载文件，可以带参数,参数data 的key为name名,value为值*/
	ajaxGetFile : function(opt){

		if(!type(opt,'object') || !opt.url){
			return
		}

		var form_dom = document.createElement('form'),
			input_dom = '',
			body_dom = document.getElementsByTagName('body')[0],
			temp = opt.data,
			key;

		form_dom.style.display = 'none';
		form_dom.target = '_blank';	
		form_dom.method = 'POST';
		form_dom.action = opt.url;

		if(opt.data){

			for(key in temp){

				if(opt.data.hasOwnProperty(key)){
					input_dom += '<input type="hidden" name="'+key+'"  value="'+temp[key]+'" />';
				}

			}

			form_dom.innerHTML = input_dom;
		}

		body_dom.appendChild(form_dom);

		form_dom.submit();

		body_dom.removeChild(form_dom);

	},
 

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

    /*获取密码强度*/

	/*//测试某个字符是属于哪一类
	function ckeckPwd_CharMode(iN) {
	   if (iN>=48 && iN <=57) //数字
	    return 1;
	   if (iN>=65 && iN <=90) //大写字母
	    return 2;
	   if (iN>=97 && iN <=122) //小写
	    return 4;
	   else
	    return 8; //特殊字符
	}
	//bitTotal函数
	//计算出当前密码当中一共有多少种模式
	function ckeckPwd_bitTotal(num) {
	   modes=0;
	   for (i=0;i<4;i++) {
	    if (num & 1) modes++;
	     num>>>=1;
	    }
	   return modes;
	}
	//sPW密码，len至少要达到的长度，默认为0
	//返回值false表示长度达不到，数值表示强度

	function ckeckPwd_checkStrong(sPW,len) {
	    var str_len = len || 0,
	        Modes = 0; 
	    
	    if (sPW.length < str_len){
	        return false; //密码太短
	    }
	        
	    
	    for (i=0;i<sPW.length;i++) {
	     //测试每一个字符的类别并统计一共有多少种模式
	     Modes|=ckeckPwd_CharMode(sPW.charCodeAt(i));
	   }
	   return ckeckPwd_bitTotal(Modes);
	}*/
	/*获取密码强度 end*/



};

var fileMethod = {

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
 
    },

};

var Method = {

	/* 初始化数组 
	*	arr 要初始化的数组
	* 	len 指定数组长度 
	*  	val 初始化的值
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

    /*格式化所有空格，变为一个空格*/
    contOneSpace : function(str){
        str = this.trim(str);
        return str.replace(RegexpObj.oneSpace,' ');
    },
    /*格式化数组，按分隔符链接成一个字符串*/
    formatIndSrt : function(arr,separator){
    	var sep = separator || ';';
    	if(!type(arr,'array')){
    		return '';
    	}
    	return sep+(arr.join(sep))+sep;
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
	/*
	    获取url中参数的值
	    parmName url参数名称，获取当个参数输入一个参数名的字符串即‘aa’，获取多个参数的值传个数组例如获取aa,bb的参数['aa','bb']
	*/
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

        url_search = url.split('?')[1].split('#')[0];

        if(!url_search){
            console.log('此url不带参数,返回值为false');
            return false;
        }

        split_one = function(){

            if(url_search.indexOf(parmName) !== -1){
                
                if(url_search.indexOf('&') !== -1){
                    url_search_temp = Method.splitParm(url_search,['&','=']);
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
                parmV = Method.splitParm(url_search,['&','=']);
            }
            else{
                split_one();
            }
            
        }
        else{
            
            parmV = {};

            url_search_temp = Method.splitParm(url_search,['&','=']);

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
	//通过多个索引来删除数组
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

            if( arr[i][key] === val ){ debugger
                arr.splice(i,1);
                break;
            }

        }    

    },
    //判断数组是否已经存在该值(用于数字或字符串数字，区分不了数值和字符串类型)
    isInArr : function(arr,val){

	var str = ';' + arr.join(';') + ';',
	valStr = ';'+val+';';

	return str.indexOf(valStr) !== -1;

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

	}
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




    
};

//运算
var operation = {

	/* 长度不够填充默认符号 （string）
	* 必填 num string或number类型 当前长度字符
	* 必填 length number类型 填充后最终长度
	* 选填 letter string类型  填充的字符 默认是'0'
	*/
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
	/* 累加或累乘数组 （number）
	* 必填 arr 要操作的数组
	* 选填 letter string类型 '+'表示累加 '*'表示累乘 默认是累加
	* 选填 end number类型 累加某个索引时结束（会将结束是索引计算到）默认是传入arr的长度
	*/
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

        }
	
	
	
};

//跟时间相关的
var time = {
	/*计算两段时间的隔了多久 （object）
	*
	*
	*
	*/
	showUseTime ：function (beg,cur,fillObj){

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
                    now = new Date(start).getTime();
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

                var temp = cumulative(level,'*',lev),
                    temp2,
                    temp3 = lev > 0 ? cumulative(level,'*',lev-1) : level[lev],
                    key = dateKey[lev];

                if( timeNum >= temp ){
                    count(lev+1);
                }

                temp2 = parseInt(timeNum / temp3);
                timeNum = timeNum % temp3;

                if(lev < 1){
                    temp2 = fillLetter(timeNum,3);
                }
                else if( lev < 4 ){
                    temp2 = fillLetter(temp2,2);
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

            return dateObj; //ObjectJoin(dateObj,'');

        },
	/* 递增显示与开始时间的时长 （无返回值）
	*
	*
	*
	*/
	randerUseTime : function(el,beg,cur){

            var data,
                hideMescond = true,
                timeStr,
                speed = 1000,
                timer;

            function runder(){

                data = showUseTime(beg,cur,{
                    hour : '00:',
                    minute : '00:'
                });
                timeStr = ObjectJoin(data,'');

                if(hideMescond){
                    timeStr = timeStr.slice(0,-4);
                }

                el.innerHTML = timeStr;

            }

            runder();

            timer = setInterval(function(){
                cur += speed;
                runder();
            },speed);


        }


};




//排序函数
var sortMethod = {

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
	quickSort : function(array){

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

}

function type(val,type){

	var ObjProtoStr =  Object.prototype.toString;
    
    if(!type || val != undefined ){
        return;
    }

	switch(type){
		/*数字(不能匹配科学计数法eg:623.E12)*/
		case 'num' 		:  	return RegexpObj.num.test(val);
			break;
		//正数
		case 'num_z' 	: 	return RegexpObj.num_z.test(val);
			break;
		//负数
		case 'num_f' 	:  	return RegexpObj.num_f.test(val);
			break;		
		//整数
		case 'num_int' 	:  	return RegexpObj.num_int.test(val);
			break;
		//正整数
		case 'num_int_z' :  	return RegexpObj.num_int_z.test(val);
			break;
		//负整数
		case 'num_int_f' :  	return RegexpObj.num_int_f.test(val);
			break;
		case 'array' 	:   return ObjProtoStr.call(val) === '[object Array]';	
			break;
		case 'boolean'	: 	return ObjProtoStr.call(val) === '[object Boolean]';
			break;
		//判断是不是日期对象而不是检测日期格式
		case 'date'	    : 	return ObjProtoStr.call(val) === '[object Date]'; 
			break;
		case 'regExp'	: 	return ObjProtoStr.call(val) === '[object RegExp]';
			break;
		case 'function'	: 	return ObjProtoStr.call(val) === '[object Function]';
			break;
		case 'object'	: 	return ObjProtoStr.call(val) === '[object Object]';
			break;			
	}
};

function isDate(val,onlyYYMM){
	var yy,
		mm,
		dd,
		temp,
		date;

	if(!onlyYYMM){
		if(!RegexpObj.date.test(val)){
			return false;
		}
	}

	
	if(onlyYYMM){
		temp = val.split('-');
		yy = parseInt(temp[0]);
		mm = parseInt(temp[1]);
		if( temp.length <= 1 && mm <= 0 && mm > 12){
			return false;
		}

		return {yy:yy,mm:mm}
	}


	temp = StrSplit(val,'date');
		
	if (temp){	

		yy = temp[0];
		mm = temp[1];
		dd = temp[2];

		if(mm>=12 && mm<=0){
			return false;
		}	

		date = getDayLen(yy,mm);
		return dd > 0 && dd <= date && {yy:yy,mm:mm,dd:dd};
		
	}
	else{	
		return false;
	}

}

function getDayLen(yy,mm){

	var day_len_arr = [31,28,31,30,31,30,31,31,30,31,30,31],
		len;

	len = day_len_arr[mm];

	//是二月份
	if(mm === 1){
		if((yy%4 === 0 && yy%100 !=0 ) || yy%400 === 0){
			//闰年
			len = 29; 
		}
	}

	return len;
}

function StrSplit(date,ops){
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

function DateSplit(val){

	var singleDate = [],//单独的某个日期
		rangeDate = [], //范围日期，索引单数为范围的开始，双数为范围的结束
		temp1Arr = [],
		temp1_len,
		temp2Arr = [],
		rangeB, //范围日期的开头
		rangeE, //范围日期的结束
		i = 0;

		tempArr = String(val).split(',');
		temp_len = tempArr.length;

	for (; i <= temp_len; i++) {
		//范围日期
		if(String(tempArr[i]).indexOf(' to ') !== -1){
			temp2Arr = tempArr[i].split(' to ');
			
			if(temp2Arr.length === 2 && (rangeB = isDate(temp2Arr[0])) && (rangeE = isDate(temp2Arr[1]))){
				//' to '前面的日期要小于后面的日期
				if(rangeB.mm>rangeE.mm){
					return false;
				}
				else if(rangeB.mm === rangeE.mm){
					if (rangeB.dd>=rangeE.dd){
						return false;
					}
				}
				rangeDate[rangeDate.length] = temp2Arr[0];
				rangeDate[rangeDate.length] = temp2Arr[1];
			}
		}
		else{
			if(isDate(tempArr[i])){
				singleDate[singleDate.length] = tempArr[i];
			}
		}
	}

	return {singleDate:singleDate,rangeDate:rangeDate};	
}

function each(obj,callback){
	var k,
		len;
	if(type(obj,'object')){
		for ( k in obj) {
			if(obj.hasOwnProperty(k)){
				callback(k,obj[k]); //不能这样写obj.k，调用时结果出现undefind
			}
		}
	}
	else if(type(obj,'array')){
		len = obj.length;
		for (k = 0; k < len; k++) {
			callback(k,obj[k]);
		}
	}
	else if(typeof obj === 'number'){
		len = obj;
		for (k = 0; k < len; k++) {
			callback(k);
		}
	}
}


function formatCName(str){
	//格式化字符串，去掉首尾空格，中两个以上的空格全部变为一个空格
	return str.replace(RegexpObj.trim,'').replace(RegexpObj.oneSpace,' ');
}

function trim(str){
	return str.replace(RegexpObj.trim,'');
}

//替换Jquery中的方法
function addClass(obj,cName){

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

}

function removeClass(obj,cName){

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

