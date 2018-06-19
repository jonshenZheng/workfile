let app = getApp(),
  rq = app.bzRequest,
  baseRqUrl = app.globalData.svr,
  common = require("../common/common.js"),
  baseImgUrl= app.globalData.baseImgUrl;

Page({
  data: {
    thumb: '',
    nickname: '',
    orders: [],
    canIUse: wx.canIUse('button.open-type.getUserInfo'),
    forceVisitorView: getApp().globalData.forceVisitorView
  },

  onLoad(options) {
    var self = this;

    common.injectData(this, options);

    wx.getSetting({
      success: function (res) {
        if (res.authSetting['scope.userInfo']) {
          // 已经授权，可以直接调用 getUserInfo 获取头像昵称
          wx.getUserInfo({
            success: function (res) {
              self.setData({
                thumb: res.userInfo.avatarUrl,
                nickname: res.userInfo.nickName
              })
            }
          })
        }
      }
    })

    wx.hideShareMenu();
  },
  onShow:function(){
    let that = this;
    if (this.data.isDataInjected) {
      this.startExpiryCountdownIfNecessary();
      this.requestNoBrowsedOrderCountIfNecessary();
      this.requestSalesAmountIfNecessary();
    } else {//当shop数据未准备好时，使用onDataInjected进行刷新购物车数据
      this.onDataInjected = ()=>{
        that.startExpiryCountdownIfNecessary();
        that.requestNoBrowsedOrderCountIfNecessary();
        that.requestSalesAmountIfNecessary();
      }
    }

    this.setData({
      forceVisitorView: wx.getStorageSync(app.globalData.forceVisitorViewStorageKey)
    })
  },
  onHide:function(){
    clearInterval(this.expiryCountdownHandler);
  },
  onShareAppMessage: (res) => {
    let data = getCurrentPages()[0].data;
    return {
      title: '[有人@我] 这里有十万款办公家具产品，简直太牛了',
      path: '/pages/index/index?shopId=' + data.shop.shopId,
      imageUrl: "https://baize-webresource.oss-cn-shenzhen.aliyuncs.com/weixin/image/share-myshop.png",
      success: (res) => {
        console.log("转发成功", res);
      },
      fail: (res) => {
        console.log("转发失败", res);
      }
    }
  }  ,
  /**
   * 启动分销商过期的倒计时，当用户是分销商角色且为试用
   */
  startExpiryCountdownIfNecessary: function () {
    if (this.data.role == this.data.ROLE_DISTRIBUTOR
      && this.data.distributorInfo.level == this.data.DIST_LV_ON_TRAIL) {
      let expiryDate = new Date(this.data.distributorInfo.expiryDate.replace(/\-/g, "/"));
      let that = this;
      this.expiryCountdownHandler = common.countdown(expiryDate, function (res) {
        that.data.distributorInfo.expiryCountdown= res

        that.setData({
          distributorInfo: that.data.distributorInfo
        });
        // console.log(that.data.expiryCountdown)
      });
    }
  },
  /**
   * 请求未浏览订单数，当是用户分销商 
   */
  requestNoBrowsedOrderCountIfNecessary: function () {
    if (this.data.role != this.data.ROLE_DISTRIBUTOR)
      return;// 只有分销商才有必要问未浏览订单数

    let lastReqTime = this.lastReqTimeOfNoBrowsedOrder;
    let curTime = new Date();
    if (lastReqTime && curTime - lastReqTime < 60000) //没超过60s则不进行请求
        return;
    this.lastReqTimeOfNoBrowsedOrder = curTime;//更新
    
    let that = this;
    rq({
      url: baseRqUrl + 'order/notBrowse',
      success: function (res) {
        that.setData({
          unbrowsedOrderCount: res.data.data
        })
      }
    })
  },
  /**
   * 请求分销商的销售额
   */
  requestSalesAmountIfNecessary: function () {
    if (this.data.role != this.data.ROLE_DISTRIBUTOR)
      return;// 只有分销商才有必要

    let lastReqTime = this.lastReqTimeOfSaleAmount;
    let curTime = new Date();
    if (lastReqTime && curTime - lastReqTime < 30000) //没超过30s则不进行请求
      return;
    this.lastReqTimeOfSaleAmount = curTime;//更新

    let that = this;
    rq({
      url: baseRqUrl + 'distri/salesAmount',
      success: function (res) {
        that.data.distributorInfo.salesAmount = res.data.data
        that.data.distributorInfo.salesAmountLocaleStr = res.data.data.toLocaleString()
        that.setData({
          distributorInfo: that.data.distributorInfo
        })
      }
    })
  },
  callkf: function () {
    let phone = this.data.shopOfView.servicePhone;//getApp().globalData.phoneNumKf;
    if(this.data.role == this.data.ROLE_DISTRIBUTOR)
      phone = getApp().globalData.phoneNumKf
    wx.makePhoneCall({
      phoneNumber: phone
    })
  },
  bindGetUserInfo: function (e) {
    console.log(e.detail.userInfo)
    this.setData({
      thumb: e.detail.userInfo.avatarUrl,
      nickname: e.detail.userInfo.nickName
    })
  },
  changeStoreView:function(e){
    let globalData = getApp().globalData;
    let flag = globalData.forceVisitorView = !globalData.forceVisitorView;
    wx.setStorageSync(globalData.forceVisitorViewStorageKey, flag);
    this.setData({
      forceVisitorView: flag
    });

    let msg = '成本价已显示，便于您了解商品销售利润'
    if (flag)
      msg = '成本价已隐藏，便于您面对面向客户展示'
    wx.showToast({
      icon: 'none',
      title: msg,
      mask: false
    })
  },
  onTapSetProfitBtn:function(e){
    if (this.data.distributorInfo.level == this.data.DIST_LV_ON_TRAIL
      && this.data.distributorInfo.expiryCountdown 
      && this.data.distributorInfo.expiryCountdown.isOver){
      this.showRegisterFormalModal('试用期到期，请注册成为正式分销商');
    }else
      wx.navigateTo({
        url: '../profitsetting/profitsetting',
      })
  },
  onTapShareShopBtn: function (e) {
    if (this.data.distributorInfo.level == this.data.DIST_LV_ON_TRAIL)
      this.showRegisterFormalModal('正式分销商才能分享店铺');
  },
  onTapShowQRCodeBtn: function (e) {
    if(this.data.role != this.data.ROLE_DISTRIBUTOR)
      return;

    if (this.data.distributorInfo.level == this.data.DIST_LV_ON_TRAIL)
      this.showRegisterFormalModal('正式分销商才能显示二维码');
    else
      rq({
        url: baseRqUrl+'shop/qrCode',
        success:function(res){
          let imgUrl = baseImgUrl + res.data.data
          wx.previewImage({
            current: imgUrl, // 当前显示图片的http链接
            urls: [imgUrl] // 需要预览的图片http链接列表
          })
        }
      })
  },
  showRegisterFormalModal: function (msg) {
    wx.showModal({
      title: '提示',
      content: msg,
      confirmText: '注册',
      cancelText: '取消',
      success: function (res) {
        if (res.confirm) {
          wx.navigateTo({
            url: '../registerStore/registerStore',
          })
        }
      }
    })
  }
})