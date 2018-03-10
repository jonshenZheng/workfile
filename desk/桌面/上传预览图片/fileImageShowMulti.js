function getFunctionName(fn){
    var str = String(fn);

    str = str.split('(')[0].split(' ');

    return str[str.length-1];
}




function PreviewImageRemove(e){

    /*var e = e || window.event,
        $wp,
        $self,
        $parent,
        list_len,
        $list,
        i;

    if(e.stopPropagation){
        e.stopPropagation();
    }
    else{
        e.cancelBubble = true;
    }

    $self = $(this);

    $wp = $self.parents('.list-width');

    $parent = $self.parents('.enclosure-upload-img');

    $parent.find('.addimg ').remove();

    $wp.remove();*/

    //1重置附件序号 2可选是预览多张还是单张


}

//跟之前做的功能结合下，判断类型给默认图片
//


function previewImg_tpl(img_src,ind,isLowBroser){

    var tpl = '';

    if(isLowBroser){
        tpl += '<div class="imgBox" data-index="'+ind+'">';
            tpl += '<img src="'+img_src+'" alt="" style="display:none"/>'
            tpl += '<i class="delImg_ico" onclick="PreviewImageRemove()"></i>';
        tpl += '</div>';
    }
    else{
        tpl += '<div class="imgBox" data-index="'+ind+'">';
            tpl += '<img src="'+img_src+'" alt="" />';
            tpl += '<i class="delImg_ico" onclick="PreviewImageRemove()"></i>';
        tpl += '</div>';
    }

    return tpl;
    
}


//上传多张图片
    //fileObj 触发节点本身（字面量为this）必须有的参数
    /*
        //limit     图片张数限制            默认为10    类型数字
        //width     图片宽度                默认为200   类型数字    
        //height    图片高度                默认为100   类型数字
        //isMulti   预览单张还是多张        默认是单张  类型布尔
    */
   
//不好的地方是每次新增图片都要带重复的参数如limit,isMulti,previewImg_tpl
function PreviewImage(fileObj,limit,isMulti,tpl) {

    if(!fileObj.value){
        return;
    }

    var allowExtention,
        extention,
        browserVersion,
        addDom,
        $self = $(fileObj),
        isLowBroser = false,
        str = '',
        isMulti = isMulti ? isMulti : false,
        tpl_FnName,
        limit = limit || 10,
        /*width = width || 200,
        height = height || 100,*/
        ind = $self.data('inpind'),
        tempImgsrc,
        $parent,
        $img,
        img_len,
        i,
        repeatImg;

    tpl_FnName = getFunctionName(tpl);

    repeatImg = function(imgObj,len){
        
        for (i = len; i--;) {
            if(imgObj.eq(i).attr('src') === tempImgsrc){
                alert('请不要重复上传');

                fileObj.value = ""; 
                if (browserVersion.indexOf("MSIE") > -1) {
                    fileObj.select();
                    document.selection.clear();
                    fileObj.blur();
                }

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
        str = previewImg_tpl(imgsrc,ind,isLowBroser);

        $inserTpl = $(str);

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

        if(isLowBroser){
            newPreview_js = document.createElement("div");
            newPreview_js.style.width = "48px";  //这里宽高最好获取土片的实际宽高来给
            newPreview_js.style.height = "27px";
                    
            newPreview_js.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod='scale',src='" + imgsrc + "')";
            
            $inserTpl.append(newPreview_js);
        }

        ind++;

        if(isMulti){
            $self.hide();
            str = '<input name="" data-inpInd="'+ind+'" style="filter:alpha(opacity=1)" onchange="PreviewImage(this,'+limit+','+isMulti+','+tpl_FnName+');" class="uploadImg-inp" type="file">';
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

        alert('图片不能超过'+limit+'限制');
        fileObj.value = ""; 
        if (browserVersion.indexOf("MSIE") > -1) {
            fileObj.select();
            document.selection.clear();
            fileObj.blur();
        }

        return;
    }
        
    if (allowExtention.indexOf(extention) > -1) {
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
    else {
        alert("仅支持" + allowExtention + "为后缀名的文件!");
        fileObj.value = ""; //清空选中文件
        if (browserVersion.indexOf("MSIE") > -1) {
            fileObj.select();
            document.selection.clear();
        }

    }
    return fileObj.value;    //返回路径

}