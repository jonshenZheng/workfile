// page/component/buySuccess/buySuccess.js
let app = getApp();
Page({

    data: {
        Pagetype: '下订单',
    },
    onLoad: function (options){
      this.setData({
        servicePhone: options.servicePhone || getApp().globalData.phoneNumKf
      });

      if (options.pageType){
            this.setData({
              Pagetype: options.pageType
            });
            app.globalData.tempdata.refresh = true;
        }
    },
    connectUs : function(){
        wx.makePhoneCall({
            phoneNumber: this.data.servicePhone,
        })
    }
  
})