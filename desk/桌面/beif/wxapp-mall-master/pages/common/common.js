let app = getApp();
/*首页banner跳转*/
function resolveCtrlProtoUri(uri) {
    
  console.log(uri);
  let idx = uri.search('://');
  let proto = uri.substring(0, idx);
  let body = uri.substring(idx + 3, uri.length);
  if(proto == 'wx-switchtab'){
    wx.switchTab({
      url: body,
    })
  } else if (proto == 'wx-webview'){
    if (wx.canIUse('web-view')){
      wx.navigateTo({
        url: '../webview/webview?url='+body,
      });
    }
  } else if (proto == 'wx-redirect') {
    wx.redirectTo({
      url: body,
    });
  } else if (proto == 'wx-navigate') {
    wx.navigateTo({
      url: body,
    });
  }
}

/*检查是否绑定手机*/
function isRegister(backUrl,backWay,canBack = false){

    let backToUrl = backUrl || '../index/index';
    
    /*判断是否注册*/
    var needRegPhoneNumKey = true;//wx.getStorageSync('needRegPhoneNumKey');
    
    if (needRegPhoneNumKey){
        if (canBack){
            wx.navigateTo({
                url: '../register/register?backUrl=' + backToUrl + '&backWay=' + backWay
            })
        }
        else{
            wx.redirectTo({
                url: '../register/register?backUrl=' + backToUrl + '&backWay=' + backWay
            })
        }
        
        return;
    }

}

/*拨打客服电话*/
function callKefu(){
    let pNumber = app.globalData.phoneNumKf;
    wx.showModal({
        content: '是否要拨打客服电话\n' + pNumber,
        success : function(r){
            if(r.confirm){
                wx.makePhoneCall({
                    phoneNumber: pNumber,
                })
            }
        }
    })

}

function btnStartFn(self,n) {
    self.setData({
        btnff: n
    });
}

function btnEndFn(self) {
    self.setData({
        btnff: ''
    });
}

function checkImgExist(arr,key) {

    let baseUrl = app.globalData.baseImgUrl;

    if (!arr || typeof arr !== "object") {
        arr = setVal(arr);
        return arr;
    }

    let i = arr.length,
        v_i,
        fn,
        temp;

    function setVal(val){
        let res;

        if(!val){
            res = '../../image/noPic.png';
        }
        else{
            res = baseUrl + val;
        }
        return res;
    }

    
    if(key){
        fn = function(arr,i,key){
            arr[i][key] = setVal(arr[i][key]);
        };
    }
    else{
        fn = function (arr,i) {
            arr[i] = setVal(arr[i]);
        };
    }

    if (i < 1) {
        return
    }
    for (; i--;) {
        fn(arr,i,key);
    }
}

function loadimgfail(arr,e,objName,key,ctx){
    let ind = e.currentTarget.dataset.imgind,
        setobj= {};

    if (e.detail.errMsg.indexOf('noPic.png') === -1) {
        arr[ind][key] = '../../image/noPic.png';

        setobj[objName] = arr;
        ctx.setData(setobj);
    }
}

/*获取本地缓存*/
function getSorageByPage(pageName,self){
    
    if (!pageName || !self){
        return '';
    }

    let pageStorage = wx.getStorageSync(pageName),
        setObj = {};

    if (!pageStorage){
        return '';
    }

    let key;

    for(key in pageStorage){
        setObj[key] = pageStorage[key];
    }

    self.setData(setObj);

    console.log(pageName+'已经设置缓存');

    return pageStorage;

}

/*设置本地缓存*/
function setStorageByPage(pageName, self,key,oldVal,newVal){

    if (!pageName || !self || !key || oldVal == undefined || newVal == undefined){
        return;
    }

    if (oldVal==''){
        oldVal = {};
    }
    
    if ( !looseEqual(oldVal[key], newVal) ){

        console.log('更新'+key);

        let setObj = {};
        setObj[key] = newVal;
        self.setData(setObj);
        oldVal[key] = newVal;
        wx.setStorageSync(pageName, oldVal);
    }


}

function isObject(obj) {
    return obj !== null && typeof obj === 'object';
}

function looseEqual(a, b) {
    if (a === b) { return true }
    var isObjectA = isObject(a);
    var isObjectB = isObject(b);
    if (isObjectA && isObjectB) {
        try {
            var isArrayA = Array.isArray(a);
            var isArrayB = Array.isArray(b);
            if (isArrayA && isArrayB) {
                return a.length === b.length && a.every(function (e, i) {
                    return looseEqual(e, b[i])
                })
            } else if (!isArrayA && !isArrayB) {
                var keysA = Object.keys(a);
                var keysB = Object.keys(b);
                return keysA.length === keysB.length && keysA.every(function (key) {
                    return looseEqual(a[key], b[key])
                })
            } else {
                /* istanbul ignore next */
                return false
            }
        } catch (e) {
            /* istanbul ignore next */
            return false
        }
    } else if (!isObjectA && !isObjectB) {
        return String(a) === String(b)
    } else {
        return false
    }
}


function getFormatTime(type){
    let nowDate = new Date(),
        year,
        month,
        day,
        temp,
        spl,
        fullStr;

    year = nowDate.getFullYear();
    temp = nowDate.getMonth() + 1;
    month = temp ? "0" + temp : temp;
    temp = nowDate.getDate();
    day = temp < 10 ? "0" + temp : temp;

    if (!type){
        fullStr = year + "-" + month + "-" + day;
    }
    else if(type == 'show'){
        fullStr = year + '年' + month + '月' + day + '日';
    }
    else{
        spl = String(type);
        fullStr = year + spl + month + spl + day;
    }

    return fullStr;
}

//发送服务通知
function sentServerNotice(opt){
    console.log(opt);
    let openIdNameKey = getApp().globalData.openIdNameKey;
    let oid = wx.getStorageSync(openIdNameKey);
    let rq = opt.rq;
    let pageInd = opt.pageInd;
    let formId = opt.formId;
    let emphasis_keyword = opt.emphasis_keyword || '';

    console.log('openID:' + oid);

    let template_id = opt.template_id;
    let data = opt.data;
    //发送服务通知

    rq({
        url: 'https://api.weixin.qq.com/cgi-bin/message/wxopen/template/send?access_token=' + opt.accessToken,
        data: {
            "touser": oid,
            "template_id": template_id,
            "page": pageInd,
            "form_id": formId,
            "data": data,
            "emphasis_keyword": emphasis_keyword
        },
        method: 'POST',
        header: {
            'content-type': 'application/json'
        },
        success: function (e) {
            console.log('发送服务通知成功');
        },
        fail: function (e) {
            console.log('发送失败');
        }
    });

}

//常用的表单检检查
let formCheck = {
    isPhone: function (v) {
        return /^1(3\d|47|(5[0-3|5-9])|(7[0|7|8])|(8[0-3|5-9]))-?\d{4}-?\d{4}$/.test(v);
    },
};

module.exports = {

    getFormatTime: getFormatTime,
    sentServerNotice: sentServerNotice,
    formCheck: formCheck,

    btnStartFn: btnStartFn,
    btnEndFn: btnEndFn,
    checkImgExist: checkImgExist,
    loadimgfail: loadimgfail,
    looseEqual: looseEqual,
    getSorageByPage: getSorageByPage,
    setStorageByPage: setStorageByPage,

    isRegister : isRegister,
    resolveCtrlProtoUri: resolveCtrlProtoUri,
    callKefu: callKefu
}

module.exports.resolveCtrlProtoUri = resolveCtrlProtoUri