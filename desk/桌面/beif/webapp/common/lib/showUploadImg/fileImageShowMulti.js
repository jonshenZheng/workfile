function getFunctionName(fn){
    var str = String(fn);

    str = str.split('(')[0].split(' ');

    return str[str.length-1];
}


function loadFn(s,v){
	var t;
	if( s.hasownproperty = '' ){
		s = window;
	}
	else{
		if(s){
			t = v;
		}
		else{
			t = window[v] ? s : v;
		}

		if(!docEl){
            docEl = showMianDoc;
        }
		
		s['ext'] = docEl[v];
		
	}

}


var docEl;


function PreviewImageRemove(self,vlb){

	var that = $(self),
		/*$imgBox = that.parents('.imgBox'),
		$otherImgBox,
		$inpBox = $imgBox.siblings('.addImgBtn'),
		$inp = $inpBox.find('input'),
		inpLen,
		i = 0,
		ind = $imgBox.data('index'),
		temp,
		name = $imgBox.data('name'),*/
		strEl = {kk:'',cc:0};
	
	//删除展示的图片和对应的输入框
	/*$imgBox.remove();
	$inp.eq(ind).remove();*/

	/*function cb(){
		
		$imgBox.remove();
		$inp.eq(ind).remove();
		//更新展示图片和输入框的索引
		$inp = $inpBox.find('input');
		inpLen = $inp.length;
		$otherImgBox = $inpBox.parent().find('.imgBox');
		for(;i<inpLen;i++){
			
			if(i !== (inpLen-1)){
				$otherImgBox.eq(i).data('index',i);
			}

			temp = name+'['+i+']';
			$inp.eq(i).attr('name',temp);
			
		}
	}*/
	
	loadFn(strEl,vlb);
	
	if(strEl.ext){
		strEl.ext.dofn(that);
	}
	else{
		cb();
	}
	
}

//跟之前做的功能结合下，判断类型给默认图片

function previewImg_tpl(img_src,ind,isLowBroser,inpName,variableName){

    var tpl = '';

    if(isLowBroser){
        tpl += '<div class="imgBox" data-index="'+ind+'" data-name="'+inpName+'" >';
            tpl += '<img src="'+img_src+'" alt="" style="display:none"/>'
            tpl += '<i class="delImg_ico" onclick="PreviewImageRemove(this,\''+variableName+'\')"></i>';
        tpl += '</div>';
    }
    else{
        tpl += '<div class="imgBox" data-index="'+ind+'" data-name="'+inpName+'">';
            tpl += '<img src="'+img_src+'" alt="" />';
            tpl += '<i class="delImg_ico" onclick="PreviewImageRemove(this,\''+variableName+'\')"></i>';
        tpl += '</div>';
    }

    return tpl;
    
}


var addDom;

//上传多张图片
    //fileObj 触发节点本身（字面量为this）必须有的参数
    /*
        //limit     图片张数限制            默认为10    类型数字
        //width     图片宽度                默认为200   类型数字    
        //height    图片高度                默认为100   类型数字
        //isMulti   预览单张还是多张        默认是单张  类型布尔
        //creatBefor 生成预览图片的要执行的函数       类型函数        
    */
   
