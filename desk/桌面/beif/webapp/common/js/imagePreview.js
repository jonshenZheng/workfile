//检查图片的格式是否正确,同时实现预览
function setImagePreview(obj, localImagId, imgObjPreview,ExtFileTypy,defaultImg,isUpload) {
    var array = ['gif', 'jpeg', 'png', 'jpg', 'bmp'],
    	ExtFileTypy = ExtFileTypy || [];//可以上传的文件类型
    if(ExtFileTypy.length){
    	array = ExtFileTypy.concat(array);
    }
     
    if (obj.value == '') {
        alert("让选择要上传的图片!");
        return false;
    }
    else {
        var fileContentType = obj.value.match(/^(.*)(\.)(.{1,8})$/)[3]; //这个文件类型正则很有用 
        ////布尔型变量
        var isExists = false;
        //循环判断图片的格式是否正确
        for (var i in array) {
            if (fileContentType.toLowerCase() == array[i].toLowerCase()) {
            	
            	if( ExtFileTypy[i] ){
            		imgObjPreview.src = defaultImg;
            		return true;
            	}
            	
            	if(isUpload){
            		window.top.showHomeLoading();
            		$.ajaxFileUpload({
        	            url: addprodUploadOBj.url, //用于文件上传的服务器端请求地址
        	            secureuri: false, //是否需要安全协议，一般设置为false
        	            fileElementId: 'sereachImgInp', //文件上传域的ID
        	            dataType: 'application/json', //返回值类型 一般设置为json

        	            contentType: "application/json; charset=utf-8",
        	            success: function (data, status){  //服务器成功响应处理函数
        	            	
        	            	var $el = $(obj);
        	            	
        	            	
        	            },
        	            error: function (data, status, e){//服务器响应失败处理函数
        	                   	            	
        	            	if( data.responseText.indexOf('a damaged picture') !== -1){
        	            		alert('请上传正确的图片的格式');
        	            	}
        	            	else{
        	            		alert('搜索失败');	
        	            	}

        	            },
        	            complete : function(){
        	            	window.top.hideHomeLoading();
        	            }
        	        }); 
            		
            	}
            	
            	
                //图片格式正确之后，根据浏览器的不同设置图片的大小
                if (obj.files && obj.files[0]) {
                    //火狐下，直接设img属性 
                    imgObjPreview.style.display = 'block';
                    /*imgObjPreview.style.width = '200px';
                    imgObjPreview.style.height = '200px';*/
                    //火狐7以上版本不能用上面的getAsDataURL()方式获取，需要一下方式 
                    imgObjPreview.src = window.URL.createObjectURL(obj.files[0]);
                }
                else {
                    //IE下，使用滤镜 
                    obj.select();
                    var imgSrc = document.selection.createRange().text;
                    //必须设置初始大小 
                    localImagId.style.width = "400px";
                    localImagId.style.height = "400px";
                    //图片异常的捕捉，防止用户修改后缀来伪造图片 
                    try {
                        localImagId.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale)";
                        localImagId.filters.item("DXImageTransform.Microsoft.AlphaImageLoader=").src = imgSrc;
                    }
                    catch (e) {
                        alert("上传图片类型不正确! 可上传("+array.join(',')+")");
                        obj.value = "";
                        return false;
                    }
                    imgObjPreview.style.display = 'none';
                    document.selection.empty();
                }
                isExists = true;
                return true;
            }
        }
        if (isExists == false) {
            //alert("上传图片类型不正确! 可上传('gif', 'jpeg', 'png', 'jpg', 'bmp')");
        	alert("上传图片类型不正确! 可上传("+array.join(',')+")");
            //document.getElementById("idFile").value = "";
        	obj.value = "";
            return false;
        }
        return false;
    }
}