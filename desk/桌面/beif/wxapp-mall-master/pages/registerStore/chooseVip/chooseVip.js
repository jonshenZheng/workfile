// pages/registerStore/choosePackage/choosePackage.js
let app = getApp(),
  rq = app.bzRequest,
  baseRqUrl = app.globalData.svr,
  baseImgUrl = app.globalData.baseImgUrl,
  common = require("../../common/common.js");

Page({

  /**
   * 页面的初始数据
   */
  data: {
    registryData: null,
    vipPackages: [],
    curIndex: 1, //当前选择的vip索引
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function(options) {
    let that = this;

    if (app.tmpData.registryData){
      this.setData({
        registryData: app.tmpData.registryData
      });
      app.tmpData.registryData = null;
    }

    // 请求vip套餐数据
    rq({
      url: baseRqUrl + 'vipPackage/buyList',
      method: 'GET',
      showLoading: true,
      success: function(res) {
        let vipPackages = res.data.data;
        for (var i = 0; i < vipPackages.length; i++)
          vipPackages[i].detailImage = baseImgUrl + vipPackages[i].detailImage
        that.setData({
          vipPackages: vipPackages
        })
      }
    });
  },

  onTap2ChooseVip: function(e) {
    let index = e.currentTarget.dataset.index;
    if (index == this.data.curIndex)
      return;

    this.setData({
      curIndex: index
    })
  },

  onTapOpenShopBtn: function(e) {

    let formId = e.detail.formId;

    let that = this;
    let data = this.data.registryData || {};
    let vipPackageId = this.data.vipPackages[this.data.curIndex].id;
    data.vipPackageId = this.data.vipPackages[this.data.curIndex].id; //选择的vip等级

    var tik = 0;
    let queryPaymentSuccess = function (tradeNo) { //需要一直查询是否购买成功
      wx.showLoading();
      rq({
        url: baseRqUrl + 'distri/pay/confirm/' + tradeNo,
        method: 'GET',
        success: function(res) {
          let success = res.data.data;
          if (success)
            that.onRegisterSuccess();
          else {
            if (tik > 600){
              wx.showToast({
                title: '请联系客服',
                icon: 'none'
              })
            }
            else {
              tik++;
              setTimeout(() => {
                queryPaymentSuccess(tradeNo);
              }, tik < 10 ? 1000 : 5000)
            }
          }
        }
      })
    }

    let requestPayment = function () {// 请求发起微信支付
      rq({
        url: baseRqUrl + 'distri/pay/' + vipPackageId,
        method: 'GET',
        success: function (res2) {
          let paymentData = res2.data.data;
          console.log(paymentData)
          wx.requestPayment({
            'timeStamp': paymentData.timeStamp,
            'nonceStr': paymentData.nonceStr,
            'package': paymentData.package,
            'signType': paymentData.signType,
            'paySign': paymentData.sign,
            success: function (res) {
              wx.showToast({
                title: '支付成功',
                icon: 'none'
              });
              setTimeout(() => {
                wx.showLoading();
                queryPaymentSuccess(paymentData.tradeNo);
              }, 1000);
            },
            fail: function () {
              wx.showToast({
                title: '支付失败',
                icon: 'none'
              });
            }
          })
        }
      })
    }

    // 这里区分是进行注册还是续费
    // >>注册的话会额外先发送开店，再请求支付
    // >>续费直接请求支付
    // >>>>请求完支付后，唤起wx支付，客户端支付成功，轮训服务器确认支付以及对应的biz完成
    if (this.data.registryData){// 第一次注册的话，需要带店铺数据提交给后台
      rq({
        url: baseRqUrl + 'shop/openShop',
        method: 'POST',
        data: data,
        success: function(res1) {
          console.log(res1.data.data)
          if(res1.data.data.pay){          
            requestPayment();// 需要付钱，则请求支付
          }else{
            that.onRegisterSuccess();// 否则直接跳转
          }
        },
        errorcb: function(r) {
          wx.showToast({
            title: r.data.meta.msg,
            icon: 'none'
          });
        }
      })
    }else{
      requestPayment();// 不是第一次注册，直接请求支付
    }
  },
  onRegisterSuccess: function() {
    wx.showToast({
      title: '成功',
      icon: 'none'
    });
    setTimeout(
      () => {
        wx.showLoading({
          title: '正在跳转到店铺',
        });
        getApp().login(() => {
          wx.reLaunch({
            url: '../../user/user',
          }) // 直接relaunch 防止任何意外
        }); //需要重新再登录一遍
      }, 500);
  }
})