//不好的地方是每次新增图片都要带重复的参数如limit,isMulti,previewImg_tpl
function PreviewImage(fileObj,limit,isMulti,tpl,inpName,variableName) {

    if(!fileObj.value){
        return;
    }

    var allowExtention,
        extention,
        browserVersion,
        //addDom,
        $self = $(fileObj),
        isLowBroser = false,
        str = '',
        isMulti = isMulti ? isMulti : false,
        tpl_FnName,
        limit = limit || 10,
        /*width = width || 200,
        height = height || 100,*/
        ind = $self.parent().find('input').length,
        tempImgsrc,
        $parent,
        $img,
        img_len,
        i,
        formName,
        repeatImg,
        uploadOpt;
    

    tpl_FnName = getFunctionName(tpl);

    docEl = showMianDoc;
    
    repeatImg = function(imgObj,len){
        
        for (i = len; i--;) {
            if(imgObj.eq(i).attr('src') === tempImgsrc){

            	clearFileVal(fileObj,browserVersion);
                alert('请不要重复上传');
                /*fileObj.value = ""; 
                if (browserVersion.indexOf("MSIE") > -1) {
                    fileObj.select();
                    document.selection.clear();
                    fileObj.blur();
                }*/
                return;
            }
        }

        return true;

    };

    addDom = function(imgsrc){

        var $imgBox,
            newPreview_js,
            $inserTpl,
            tempDivPreview;

        if(isLowBroser){
            tempImgsrc = fileObj.value;
        }
        else{
            tempImgsrc = imgsrc;
        }

        //去重复图片
        if(!repeatImg($img,img_len)){
            return;
        };

        // 模板参数化
        str = previewImg_tpl(imgsrc,ind-1,isLowBroser,inpName,variableName);

        $inserTpl = $(str);

        if($parent.length){
            if(isMulti){
                $parent.before($inserTpl);
            }
            else{
                $imgBox = $parent.siblings('.imgBox');
                if($imgBox.length === 0){
                    $parent.before($inserTpl);
                }
                else{
                    $imgBox.eq(0).replaceWith($inserTpl);
                }
            }
        }

        if(isLowBroser){
            newPreview_js = document.createElement("div");
            newPreview_js.style.width = "48px";  //这里宽高最好获取图片的实际宽高来给
            newPreview_js.style.height = "27px";
                    
            newPreview_js.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod='scale',src='" + imgsrc + "')";
            
            $inserTpl.append(newPreview_js);
        }

        ind++;

        if(isMulti){
            $self.hide();

            if(inpName){
            	formName = 'name="'+inpName+'['+(ind-1)+']'+'"';
            }
            else{
            	formName = '';
            }

            str = '<input '+formName+' accept="image/*" style="filter:alpha(opacity=1)" onchange="PreviewImage(this,'+limit+','+isMulti+','+tpl_FnName+',\''+inpName+'\',\''+variableName+'\');" class="uploadImg-inp" type="file">';
            $self.parent().append(str);
        }

    };


    allowExtention = ".jpg,.bmp,.gif,.png"; //允许上传文件的后缀名document.getElementById("hfAllowPicSuffix").value;
    extention = fileObj.value.substring(fileObj.value.lastIndexOf(".") + 1).toLowerCase();
    browserVersion = window.navigator.userAgent.toUpperCase();

    if(browserVersion.indexOf("MSIE 9") > -1 || browserVersion.indexOf("MSIE 8") > -1){
        isLowBroser = true;
    }
    
    $parent = $self.parent('.addImgBtn');
    $img = $parent.parent().find('.imgBox img');
    img_len = $img.length;
    
    //图片张数限制
    if(img_len >= limit){
    	clearFileVal(fileObj,browserVersion);
        alert('图片不能超过'+limit+'限制');
        /*fileObj.value = ""; 
        if (browserVersion.indexOf("MSIE") > -1) {
            fileObj.select();
            document.selection.clear();
            fileObj.blur();
        }*/
        return;
    }
        
    if (allowExtention.indexOf(extention) > -1) {
        	
        if(variableName){

        	uploadOpt = window[variableName];
        	if( Object.prototype.toString.call(uploadOpt) === '[object Object]'){
        		uploadOpt.PreviewImage_file = fileObj;
        		uploadOpt.PreviewImage_browserVersion = browserVersion;
        		uploadOpt.filesEl = fileObj;
        		asynUpload(uploadOpt);
        	}

        }	
        else{
        	showPreViewImg(fileObj,browserVersion);
        }

    } 
    else {
    	clearFileVal(fileObj,browserVersion);
        alert("仅支持" + allowExtention + "为后缀名的文件!");
    }
    return fileObj.value;    //返回路径

}

function clearFileVal(fileObj,browserVersion){
	fileObj.value = ""; //清空选中文件
    if (browserVersion.indexOf("MSIE") > -1) {
        fileObj.select();
        document.selection.clear();
    }
}


