let app = getApp(),
  rq = app.bzRequest,
  baseRqUrl = app.globalData.svr,
  common = require("../../common/common.js");

Page({
  data: {
    getCodeText: 0,
    hideInp: false,
    registryData: {},
  },
  onLoad(options) {
    common.injectData(this, options);
  },
  onDataInjected: function (opt) {
    let that = this;
    if (this.data.role == this.data.ROLE_DISTRIBUTOR) {
      if (this.data.distributorInfo.level != this.data.DIST_LV_ON_TRAIL) {
        wx.showLoading({
          title: '跳转到您的店铺',
        })
        setTimeout(function () {
          wx.hideLoading();
          wx.reLaunch({
            url: '../../user/user',
          });
        }, 1000)
      }
    }
  },
  callKf: function () {
    wx.makePhoneCall({
      phoneNumber: app.globalData.phoneNumKf
    })
  }

})