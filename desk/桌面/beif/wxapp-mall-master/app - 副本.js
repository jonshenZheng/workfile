

App({

  recordCallMallFn: function () {
    let that = this,
      baseUrl = that.globalData.svr;
    //一天只发一次，用本地记录一次操作的时间
    let lastDayTimeStampNameKey = 'lastDayTimeStampNameKey';
    let lastDayTstemp = wx.getStorageSync(lastDayTimeStampNameKey);
    let timeStemp = new Date().getTime();

    function recordCallMall() {
      that.bzRequest({
        url: baseUrl + 'callMall',
        withoutToken: false,
        method: 'PUT'
      });
    }

    if (!lastDayTstemp || (timeStemp - lastDayTstemp) >= 86400000) {

      wx.setStorageSync(lastDayTimeStampNameKey, timeStemp);
      setTimeout(function () {
        recordCallMall()
      }, 100);

    }

  },

  onLaunch:function(){
    let that = this;
    // 读取配置数据--是否强制显示访客视图
    let forceVisitorView = wx.getStorageSync(this.globalData.forceVisitorViewStorageKey);
    this.globalData.forceVisitorView = forceVisitorView ? true : false;

    let sysInfo = wx.getSystemInfoSync();
    this.globalData.phoneInfo = sysInfo;

    if (!this.globalData.isCancleAdapter){

        //判断是需要适配
        let that = this;  

        // if (sysInfo.model === "iPhone X") {
        //     that.globalData.needAdapter = true;
        // }
        if ((sysInfo.screenHeight / sysInfo.screenWidth) > 1.8){
            that.globalData.needAdapter = true;
        }
        
    }
  },

  onShow: function () {
    let that = this,
      baseUrl = that.globalData.svr;
    console.log('App Show check wx session...')
    wx.checkSession({
      success: function () {//session 未过期，并且在本生命周期一直有效        
        console.log('wx session 未过期')

        let globalData = that.globalData;
        let bNeedLogin = false;

        // 检查globalData是否含有有token，shop,role等关键数据
        if (!globalData.token) {// || !globalData.shop || !globalData.role
          console.log('找不到token/shop/role等数据，需要重新登录');
          bNeedLogin = true;
        }

        // 检查上一次版本号是否跟当前的一致
        let lastVersionNameKey = globalData.lastVersionNameKey;
        let lastbuilding = wx.getStorageSync(lastVersionNameKey);
        let building = globalData.version;
        if (!lastbuilding || lastbuilding !== building) {
          console.log('版本号不一致，需要重新登录');
          wx.setStorageSync(lastVersionNameKey, building);
          bNeedLogin = true;
        }

        if (bNeedLogin)
          getApp().login();
      },
      fail: function () {
        console.log('wx session 过期')
        getApp().login()
      }
    }
    )

    that.recordCallMallFn();
  },
  onHide: function () {
    console.log('App Hide')
  },
  globalData: {
    appName: '办公袋',
    baseImgUrl: 'http://baize-webresource.oss-cn-shenzhen.aliyuncs.com/',
    //baseImgUrl: 'http://dev-baize-webresource.oss-cn-shenzhen.aliyuncs.com/',
    hasLogin: false,
    loginLock: false,
    phoneNumKf: '020-87917217',
    // svr: 'http://192.168.0.111:8080/wxapp/',
    // svr: 'https://192.168.0.115:8443/mall/wxapp/',
    //svr: 'https://192.168.0.114:8081/mall/wxapp/',
    // svr: 'https://192.168.0.100:443/wxapp/lxh/',
    //svr: 'https://192.168.0.100:443/wxapp/lgr/',
    // svr: 'https://100mall.baizeai.com/wxapp/lxh/',
    // svr: 'https://100mall.baizeai.com/wxapp/lgr/',
    // svr: 'https://mall.baizeai.com/wxapp/',
     svr: 'https://mall.baizeai.com/test/wxapp/',
    version: '2.2.0', 
    token: null,
    needRegPhoneNumKey: 'needRegPhoneNumKey',
    needNikeNameKey: 'needNikeNameKey',
    openIdNameKey: 'openIdNameKey',
    lastVersionNameKey: 'lastVersionNameKey', //lastBuildingNameKey: 'lastBuildingNameKey',
    lastDayTimeStampNameKey: 'lastDayTimeStampNameKey',
    tempdata: {},
    searchResult: [],
    searchResultId: '',
    shop: null,//商店
    shopOfView:null,//商店
    role: null, // 用户的角色
    roleOfView: null, // 用户的角色
    forceVisitorView: false,
    forceVisitorViewStorageKey: "forceVisitorView", // 强制访客视图
    goCategoryInd : null,//从首页进某一个分类
    isCancleAdapter : true, //是否取消适配全面屏
    needAdapter: false, //该手机是否要适配
    shareTitle: '[有人@我] 这里有十万款办公家具产品，简直太牛了', //页面转发标题
    indexRecommendsId : 'none', //首页爆款替换Id
    phoneInfo : {}, //储存设备信息
  },
  setPageGlobalDataFn: function (curPageObj) {

      let needSetVal = ['needAdapter'],
          that = this,
          v;

      let getV = function (arr) {

          let len = arr.length,
              i = 0,
              obj = {},
              key;

          if (!len || !curPageObj || typeof curPageObj !== 'object') {
              return {}
          }

          for (; i < len; i++) {
              key = arr[i];
              obj[key] = that.globalData[key];
          }

          return obj;
      }

      v = getV(needSetVal);
      curPageObj.setData(v);
  },

  setPageGlobalDataFn: function (pageHandle){

     // 将全局属性添加到所有页面上

      let obj = this.globalData;

      for(key in obj){
          pageHandle[key] = obj[key];
      }   
  
  },
   
  //给每个页面设置公用的方法
  setCommonFn: function (pageHandle){
      let commJs = require('pages/common/common.js'),
          methodName = ['commPhone'],
          i = 0,
          key = '',
          len = methodName.length;

      for(;i<len;i++){
          key = methodName[i];
          pageHandle[key] = commJs[key];
      }

  },
  pageBeforeLoadRun:function(pageHandle){
    //要在每个页面onload前执行的
    this.setPageGlobalDataFn(pageHandle);
    this.setCommonFn(pageHandle);
  },
  tmpData:{},
  SentNickName: function (v) {

    let that = this,
      baseUrl = that.globalData.svr;

    if (v) {
      return
    }

    fn();

    function fn() {

      wx.getUserInfo({
        success: function (res) {
          /* var userInfo = res.userInfo
          var nickName = userInfo.nickName
          var avatarUrl = userInfo.avatarUrl
          var gender = userInfo.gender //性别 0：未知、1：男、2：女
          var province = userInfo.province
          var city = userInfo.city
          var country = userInfo.country*/
          let edata = res.encryptedData,
            iv = res.iv,
            dat = { encryptedData: edata, iv: iv },
            needNikeNameKey = getApp().globalData.needNikeNameKey;

          that.bzRequest({
            url: baseUrl + 'updateMallUser',
            data: JSON.stringify(dat),
            method: 'PUT',
            withoutToken: false,
            success: function (r) {
              if (r.meta && r.meta.code == 200) {
                wx.setStorageSync(needNikeNameKey, true);
              };
            }
          });

        }
      })
    }
  },
  loginCallbackBuffer:[],
  login: function (cb) {
    let that = this;

    if (cb)
      that.loginCallbackBuffer.push(cb);//因为加入了登陆锁，所以这里将登陆回调进行缓冲

    if (getApp().globalData.loginLock) {
      return;
    }
    getApp().globalData.loginLock = true;

    try {
      console.log('进行登录')
      const server = getApp().globalData.svr
      const needRegPhoneNumKey = getApp().globalData.needRegPhoneNumKey
      let needNikeNameKey = getApp().globalData.needNikeNameKey;
      wx.login({
        success: function (res) {
          if (res.code) {
            //发起网络请求
            console.log('发起登录请求\nwx-code:' + res.code)
            wx.request({
              url: server + 'login',
              data: {
                code: res.code
              },
              success: function (res2) {
                if (res2.data.meta.code == 200) {
                  console.log("登录成功 ");
                  console.log(res2.data.data);
                  let globalData = getApp().globalData;
                  let resData = res2.data.data;

                  //保存OpenID
                  let openIdNameKey = globalData.openIdNameKey;
                  let openid = wx.getStorageSync(openIdNameKey);
                  if (!openid) {
                    wx.setStorageSync(openIdNameKey, resData.openId);
                  }

                  // 保存token
                  let token = resData.token;
                  let needRegPhoneNum = !resData.regPhoneNum;
                  globalData.token = token;
                  wx.setStorageSync(needRegPhoneNumKey, needRegPhoneNum);

                  // 用户角色
                  globalData.roleOfView = globalData.role = resData.role || "ROLE_VISITOR";

                  // 用户关注的商店
                  globalData.shopOfView =globalData.shop = resData.watchedShop || {};

                  // 分销商信息
                  globalData.distributorInfo = resData.distributorInfo;

                  // 设置中间红标，文本
                  if (globalData.role == "ROLE_VISITOR") {
                    wx.setTabBarItem({
                      index: 2,
                      text: '获取报价'
                    })
                  } else {
                    wx.setTabBarItem({
                      index: 2,
                      text: '销售线索'
                    })
                    wx.showTabBarRedDot({
                      index: 2
                    });
                  } 
                  
                  // 执行回调
                  while (that.loginCallbackBuffer.length > 0){
                    let callback = that.loginCallbackBuffer.shift();
                    try {
                      callback(res2);
                    }catch(err){
                      console.log(err)
                    }
                  }

                  // 发送账号信息 todo 应该不能放在这个地方
                  let hasNikename = !!res2.data.data.nickName;
                  wx.setStorageSync(needNikeNameKey, hasNikename);

                  // todo 现在wx需要通过button来进行授权了
                  // wx.getSetting({
                  //   success(res) {
                  //     if (!res.authSetting['scope.userInfo'] || !hasNikename) {
                  //       wx.authorize({
                  //         scope: 'scope.userInfo',
                  //         success: function () {
                  //           //第一次授权的时候发送更多个人信息给后台
                  //           that.SentNickName(hasNikename);
                  //         }
                  //       })
                  //     }
                  //   }
                  // })
                } else {
                  console.log('登录失败')
                }
              },
              complete: function () {
                getApp().globalData.loginLock = false;
              }
            })
          } else {
            console.log('获取用户登录态失败！\n' + res.errMsg)
            getApp().globalData.loginLock = false;
          }
        },
        fail: function () {
          getApp().globalData.loginLock = false;
        }
      }) //重新登录
    }
    catch (e) {
      getApp().globalData.loginLock = false;
    }

  },
  /**
   * 针对wxrequest的一个wrap,会主动将通过login获取的bz服务器的session存进请求中,同时当session过期时进行更新
   * USAGE:
   * getApp().bzRequest({url:'http://127.0.0.2:8080/',data:{'d1':1},complete:function(res){console.log(123)}})
   */
  bzRequest: function (OBJECT) {

    let h = OBJECT['header'] || {};

    function loadfail(msg) {
      let mesg = msg || '请求失败';
      wx.showModal({
        content: mesg,
        showCancel: false
      })
    }

    function wxRq() {
      let showLoading = OBJECT.showLoading,
        defualtErr = {
          data: {
            meta: {
              code: 500,
              msg: '发送请求失败'
            }
          }
        };

      if (showLoading)
        wx.showLoading({ mask: true });

      if (h['Authorization'])
        console.log('发送请求-->' + OBJECT.url + '\ntoken:' + h['Authorization'])
      else
        console.log('发送请求-->' + OBJECT.url)

      wx.request({
        url: OBJECT.url,
        data: OBJECT.data,
        header: h,
        method: OBJECT.method,
        dataType: OBJECT.dataType,
        responseType: OBJECT.responseType,
        success: function (res) {
          if (res.data.meta && res.data.meta.code == 200) {
            if (typeof OBJECT.success == 'function')
              OBJECT.success(res);
          }
          else if (res.data.meta && res.data.meta.code != 401) {

            if (typeof OBJECT.errorcb == 'function') {
              let err = res.data.meta ? res : defualtErr;
              OBJECT.errorcb(res);
            }
            else {

              if (OBJECT.noErrorLog) {
                return;
              }

              if (res.data.meta) {
                loadfail(res.data.meta.msg);
              }
              else {
                loadfail('发送请求失败');
              }

            }
          }

        },
        fail: function () {
          if (OBJECT.fail != null)
            OBJECT.fail();

          if (typeof OBJECT.errorcb == 'function') {
            OBJECT.errorcb(defualtErr);
          }
          else {

            if (OBJECT.noErrorLog) {
              return;
            }

            loadfail('发送请求失败');
          }

        },
        complete: function (res) {
          console.log(OBJECT.url + '\n返回-->')
          console.log(res)

          if (showLoading)
            wx.hideLoading();

          if (OBJECT.complete != null)
            OBJECT.complete(res)
          //token过期则更新token
          //这里默认服务器的token过期通过返回值来中带有token字段来表示

          if (res.statusCode == 401) {
            let token = res.header.Authorization;

            if (token) {
              console.log('旧token过期,更新token为\n' + token);
              getApp().token = token;
              getApp().bzRequest(OBJECT)//重新请求
            }
            else {
              getApp().login();
            }
          }

        },
      })
    }

    if (OBJECT.withoutToken) {// 不需要带token
      wxRq();
      return;
    } else {//需要带token
      const bzToken = getApp().globalData.token;

      if (bzToken && bzToken.trim() != '') {//判断是否需要登录
        h['Authorization'] = bzToken;
        wxRq();
      }
      else {
        console.log(OBJECT.url+' token为空,进行登录')
        getApp().login(() => {
          getApp().bzRequest(OBJECT);
        })//假设由于如清缓存等原因导致存储的token消失了,再登一遍
      }
    }
  }
})
