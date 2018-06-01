var orderHost,
	orderPrc,
	baseUrl,
    baseImgUrl_dev = 'http://dev-baize-webresource.oss-cn-shenzhen.aliyuncs.com/',
	baseImgUrl = 'http://baize-webresource.oss-cn-shenzhen.aliyuncs.com/',
	baseImgUrl2 = 'https://baize-webresource.oss-cn-shenzhen.aliyuncs.com/';


(function(){

	var url = window.top.location.href;
	var fuhao = '://';
	var ind = url.indexOf('://');
	
	url = url.slice(0,ind) + '^0^' + url.slice(ind+3);
	url = url.split('/');
	
	orderHost = url[0]+'/';
	
	if( orderHost.indexOf(':') !== -1 ){
		orderPrc = url[1]+'/';
	}
	else{
		orderPrc = '';
	}

	if(orderPrc === 'home/'){
        orderPrc = '';
	}

	orderHost = (url[0]+'/').replace('^0^','://');
	
	baseUrl = orderHost+orderPrc;

})();


/*var orderHost = 'http://localhost:8080/',
	//orderHost = 'http://192.168.0.115:8443/',
	//orderHost = 'http://192.168.0.114:8082/',
    //orderHost = 'http://shenqi-internal.baizeai.com/';
	orderPrc = 'bzms/',
    //orderPrc = '',
	baseImgUrl = 'http://baize-webresource.oss-cn-shenzhen.aliyuncs.com/',
	baseUrl = orderHost+orderPrc;
	//baseUrl = 'http://shenqi-internal.baizeai.com/';*/

function fullPath(path){
	return baseUrl+path;
}