var showMianDoc = this;

function showPreViewImg(fileObj,browserVersion){

	if (fileObj.files) {//HTML5实现预览，兼容chrome、火狐7+等
        if (window.FileReader) {
            var reader = new FileReader();
            reader.onload = function (e) {
                addDom(e.target.result);
            }
            reader.readAsDataURL(fileObj.files[0]);
        } else if (browserVersion.indexOf("SAFARI") > -1) {
            alert("不支持Safari6.0以下浏览器的图片预览!");
        }
    } 
    else if (browserVersion.indexOf("MSIE") > -1) {
        if (browserVersion.indexOf("MSIE 6") > -1) {//ie6
            addDom(fileObj.value);
        } 
        else {//ie[7-9]
            fileObj.select();
            if (isLowBroser){
                fileObj.blur(); //不加上document.selection.createRange().text在ie9会拒绝访问
            }

            addDom(document.selection.createRange().text);                
        }
    } 
    else if (browserVersion.indexOf("FIREFOX") > -1) {//firefox
        var firefoxVersion = parseFloat(browserVersion.toLowerCase().match(/firefox\/([\d.]+)/)[1]);
        if (firefoxVersion < 7) {//firefox7以下版本
            addDom(fileObj.files[0].getAsDataURL());

        } else {//firefox7.0+
            addDom(window.URL.createObjectURL(fileObj.files[0]));
        }
    } 
    else {
        addDom(fileObj.value);
    }

}



function asynUpload(opt){

	if(Object.prototype.toString.call(opt) !== '[object Object]'){
		return;
	}
	
	if(typeof opt.before === 'function'){
		opt.before(opt);
	}

    if(opt.PreviewImage_file.value === ''){
        return;
    }

	$.ajaxFileUpload({
        url: opt.url, //用于文件上传的服务器端请求地址
        secureuri: false, //是否需要安全协议，一般设置为false
        fileElementId: opt.filesEl, //文件上传域的ID
        dataType: 'application/json', //返回值类型 一般设置为json
        data : opt.data,
        parmObj : opt,
        contentType: "application/json; charset=utf-8",
        success: function (data, status){  //服务器成功响应处理函数

            if(data === 'error' || !data){
                clearFileVal(opt.placeEl,opt.PreviewImage_browserVersion);
                return;
            }

            var datas = {
                data : {}
            };

            datas.data = JSON.parse(data);

            showPreViewImg(opt.PreviewImage_file,opt.PreviewImage_browserVersion);
            if(typeof opt.success === 'function'){
                //opt.success(datas,status,opt.PreviewImage_file);
                opt.success(datas,status,opt.placeEl);
            }

        	/*var res,
	    		datas,
	    		dataInd;

	    	dataInd = data.indexOf('{');
	     
	    	if(dataInd < 0){
	    		return;
	    	}
	
			res = data.slice(dataInd,-6);	
			datas = JSON.parse(res);
	   	
        	if(datas.meta && datas.meta.code === 200){
        		showPreViewImg(opt.PreviewImage_file,opt.PreviewImage_browserVersion);
        		if(typeof opt.success === 'function'){
            		//opt.success(datas,status,opt.PreviewImage_file);
                    opt.success(datas,status,opt.placeEl);
            	}
        	}
        	else{
        		//clearFileVal(opt.PreviewImage_file,opt.PreviewImage_browserVersion);
                clearFileVal(opt.placeEl,opt.PreviewImage_browserVersion);
        	}*/
         	
        },
        error: function (data, status, e){//服务器响应失败处理函数
        	//clearFileVal(opt.PreviewImage_file,opt.PreviewImage_browserVersion);
            clearFileVal(opt.placeEl,opt.PreviewImage_browserVersion);
        	if(typeof opt.error === 'function'){
        		opt.error(data,status);
        	}
        	console.log(e);
        	/* console.log(data);
        	console.log(status);
        	console.log(e); */
        },
        complete : function () {
            if(typeof opt.complete === 'function'){
                opt.complete();
            }
        }

    }); 

}