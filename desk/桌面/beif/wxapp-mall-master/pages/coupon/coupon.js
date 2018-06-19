let app = getApp(),
  rq = app.bzRequest,
  baseRqUrl = app.globalData.svr,
  common = require("../common/common.js"),
  baseImgUrl = app.globalData.baseImgUrl;

Page({
  data: {
    isMuilt : false,
    arrTest : [
        {
            isSelect: false,
        },
        {
            isSelect: false,
        },
        {
            isSelect: false,
        },
        {
            isSelect: false,
        },
        {
            isSelect: false,
        },
        
    ],



    coupons: [],
    COUPON_STATUS_NOTHAVE: 0,//未领用
    COUPON_STATUS_HAVE: 1,//持有
    COUPON_STATUS_USED: 2,//已使用
    COUPON_STATUS_EXPIRED: 5,//过期
    COUPON_STATUS_CANCELD: 9,//作废
  },
  onLoad: function (options) {

    let that = this; 
    rq({
      url: baseRqUrl + 'coupon/list',
      success: function (res) {
        let data = res.data.data;
        that.setData({
          coupons: data
        })
      }
    })
  },

  confirmFn : function(data){

    let arr = data.detail.data, //arr为返回的优惠券数据
        handle = data.detail.handle;

    handle.hideCouponPop(); 

  }

})