let app = getApp(),
  baseURL = app.globalData.svr,
  isIphone = app.globalData.phoneInfo.system.indexOf('iOS') === -1 ? false : true;

/*首页banner跳转*/
function resolveCtrlProtoUri(uri) {

  console.log(uri);
  let idx = uri.search('://');
  let proto = uri.substring(0, idx);
  let body = uri.substring(idx + 3, uri.length);
  
  if (proto == 'wx-switchtab') {
    wx.switchTab({
      url: body,
    })
  } else if (proto == 'wx-webview') {
    if (wx.canIUse('web-view')) {

        let hasShare = '',
            shareTitle = '',
            pageTitle = '',
            temp,
            val;

        temp = body.split('?');
        body = temp[0];

        if(temp.length>1){
            temp = temp[1];

            if (temp.indexOf('hasShare=') !== -1){
                hasShare = temp.split('hasShare=')[1].split('&')[0];

                shareTitle = temp.split('shareTitle=');

                shareTitle = shareTitle.length > 1 ? shareTitle.split('&')[0] : '';
            }

            if (temp.indexOf('pageTitle=') !== -1) {
                pageTitle = temp.split('pageTitle=')[1].split('&')[0];
            }

        }

      wx.navigateTo({
          url: '../webview/webview?url=' + body + '&hasShare=' + hasShare + '&shareTitle=' + shareTitle + '&pageTitle=' + pageTitle,
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
function isRegister(backUrl, backWay, canBack = false) {

  let backToUrl = backUrl || '../index/index';

  /*判断是否注册*/
  var needRegPhoneNumKey = true;//wx.getStorageSync('needRegPhoneNumKey');

  if (needRegPhoneNumKey) {
    if (canBack) {
      wx.navigateTo({
        url: '../register/register?backUrl=' + backToUrl + '&backWay=' + backWay
      })
    }
    else {
      wx.redirectTo({
        url: '../register/register?backUrl=' + backToUrl + '&backWay=' + backWay
      })
    }

    return;
  }

}

/*拨打客服电话*/
function callKefu() {
  let pNumber = app.globalData.phoneNumKf;
  wx.showModal({
    content: '是否要拨打客服电话\n' + pNumber,
    success: function (r) {
      if (r.confirm) {
        wx.makePhoneCall({
          phoneNumber: pNumber,
        })
      }
    }
  })

}

function btnStartFn(self, n) {
  self.setData({
    btnff: n
  });
}

function btnEndFn(self) {
  self.setData({
    btnff: ''
  });
}

function checkImgExist(arr, key) {

  let baseUrl = app.globalData.baseImgUrl;

  if (!arr || typeof arr !== "object") {
    arr = setVal(arr);
    return arr;
  }

  let i = arr.length,
    v_i,
    fn,
    temp;

  function setVal(val) {
    let res;

    if (!val) {
      res = '../../image/noPic.png';
    }
    else {
      res = baseUrl + val;
    }
    return res;
  }


  if (key) {
    fn = function (arr, i, key) {
      arr[i][key] = setVal(arr[i][key]);
    };
  }
  else {
    fn = function (arr, i) {
      arr[i] = setVal(arr[i]);
    };
  }

  if (i < 1) {
    return
  }
  for (; i--;) {
    fn(arr, i, key);
  }
}

function loadimgfail(arr, e, objName, key, ctx) {
  let ind = e.currentTarget.dataset.imgind,
    setobj = {};

  if (e.detail.errMsg.indexOf('noPic.png') === -1) {
    arr[ind][key] = '../../image/noPic.png';

    setobj[objName] = arr;
    ctx.setData(setobj);
  }
}

/*获取本地缓存*/
function getSorageByPage(pageName, self) {

  if (!pageName || !self) {
    return '';
  }

  let pageStorage = wx.getStorageSync(pageName),
    setObj = {};

  if (!pageStorage) {
    return '';
  }

  let key;

  for (key in pageStorage) {
    setObj[key] = pageStorage[key];
  }

  self.setData(setObj);

  console.log(pageName + '已经设置缓存');

  return pageStorage;

}

/*设置本地缓存*/
function setStorageByPage(pageName, self, key, oldVal, newVal) {

  if (!pageName || !self || !key || oldVal == undefined || newVal == undefined) {
    return;
  }

  if (oldVal == '') {
    oldVal = {};
  }

  if (!looseEqual(oldVal[key], newVal)) {

    console.log('更新' + key);

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


function getFormatTime(type) {
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

  if (!type) {
    fullStr = year + "-" + month + "-" + day;
  }
  else if (type == 'show') {
    fullStr = year + '年' + month + '月' + day + '日';
  }
  else {
    spl = String(type);
    fullStr = year + spl + month + spl + day;
  }

  return fullStr;
}

//发送服务通知
function sentServerNotice(opt) {
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
    return /^1(3\d|99|98|66|47|(5[0-3|5-9])|(7[0|7|8])|(8[0-3|5-9]))-?\d{4}-?\d{4}$/.test(v);
  },
};

function trim(v){
    return v.replace(/^\s+|\s+$/g,'');
}

const ROLE_DISTRIBUTOR = "ROLE_DISTRIBUTOR";//分销商
const ROLE_VISITOR = "ROLE_VISITOR";//游客
const DIST_LV_ON_TRAIL = 0;//试用期分销商
const DIST_LV_EXPERIENCE = 10;//体验分销商

/**
 * 往vm里注入角色，shop等数据，这样的话能够方便地使用之进行条件渲染，或者进行逻辑判断。
 * 这里有个很霸道的约定，那就是假如传入的e里面有shopId，那么就认为是此时需要用访客身份来显示
 * ！！！建议本方法写在onLoad的第一行！！！
 * ！！！本方法无法保证同步地设置角色数据！！！
 * @param page - 传入的对象为wxpage;可以在page里添加相应的回调onRoleDataInjected
 * @param options - 传入page事件函数时的参数options
 */
function injectData(page, options) {
  let globalData = app.globalData;

  let role = globalData.role, 
    roleOfView = globalData.roleOfView, 
    shop = globalData.shop, 
    shopOfView = globalData.shopOfView,
    distributorInfo = globalData.distributorInfo,
    cb = ()=>{
      if (page.onDataInjected && typeof page.onDataInjected == "function")
        page.onDataInjected(options);
      page.setData({ isDataInjected: true });//标记为数据已注入
    };
  page.setData({ isDataInjected: false });//标记为数据未注入

  if(role){//已经登陆过，有了角色信息
    if (options && options.shopId) {// 传入了shopId，则强制设置roleOfView为访客.这里并没有判断是否是自己的shop
      roleOfView = ROLE_VISITOR;
      if (!options.noredirect) {// noredirect 不进行跳转店铺，用于保持全局视图不被更改
        globalData.roleOfView = roleOfView;
        globalData.forceVisitorView = true;//强制visitor
      }

      app.bzRequest({// 请求的商店信息data
        url: baseURL + 'watchedShop/' + options.shopId,
        method: 'PUT',
        success: function (r) {
          console.log("shop");
          console.log(r.data.data);
          shopOfView = r.data.data;
          if (shop) {
            page.setData({
              shop: shop,
              shopOfView: shopOfView,
            });
            page.version = shopOfView.shopId + '/' +shopOfView.priceVersion;//注入当前页面的版本
            if (!options.noredirect) {
              globalData.shopOfView = shopOfView;
            }
          }

          // 进行回调 这里的回调跟下面的回调只有一个会被执行
          cb();

          // 提示浏览他人店铺
          if(role == ROLE_DISTRIBUTOR && shopOfView.shopId != shop.shopId)
            wx.showModal({
              title: '您当前正在浏览他人店铺',
              content: '要返回自己店铺看看吗？',
              cancelText: '继续浏览',
              confirmText: '切换身份',
              success: function (res) {
                if (res.confirm) {
                  goBackToMyShop();
                } 
              }
            })
        }
      });
    } else {
      roleOfView = globalData.forceVisitorView ? ROLE_VISITOR : roleOfView;
    }

    // 设置数据
    page.setData({
      role: role,
      roleOfView: roleOfView,
      shop: shop,
      shopOfView: shopOfView,
      ROLE_VISITOR: ROLE_VISITOR, //注入这俩常量方便条件渲染时进行处理
      ROLE_DISTRIBUTOR: ROLE_DISTRIBUTOR
    });
    page.version = shopOfView.shopId+'/'+shopOfView.priceVersion;//注入当前页面的版本
    if (role == ROLE_DISTRIBUTOR || distributorInfo)//试用期过期变为游客，但还是有分销商信息
      page.setData({
        distributorInfo, distributorInfo,
        DIST_LV_ON_TRAIL: DIST_LV_ON_TRAIL,
        DIST_LV_EXPERIENCE: DIST_LV_EXPERIENCE
      })

    // 进行回调
    if (shop) {
      cb();
    }
  } else {//当未获得当前账号的角色，则进行登录
    console.log("不存在用户角色信息，进行登录");
    app.login(() => {
      console.log("登录完成，注入用户角色数据");
      injectData(page, options);
    })
  }
};
/**
 * 因为全局的forceVisitorView变动导致的必须要刷新roleOfView
 * 建议在onShow里面调用
 */
function updateRoleView(page){
  let data = page.data;
  if (data.role && data.roleOfView
    && data.role == ROLE_DISTRIBUTOR){//必须是分销商
    if (getApp().globalData.forceVisitorView)
      page.setData({
        roleOfView: ROLE_VISITOR
      });
    else if (data.distributorInfo.level == data.DIST_LV_ON_TRAIL
      &&data.distributorInfo.expiryCountdown
      && data.distributorInfo.expiryCountdown.isOver){//对于试用期分销商，那么假如它试用期过期就强制为visitor，todo使用服务器传来的过期数据来判断
      page.setData({
        roleOfView: ROLE_VISITOR
      });
      getApp().globalData.forceVisitorView = true
      wx.setStorage({
        key: getApp().globalData.forceVisitorViewStorageKey,
        data: true,
      })
    }
    else if(data.shop && data.shopOfView && data.shop.shopId == data.shopOfView.shopId)//只有自己的商铺才可以
      page.setData({
        roleOfView: ROLE_DISTRIBUTOR
      });
  }
}

/**
 * 给某一后缀缀上shop id
 */
function suffixUriWithShopId(page, uri) {
  let data = page.data;
  let newUri = uri;
  if (!data.isDataInjected)// 未注入数据，直接使用uri
    newUri = uri;
  else{
    if (data.role == ROLE_DISTRIBUTOR
      && data.distributorInfo.level == DIST_LV_ON_TRAIL
      && data.shopOfView.shopId == data.shop.shopId)//试用期分销商不能转自己的店铺，直接使用uri
      newUri = uri;
    else{
      if (uri.indexOf('?') > 0)
        newUri = uri + "&shopId=" + page.data.shopOfView.shopId;
      else
        newUri = uri + "?shopId=" + page.data.shopOfView.shopId;
    }
  }
  console.log('缀uri用shopId ', newUri);
  return newUri;
}

/**
 * cat1是cat2的子类或者cat1等价于cat2，严格模式则要求完全一致
 * 例如 
 * ('1.1.2', '1.1')=>true
 * ('1.1.2', '1.1', true)=>false
 * ('1.1', '1.1.2')=>false
 * ('1.1', '1.1', true)=>true
 * @param cat1 '1.1.2'
 * @param cat2 '1.1'
 * @param strict 是否严格相同
 */
function isSameCategory(cat1, cat2, strict){
  if(!cat1 || !cat2)
    return

  if(!cat1.endsWith('.'))
    cat1 = cat1 +'.'
  if (!cat2.endsWith('.'))
    cat2 = cat2 + '.'

  if (strict)
    return cat2==cat1
  return cat1.startsWith(cat2)
}

/**
 * 倒计时
 * @param toDate 倒计时日期
 * @param callback 每秒回调
 */
function countdown(toDate, callback){
  function countdownCore() {
    var leftTime = toDate - (new Date()); //计算剩余的毫秒数 
    var days = parseInt(leftTime * 1.1574074074074074074074074074074e-8, 10); //计算剩余的天数  leftTime / 1000 / 60 / 60 / 24
    var hours = parseInt(leftTime * 2.7777777777777777777777777777778e-7 % 24, 10); //计算剩余的小时 leftTime / 1000 / 60 / 60 % 24
    var minutes = parseInt(leftTime * 1.6666666666666666666666666666667e-5 % 60, 10);//计算剩余的分钟 leftTime / 1000 / 60 % 60
    var seconds = parseInt(leftTime * 0.001 % 60, 10);//计算剩余的秒数 leftTime / 1000 % 60

    callback({
      days: days,
      hours: hours,
      minutes: minutes,
      seconds: seconds,
      isOver: leftTime <= 0
    });
  } 
  countdownCore();//立即执行一遍
  return setInterval(countdownCore, 1000);
}

function goBackToMyShop(){

    
  let globalData = getApp().globalData;
  console.log('是否店铺视图', wx.getStorageSync(globalData.forceVisitorViewStorageKey))
  globalData.forceVisitorView = wx.getStorageSync(globalData.forceVisitorViewStorageKey) ? true : false;
  globalData.roleOfView = globalData.forceVisitorView ? ROLE_VISITOR : globalData.role;
  globalData.shopOfView = globalData.shop;
  wx.reLaunch({
    url: '../index/index'
  })


  
}

/**
 * 检查页面数据是否是脏数据
 * 假如页面已脏则调用callback
 * 总是会在page里记下version
 */
function checkPageDirty(page, callback){
  if (!page.data.isDataInjected)
    return;
  
  let shopId = page.data.shopOfView.shopId;
  let lastVersion = page.version;  
  app.bzRequest({
    url: baseURL + 'shop/price/version/' + shopId,
    success:function(res){
      let version = shopId + '/' + res.data.data
      console.log('last-version: ', lastVersion, ',version: ', version)
      if (lastVersion && lastVersion != version) {//当前页面有version信息并且与服务器上的不同
        callback();
      }
      page.version = version;
    }
  })
}


function commPhone(e){
    let phoneNum = e.currentTarget ? e.currentTarget.dataset.phonenum : '';

    if(phoneNum && phoneNum.length === 11){
        //安卓
        if (!isIphone) {
            wx: wx.showModal({
                content: phoneNum,
                showCancel: true,
                confirmText: '呼叫',
                confirmColor: '#489AF7',
                success: function (res) {

                    if(res.cancel){
                        return;
                    }

                    WX: wx.makePhoneCall({
                        phoneNumber: phoneNum,
                    })
                }
            })
        }
        //苹果
        else {
            WX: wx.makePhoneCall({
                phoneNumber: phoneNum,
            })
        }
    }
}



module.exports = {

  ROLE_DISTRIBUTOR: ROLE_DISTRIBUTOR,

  getFormatTime: getFormatTime,
  sentServerNotice: sentServerNotice,
  formCheck: formCheck,
  trim : trim,

  btnStartFn: btnStartFn,
  btnEndFn: btnEndFn,
  checkImgExist: checkImgExist,
  loadimgfail: loadimgfail,
  looseEqual: looseEqual,
  getSorageByPage: getSorageByPage,
  setStorageByPage: setStorageByPage,

  isRegister: isRegister,
  resolveCtrlProtoUri: resolveCtrlProtoUri,
  callKefu: callKefu,

  injectData: injectData,
  suffixUriWithShopId: suffixUriWithShopId,
  updateRoleView: updateRoleView,

  isSameCategory:isSameCategory,

  countdown: countdown,

  goBackToMyShop: goBackToMyShop,

  checkPageDirty: checkPageDirty,
  commPhone: commPhone
}

module.exports.resolveCtrlProtoUri = resolveCtrlProtoUri