/*常用方法*/
function isArray(v){
	return type(v,'array');
}
function isObject(v){
	return type(v,'object');
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
};




var UiMethod = {

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
	isPhone : function(s){
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

    /*去除首尾空格*/
    trim : function(str){
        return str.replace(RegexpObj.trim,'');
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
    }
    
};

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

function isDate(val){
	var yy,
		mm,
		dd,
		temp,
		date;

	if(!RegexpObj.date.test(val)){
		return false;
	}

	/*需要优化1(调用getYY_MM_DD)*/

	/*temp = (''+val).split('-');

	if (temp.length === 3){
		yy = parseInt(temp[0]);
		mm = parseInt(temp[1]);
		dd = parseInt(temp[2]);*/

	/*需要优化1 end*/

	temp = StrSplit(val,'date');
		
	if (temp){	

		yy = temp[0];
		mm = temp[1];
		dd = temp[2];

		if(mm>=12 && mm<=0){
			return false;
		}


	/*优化2(将判断是否是该年某月的正确天数改为获取该年某月的总天数，让函数利用率高)	*/
		/*switch(mm){
			case 1 : 
			case 3 :
			case 5 :
			case 7 :
			case 8 :
			case 10 :
			case 12 : date =  dd > 0 && dd <= 31;
				break;	
			case 4 : 
			case 6 :
			case 9 :
			case 11 :	
			case 3 : date =  dd > 0 && dd <= 30;
				break;	
			case 2 : 	if((yy%4 === 0 && yy%100 !=0 ) || yy%400 === 0){
							//闰年
							date =  dd >0 && dd <= 29;
						}
						date =  dd >0 && dd <= 28;
				break;
			default : return false;
		}

		return date && {yy:yy,mm:mm,dd:dd};*/
	/*优化2	end*/	

		date = getDayLen(yy,mm);
		return dd > 0 && dd <= date && {yy:yy,mm:mm,dd:dd};
		
	}
	else{	
		return false;
	}
}

function getDayLen(yy,mm){
	switch(mm){
		case 1 : 
		case 3 :
		case 5 :
		case 7 :
		case 8 :
		case 10 :
		case 12 : return 31;
			break;	//break在函数中无作用，由return直接退出
		case 4 : 
		case 6 :
		case 9 :
		case 11 :	
		case 3 : return 30;
			break;	
		case 2 : 	if((yy%4 === 0 && yy%100 !=0 ) || yy%400 === 0){
						//闰年
						return 29;
					}
					return 28;
			break;
		default : return undefined;
	}
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

