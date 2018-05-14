// page/component/new-pages/user/user.js
Page({
  data:{
    thumb:'',
    nickname:'',
    orders:[],
    hasAddress:false,
    address:{}
  },
  onShow(){
    /*判断是否注册*/
    //commJS.isRegister('../user/user', 1);
  },
  onLoad(){
    var self = this;
    /**
     * 获取用户信息
     */
    wx.getUserInfo({
      success: function(res){
        self.setData({
          thumb: res.userInfo.avatarUrl,
          nickname: res.userInfo.nickName
        })
      }
    })

  },
  onShow(){
    
  },
  callkf : function(){

      let phone = getApp().globalData.phoneNumKf;
      wx.showModal({
          content: '是否拨打客服热线\n' + phone,
          success : function(r){
              if (r.confirm) {
                  wx.makePhoneCall({
                      phoneNumber: phone
                  })
              }
          }
      })
  }
})