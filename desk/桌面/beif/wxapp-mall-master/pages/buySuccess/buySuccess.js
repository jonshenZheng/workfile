// page/component/buySuccess/buySuccess.js
let app = getApp();
Page({

    data: {
        Pagetype: '下订单',
        phoneNum: getApp().globalData.phoneNumKf
    },
    onLoad : function(d){

        if(d.pageType){
            this.setData({
                Pagetype : d.pageType
            });
            app.globalData.tempdata.refresh = true;
        }
    },
    connectUs : function(){
        wx.makePhoneCall({
            phoneNumber: this.data.phoneNum,
        })
    }
  
})